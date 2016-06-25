class StringBuilderLexer < RLTK::Lexer
  # Keywords
  rule(/if/)    { :IF }
  rule(/then/)  { :THEN }
  rule(/else/)  { :ELSE }
  rule(/end/)   { :END }
  rule(/while/) { :WHILE }

  rule(/not/)   { :NOT }
  rule(/do/)    { :DO }
  rule(/readint/) { :READINTEGER }
  rule(/readstr/) { :READSTRING }
  rule(/begin/) { :BEGINBLOCK }
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
  rule(/=/) { :ASSIGN }


  # Language
  rule(/;/) { :SEMICOLON }
  rule(/\(/)	{ :LPAREN }
  rule(/\)/)	{ :RPAREN }
  rule(/,/) { :COMMA }

  # String operators
  rule(/==/) { :STR_COMPARE }
  rule(/!=/) { :STR_DIFFRENT_COMPARE }

  rule(/:=/) { :ASSIGN }
  rule(/(true|false)/) { |t| [:BOOLEAN, t] }
  rule(/[A-Za-z][A-Za-z0-9]*/) { |t| [ :IDENTIFIER, t] }

  # Number
  rule(/\d+/)      { |t| [:NUMBER, t.to_i] }

  # String
  rule(/"[^"|\n]*"/) { |t| [:STRING, t.to_s[1..-2] ] }

  rule(/\s/)
end
