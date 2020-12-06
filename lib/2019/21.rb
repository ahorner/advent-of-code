require_relative "./shared/intcode"

class SpringDroid
  def initialize(program)
    @program = program
  end

  def run(script)
    instructions = script.flat_map { |line| line.chars.map(&:ord) + [10] }
    @program.run(inputs: instructions).last
  end
end

program = Computer.new(INTCODE)
droid = SpringDroid.new(program)
hull_damage = droid.run([
                          "NOT C J",
                          "AND D J",
                          "NOT A T",
                          "OR T J",
                          "WALK",
                        ])

puts "The amount of hull damage after walking is:", hull_damage, "\n"

program = Computer.new(INTCODE)
droid = SpringDroid.new(program)
hull_damage = droid.run([
                          "NOT H J",
                          "OR C J",
                          "AND B J",
                          "AND A J",
                          "NOT J J",
                          "AND D J",
                          "RUN",
                        ])

puts "The amount of hull damage after running is:", hull_damage, "\n"
