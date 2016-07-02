require 'pry'
require 'colorize'

require 'rltk'
require 'rltk/ast'
require 'rltk/parser'


require_relative 'string_builder_lexer'
require_relative 'string_builder_expressions'
require_relative 'string_builder_parser'


begin
  lex_array = StringBuilderLexer.lex_file('./testapp.sb')
  begin
    StringBuilderParser.parse(lex_array).exec({})
  rescue RuntimeError => e
    puts "\nInterpretation Error: #{e.message}".red
  end
rescue RLTK::NotInLanguage
  puts "Syntax error".red
end
