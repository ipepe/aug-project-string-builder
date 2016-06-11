require 'rltk'
require 'rltk/ast'
require 'rltk/parser'
require 'pry'

class StringBuilderLexer < RLTK::Lexer
  # Skip whitespace
  rule(/\n/) { :NEWLINE }

  # Keywords
  rule(/if/)    { :IF }
  rule(/then/)  { :THEN }
  rule(/else/)  { :ELSE }
  rule(/end/)   { :END }
  rule(/while/) { :WHILE }

  rule(/and/)   { :AND }
  rule(/or/)    { :OR }
  rule(/not/)   { :NOT }
  rule(/do/)    { :DO }
  rule(/readint/) { :READINTEGER }
  rule(/readstr/) { :READSTRING }
  rule(/begin/) { :BEGINBLOCK }
  rule(/exit/) { :EXIT }
  rule(/position/) { :POSITION }

  # Methods
  rule(/print/) { :PRINT }
  rule(/length/) { :LENGTH }
  rule(/concatenate/) { :CONCAT }
  rule(/substring/) { :SUBSTR }

  # Language
  rule(/\(/)	{ :LPAREN }
  rule(/\)/)	{ :RPAREN }
  rule(/,/) { :COMMA }
  rule(/==/) { :COMPARE }
  rule(/!=/) { :DIFFRENTCOMPARE }
  rule(/</) { :LESSTHAN }
  rule(/>/) { :MORETHAN }
  rule(/=/) { :ASSIGN }
  rule(/:=/) { :ASSIGN }
  rule(/(true|false)/) { |t| [:BOOLEAN, t] }
  rule(/[A-Za-z][A-Za-z0-9]*/) { |t| [ :IDENTIFIER, t] }



  # Number
  rule(/\d+/)      { |t| [:NUMBER, t.to_i] }

  # String
  rule(/"[^"|\n]*"/) { |t| [:STRING, t.to_s] }

  rule(/\s/)
end

class StringBuilderParser < RLTK::Parser

end

lex_array = StringBuilderLexer.lex_file('./testapp.sb')

puts(lex_array)