require 'code-lexer'
require 'json'
require('csv')

require_relative('Output')

def convert(method)
  java_lexer = CodeLexer.get('java')
  abstractor = CodeLexer::Abstractor.new.abstract_strings.abstract_numbers.abstract_indentations.abstract_spaces
  stream_before = ''
  begin
    lexed_before = java_lexer.lex(method)
    stream_before = lexed_before.token_stream(abstractor).to_s
    stream_before = stream_before.gsub('¬', '$').downcase
  rescue StandardError
    raise 'Error in lexer, method too long'
  end

  stream_before
end

def process(file_path)
  file_content = File.read(file_path)
  data_hash = JSON.parse(file_content)
  puts("Processing: #{data_hash['name']}")
  abstract_method = convert(data_hash['method'])
  Output.new(
    data_hash['name'],
    data_hash['startLine'],
    data_hash['endLine'],
    data_hash['classPath'],
    data_hash['readabilityScore'],
    data_hash['label'],
    data_hash['method'],
    abstract_method,
    '',
    '',
    '',
    '',
    '',
    ''
  )
end

def explore_path(path)
  output_csv_list = []

  if File.directory?(path)
    entries = Dir.entries(path) - ['.', '..']
    entries.each do |entry|
      entry_path = File.join(path, entry)
      if File.directory?(entry_path)
        output_csv_list.concat(explore_path(entry_path))
      else
        begin
          output_csv_list << process(entry_path)
        rescue StandardError => e
          warn("#{e.message}\nSkipping file: #{entry_path}")
        end
      end
    end
  else
    begin
      output_csv_list << process(entry_path)
    rescue StandardError => e
      puts("Error: #{e.message}\nSkipping file: #{entry_path}")
    end
  end

  output_csv_list
end

if ARGV.empty? ||
   ARGV.length > 1
  puts('Usage: ruby lexer.rb <project_path>')
  exit
end

argv = ARGV

list = explore_path(argv[0].to_s)

csv_struct = []
csv_struct <<
  %w[
    name
    startLine
    endLine
    classPath
    readabilityScore
    label
    original_method
    abstract_method
    model_prediction
    is_diff
    partially_detokenized_method
    detokenized_method
    predictions_readability_score
    does_test_suite_pass
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
      output_csv.is_diff,
      output_csv.partially_detokenized_method,
      output_csv.detokenized_method,
      output_csv.predictions_readability_score,
      output_csv.does_test_suite_pass
    ]
end

CSV.open('output.tsv', 'w', col_sep: "\t") do |csv|
  csv_struct.each do |row|
    csv << row
  end
end

## creiamo i csv, selezioniamo la t4 gpu, spm -> vocabolario del modello con cui il modello fa la scelta piu probabile,
## name, startLine, endLine, classPath, readabilityScore, label, original_method, abstract_method, model_prediction, manula_flag(vuot)
