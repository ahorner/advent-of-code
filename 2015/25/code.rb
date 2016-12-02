INSTRUCTION_MATCHER = /row (?<row>\d+), column (?<column>\d+)/

instructions = INSTRUCTION_MATCHER.match(INPUT)

row = instructions[:row].to_i
column = instructions[:column].to_i

def generate(num)
  num * 252533 % 33554393
end

def code_for(row, column)
  num = 20151125
  r = 1
  c = 1

  begin
    r, c = r == 1 ? [c + 1, 1] : [r - 1, c + 1]
    num = generate(num)
  end until r == row && c == column

  num
end

puts "The code at #{row}, #{column}:", code_for(row, column)
