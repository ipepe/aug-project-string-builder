require 'rltk'
require 'rltk/ast'
require 'rltk/parser'
require 'pry'

require_relative 'string_builder_lexer'
require_relative 'string_builder_parser'


lex_array = StringBuilderLexer.lex_file('./testapp.sb')
puts(lex_array)
ast = StringBuilderParser.parse(lex_array)
puts(ast.inspect)