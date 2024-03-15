require "code-lexer"
require "json"

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
  converted_method = convert(data_hash["method"])
  puts(converted_method)
end

def explore_path(path)
  if File.directory?(path)
    entries = Dir.entries(path) - [".", ".."]
    entries.each do |entry|
      entry_path = File.join(path, entry)
      if File.directory?(entry_path)
        explore_path(entry_path)
      else
        process(entry_path)
      end
    end
  else
    process(entry_path)
  end
end

if ARGV.empty? or
    ARGV.length > 1
  puts("Usage: ruby lexer.rb <project_path>")
  exit
end

argv = ARGV

explore_path(argv[0].to_s)

## creiamo i csv, selezioniamo la t4 gpu, spm -> vocabolario del modello con cui il modello fa la scelta piu probabile,
## name, startLine, endLine, classPath, readabilityScore, label, original_method, abstract_method, model_prediction, manula_flag(vuot)
