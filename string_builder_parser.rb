class StringBuilderParser < RLTK::Parser

  left :NUM_PLUS, :NUM_MINUS
  left :NUM_MULTIPLY, :NUM_DIVIDE

  production(:simple_instruction, 'expression SEMI') { |s, _| s }

  production(:expression) do
    clause('c') { |c| c }
    clause('m') { |m| m }
  end

  production(:v) do # variable
    clause('NUMBER') { |n| Number.new(n)   }
    clause('SRTING') { |t| Text.new(t) }
    clause('IDENT')  { |i| Variable.new(i) }
  end

  production(:c) do #calculation
    clause('v NUM_PLUS v')	  { |e0, _, e1| Add.new(e0, e1) }
    clause('v NUM_MINUS v')	  { |e0, _, e1| Sub.new(e0, e1) }
    clause('v NUM_MULTIPLY v'){ |e0, _, e1| Mul.new(e0, e1) }
    clause('v NUM_DIVIDE v')	{ |e0, _, e1| Div.new(e0, e1) }
  end

  production(:m) do # method call
    clause('PRINT LPAREN v RPAREN') { |_, _, e, _| Print.new(e) }
    clause('CONCAT LPAREN v COMMA v RPAREN') { |_, _, e, _| e }
  end

  list(:args, :expression, :COMMA)


end