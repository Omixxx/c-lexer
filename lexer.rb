require 'code-lexer'
java_lexer = CodeLexer.get("java")

abstractor = CodeLexer::Abstractor.new.abstract_strings.abstract_numbers.abstract_indentations.abstract_spaces
before =" // Futures\n @GwtIncompatible\n public ListenableFuture\u003cV\u003e reload(K key, V oldValue) throws Exception{\n     checkNotNull(key);\n     checkNotNull(oldValue);\n     return Futures.immediateFuture(load(key));\n }" 
lexed_before = java_lexer.lex(before)
stream_before = lexed_before.token_stream(abstractor).to_s

stream_before = stream_before.gsub("¬","$").downcase()
puts stream_before



## creiamo i csv, selezioniamo la t4 gpu, spm -> vocabolario del modello con cui il modello fa la scelta piu probabile, 


## name, startLine, endLine, classPath, readabilityScore, label, original_method, abstract_method, model_prediction, manula_flag(vuot) 


