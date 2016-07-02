

class StringBuilderParser < RLTK::Parser

  # left :NUM_PLUS, :NUM_MINUS
  # left :NUM_MULTIPLY, :NUM_DIVIDE, :NUM_MODULO

  production(:program, 'instruction') {|n| n}

  production(:instruction) do
    clause('instruction SEMICOLON simple_instruction ') {|i,_, s| Instruction.new(s,i) }
    clause('simple_instruction') {|s| Instruction.new(s) }
  end

  production(:simple_instruction) do
    clause('assign_statement') {|n| n}
    clause('if_statement') {|n| n}
    clause('while_statement') {|n| n}
    clause('BEGIN instruction END') {|_, n, _| BeginEndBlock.new(n) }
    clause('output_statement') {|n| n}
    clause('EXIT') {|n| Call.new(:exit) }
  end

  production(:output_statement) do
    clause('PRINT LPAREN num_expression RPAREN') {|print, _, num, _| Call.new(:print, num)}
    clause('PRINT LPAREN txt_expression RPAREN') {|print, _, txt, _| Call.new(:print, txt)}
  end

  production(:txt_expression) do
    clause('TEXT') { |n| Text.new(n) }
    clause('IDENT')  { |i| Variable.new(i, :text) }
    clause('READSTR')  { |readstr| Call.new(:readstr) }
    clause('CONCAT LPAREN txt_expression COMMA txt_expression RPAREN') do |concat, _, txt1, _, txt2,_|
      Call.new(:concat, txt1, txt2)
    end
    clause('SUBSTR LPAREN txt_expression COMMA num_expression COMMA num_expression RPAREN') do |substr, _, txt, _, start, _, stop, _|
      Call.new(:substr, txt, start, stop)
    end
  end

  production(:num_op) do # NumberOperation
    clause('NUM_PLUS')	  { |n| '+' }
    clause('NUM_MINUS')	  { |n| '-' }
    clause('NUM_MULTIPLY'){ |n| '*' }
    clause('NUM_DIVIDE')	{ |n| '/' }
    clause('NUM_MODULO')	{ |n| '%' }
  end

  production(:num_expression) do
    clause('READINT'){ |readint| Call.new(:readint) }
    clause('NUMBER') { |n| Number.new(n) }
    clause('IDENT')  { |i| Variable.new(i, :number) }

    clause('NUM_MINUS num_expression') do |minus, num_expression|
      NumberOperation.new(minus, Number.new(0), num_expression)
    end

    clause('num_expression num_op num_expression') do |expr, op, expr2|
      NumberOperation.new(op, expr, expr2)
    end

    clause('LPAREN num_expression RPAREN') { |_, ne, _| ne}

    clause("LENGTH LPAREN txt_expression RPAREN") { |length, _, txt, _| Call.new(:length, txt) }
    clause("POSITION LPAREN txt_expression COMMA txt_expression RPAREN") do |pos, _, txt1, _, txt2, _|
      Call.new(:position, txt1, txt2)
    end
  end

  production(:num_rel) do
    clause('EQUALS_SIGN') { |n| '=' }
    clause('DIFFRENT_THAN') { |n| '<>' }
    clause('LESS_OR_EQUAL') { |n| '<=' }
    clause('MORE_OR_EQUAL') { |n| '>=' }
    clause('LESS_THAN') { |n| '<' }
    clause('MORE_THAN') { |n| '>' }
  end

  production(:txt_rel) do
    clause('STR_COMPARE') { |n| '==' }
    clause('STR_DIFFRENT_COMPARE') { |n| '!=' }
  end

  production(:bool_op) do
    clause('AND') { |n| 'and' }
    clause('OR') { |n| 'or' }
  end

  production(:bool_expression) do
    clause('TRUE_BOOL')  { |_| BoolExpression.new('not', BoolExpression.new('not')) }  # not not = true
    clause('FALSE_BOOL') {|_| BoolExpression.new('not') } # BoolExpression.new('not') = po prostu zapis false
    clause('LPAREN bool_expression RPAREN') { |_, n, _| n }
    clause('NOT bool_expression') {|n, exp| BoolExpression.new('not', exp) }
    clause('bool_expression bool_op bool_expression') { |exp1, op, exp2| BoolExpression.new(op, exp1, exp2) }
    clause('num_expression num_rel num_expression') { |exp1, num_rel, exp2| NumberRelation.new(num_rel, exp1, exp2) }
    clause('txt_expression txt_rel txt_expression') { |exp1, txt_rel, exp2| TextRelation.new(txt_rel, exp1, exp2) }
  end

  production(:assign_statement) do
    clause('IDENT ASSIGN num_expression') {|id, _, num| Assign.new(id, num) }
    clause('IDENT ASSIGN txt_expression') {|id, _, txt| Assign.new(id, txt) }
  end

  production(:if_statement) do
    clause('IF bool_expression THEN simple_instruction') do |_, bool, _, simple|
      IfClause.new(bool, simple)
    end
    clause('IF bool_expression THEN simple_instruction ELSE simple_instruction') do |_, bool, _, s1, _, s2|
      IfClause.new(bool, s1, s2)
    end
  end

  production(:while_statement) do
    clause('WHILE bool_expression DO simple_instruction') do |_, bool, _, simple_instruction|
      WhileClause.new(bool, simple_instruction)
    end
    clause('DO simple_instruction WHILE bool_expression') do |_, simple_instruction, _, bool|
      WhileClause.new(bool, simple_instruction)
    end
  end

  finalize
end