require "code-lexer"
require "json"

def convert(file_json)

  java_lexer = CodeLexer.get("java")

  abstractor = CodeLexer::Abstractor.new.abstract_strings.abstract_numbers.abstract_indentations.abstract_spaces
  before = " // Futures\n @GwtIncompatible\n public ListenableFuture\u003cV\u003e reload(K key, V oldValue) throws Exception{\n     checkNotNull(key);\n     checkNotNull(oldValue);\n     return Futures.immediateFuture(load(key));\n }"
  lexed_before = java_lexer.lex(before)
  stream_before = lexed_before.token_stream(abstractor).to_s

  stream_before = stream_before.gsub("¬", "$").downcase
  puts(stream_before)
end

def explore_path(path)
  if File.directory?(path)
    entries = Dir.entries(path) - [".", ".."]
    entries.each do |entry|
      entry_path = File.join(path, entry)
      if File.directory?(entry_path)
        explore_path(entry_path)
      else
        puts("File: #{entry_path}")
      end
    end
  else
    puts("File: #{path}")
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
