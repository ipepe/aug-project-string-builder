class StringBuilderLexer < RLTK::Lexer
  # Keywords
  rule(/if/)    { :IF }
  rule(/then/)  { :THEN }
  rule(/else/)  { :ELSE }
  rule(/end/)   { :END }
  rule(/while/) { :WHILE }

  rule(/not/)   { :NOT }
  rule(/do/)    { :DO }
  rule(/readint/) { :READINT }
  rule(/readstr/) { :READSTR }
  rule(/begin/) { :BEGIN }
  rule(/exit/) { :EXIT }
  rule(/position/) { :POSITION }

  # Boolean operators
  rule(/and/)   { :AND }
  rule(/or/)    { :OR }

  # String methods
  rule(/print/) { :PRINT }
  rule(/length/) { :LENGTH }
  rule(/concatenate/) { :CONCAT }
  rule(/substring/) { :SUBSTR }

  # String operators
  rule(/==/) { :STR_COMPARE }
  rule(/!=/) { :STR_DIFFRENT_COMPARE }

  # Numeric operators
  rule(/\+/) { :NUM_PLUS }
  rule(/-/)  { :NUM_MINUS }
  rule(/\//) { :NUM_DIVIDE }
  rule(/\*/) { :NUM_MULTIPLY }
  rule(/\%/) { :NUM_MODULO }

  rule(/<>/) { :DIFFRENT_THAN }
  rule(/<=/) { :LESS_OR_EQUAL }
  rule(/>=/) { :MORE_OR_EQUAL }
  rule(/</) { :LESS_THAN }
  rule(/>/) { :MORE_THAN }
  rule(/=/) { :EQUALS_SIGN }


  # Language
  rule(/;/) { :SEMICOLON }
  rule(/\(/)	{ :LPAREN }
  rule(/\)/)	{ :RPAREN }
  rule(/,/) { :COMMA }

  rule(/:=/) { :ASSIGN }
  rule(/true/)  { :TRUE_BOOL }
  rule(/false/) { :FALSE_BOOL }
  rule(/[A-Za-z][A-Za-z0-9]*/) { |t| [:IDENT, t] }

  # Number
  rule(/\d+/)      { |t| [:NUMBER, t.to_i] }

  # String
  rule(/"[^"|\n]*"/) { |t| [:TEXT, t.to_s[1..-2] ] }

  rule(/\s/)
end
