
class Expression < RLTK::ASTNode; end

class Number < Expression
  value :value, Fixnum
end

class Text < Expression
  value :value, String
end

class Variable < Expression
  value :name, String
  value :type, Symbol
end

class Assign < Expression
  value :name, String
  child :right, Expression
end

class Call < Expression
  value :type, Symbol
  child :args, [Expression]
end

# class Unary < Expression
#   child :operand, Expression
# end
#
# class Not < Unary; end
# class Neg < Unary; end
#
# class Binary < Expression
#   child :left,	Expression
#   child :right,	Expression
# end
#
# class Add < Binary; end
# class Sub < Binary; end
# class Mul < Binary; end
# class Div < Binary; end
# class LT  < Binary; end
# class GT  < Binary; end
# class Eql < Binary; end
# class Or  < Binary; end
# class And < Binary; end
#

#
# class If < Expression
#   child :cond, Expression
#   child :then, Expression
#   child :else, Expression
# end
#
# class For < Expression
#   value :var, String
#
#   child :init, Expression
#   child :cond, Expression
#   child :step, Expression
#   child :body, Expression
# end