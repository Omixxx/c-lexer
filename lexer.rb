require "code-lexer"
require "json"
require("csv")

require_relative("OutputCsv")

def convert(method)
  java_lexer = CodeLexer.get("java")
  abstractor = CodeLexer::Abstractor.new.abstract_strings.abstract_numbers.abstract_indentations.abstract_spaces
  lexed_before = java_lexer.lex(method)
  stream_before = lexed_before.token_stream(abstractor).to_s
  return stream_before.gsub("¬", "$").downcase
end

def process(file_path)
  file_content = File.read(file_path)
  data_hash = JSON.parse(file_content)
  abstract_method = convert(data_hash["method"])
  output_csv = OutputCsv.new(
    data_hash["name"],
    data_hash["startLine"],
    data_hash["endLine"],
    data_hash["classPath"],
    data_hash["readabilityScore"],
    data_hash["label"],
    data_hash["method"],
    abstract_method,
    "",
    ""
  )
  return output_csv
end

def explore_path(path)
  output_csv_list = []

  if File.directory?(path)
    entries = Dir.entries(path) - [".", ".."]
    entries.each do |entry|
      entry_path = File.join(path, entry)
      if File.directory?(entry_path)
        output_csv_list.concat(explore_path(entry_path))
      else
        output_csv_list << process(entry_path)
      end
    end
  else
    output_csv_list << process(path)
  end

  return output_csv_list
end

if ARGV.empty? or
    ARGV.length > 1
  puts("Usage: ruby lexer.rb <project_path>")
  exit
end

argv = ARGV

list = []
list = explore_path(argv[0].to_s)

csv_struct = []
csv_struct <<
  [
    "name",
    "startLine",
    "endLine",
    "classPath",
    "readabilityScore",
    "label",
    "original_method",
    "abstract_method",
    "model_prediction",
    "manual_flag"
  ]

list.each do |output_csv|
  csv_struct <<
    [
      output_csv.name,
      output_csv.startLine,
      output_csv.endLine,
      output_csv.classPath,
      output_csv.readabilityScore,
      output_csv.label,
      output_csv.original_method,
      output_csv.abstract_method,
      output_csv.model_prediction,
      output_csv.manual_flag
    ]
end

CSV.open("output.csv", "w") do |csv|
  csv_struct.each do |row|
    csv << row
  end
end

## creiamo i csv, selezioniamo la t4 gpu, spm -> vocabolario del modello con cui il modello fa la scelta piu probabile,
## name, startLine, endLine, classPath, readabilityScore, label, original_method, abstract_method, model_prediction, manula_flag(vuot)
