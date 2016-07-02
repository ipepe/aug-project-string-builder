require 'pry'

require 'rltk'
require 'rltk/ast'
require 'rltk/parser'


require_relative 'string_builder_lexer'
require_relative 'string_builder_expressions'
require_relative 'string_builder_parser'


begin
  lex_array = StringBuilderLexer.lex_file('./testapp.sb')
  StringBuilderParser.parse(lex_array).exec({})
rescue RLTK::NotInLanguage
  puts "Plik niezgodny z gramatyka"
end
