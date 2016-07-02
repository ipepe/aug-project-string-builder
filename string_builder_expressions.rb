
class Expression < RLTK::ASTNode; end

class SimpleInstruction < Expression; end

class Number < Expression
  value :value, Fixnum
  def exec(variables)
    @value
  end
end

class Text < Expression
  value :value, String
  def exec(variables)
    @value
  end
end

class Variable < Expression
  value :name, String
  value :type, Symbol
  def exec(variables)
    var = variables[@name]
    raise "1 Text cannot be number" if var.is_a?(String) && @type == :number
    raise "2 Number cannot be text" if var.is_a?(Fixnum) && @type == :text
    var
  end
end

class NumberOperation < Expression
  value :type, String
  child :left, Expression
  child :right, Expression

  def exec(vars)
    case @type
      when '+'
        @left.exec(vars) + @right.exec(vars)
      when '-'
        @left.exec(vars) - @right.exec(vars)
      when '*'
        @left.exec(vars) * @right.exec(vars)
      when '/'
        @left.exec(vars) / @right.exec(vars)
      when '%'
        @left.exec(vars) % @right.exec(vars)
      else
        raise "Unknown NumberOperation for #{@type}"
    end
  end
end

class Assign < SimpleInstruction
  value :name, String
  child :right, Expression

  def exec(variables)
    var = @right.exec(variables)
    raise "3 Number is not text" if var.is_a?(Fixnum) && @type == :text
    raise "4 Text is not a number" if var.is_a?(String) && @type == :number
    variables[@name] = var
    var
  end
end

class Call < SimpleInstruction
  value :type, Symbol
  child :first, Expression
  child :second, Expression
  child :third, Expression
  child :fourth, Expression

  def exec(variables)
    case @type
      when :print then puts(@first.exec(variables))
      when :concat then
        val1 = @first.exec(variables)
        val2 = @second.exec(variables)
        if val1.is_a?(String) && val2.is_a?(String)
          val1+val2
        else
          raise "One of values is not a String: val1=#{val1.class} val2=#{val2.class}"
        end
      when :length then
        @first.exec(variables).size
      when :position then
        @first.exec(variables).index(@second.exec(variables)).to_i
      when :substr
        @first.exec(variables)[@second.exec(variables), @third.exec(variables)]
      when :readint
        gets().to_i
      when :readstr
        gets()
      when :exit
        exit()
      else
        raise "Unknown type #{@type}"
    end
  end
end

# class BoolValue < Expression
#   value :value, :symbol
#   def ==(compare_to, return_bool: false)
#     :true
#   end
# end
class LogicCompareExpression < Expression
  value :type, String
end


class BoolExpression < LogicCompareExpression
  child :left, LogicCompareExpression
  child :right, LogicCompareExpression

  def exec(vars)
    case @type
      when 'not' then
        if @left.nil?
          return false
        else
          !@left.exec(vars)
        end
      when 'and' then
        @left.exec(vars) && @right.exec(vars)
      when 'or' then
        @left.exec(vars) || @right.exec(vars)
      else
        raise "Unknown BoolExpression #{@type}"
    end
  end
end

class NumberRelation < LogicCompareExpression
  child :left, Expression
  child :right, Expression

  def exec(var)
    case @type
      when '<' then
        @left.exec(var) < @right.exec(var)
      when '=' then
        @left.exec(var) == @right.exec(var)
      when '<>' then
        @left.exec(var) != @right.exec(var)
      when '<=' then
        @left.exec(var) <= @right.exec(var)
      when '>=' then
        @left.exec(var) >= @right.exec(var)
      when '>' then
        @left.exec(var) > @right.exec(var)
      else
        raise "Unknown operation #{@type} on numbers"
    end
  end
end

class TextRelation < BoolExpression; end



class Instruction < Expression
  child :simple, SimpleInstruction
  child :instruction, Instruction

  def exec(variables)
    if not @instruction.nil?
      @instruction.exec(variables)
    end
    if not @simple.nil?
      @simple.exec(variables)
    end
  end
end

class BeginEndBlock < SimpleInstruction
  child :instruction, Instruction
  def exec(variables)
    @instruction.exec(variables)
  end
end

class IfClause < SimpleInstruction
  child :condition, LogicCompareExpression
  child :first, SimpleInstruction
  child :second, SimpleInstruction

  def exec(vars)
    if @condition.exec(vars)
      @first.exec(vars)
    else
      @second.exec(vars) unless @second.nil?
    end
  end
end

class WhileClause < SimpleInstruction
  child :condition, BoolExpression
  child :block, SimpleInstruction

  def exec(variables)
    while(@condition.exec(variables))
      @block.exec(variables)
    end
  end
end