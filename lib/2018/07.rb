MATCHER = /\AStep (\w+) must be finished before step (\w+) can begin\.\z/.freeze
RULES = INPUT.split("\n").map do |line|
  match = line.match(MATCHER)
  [match[1], match[2]]
end
TASKS = RULES.flatten.uniq.sort

def job_for(tasks, rules, starts)
  task = tasks.detect { |task| rules.none? { |_, s| s == task } }
  [task, task.ord - 4 + starts] if task
end

def work(tasks, rules, worker_count = 1)
  workers = [nil] * worker_count
  sequence = ""

  0.step do |time|
    workers.each_with_index do |(task, ends), i|
      next unless ends&.<=(time)

      workers[i] = nil
      sequence << task
      rules = rules.reject { |t, _| t == task }
    end

    workers.each_index do |i|
      next if workers[i]

      job = job_for(tasks, rules, time)
      workers[i] = job
      tasks -= [job&.first]
    end

    break { sequence: sequence, time: time } if workers.all?(&:nil?)
  end
end

puts "The necessary sequence of tasks is:", work(TASKS, RULES)[:sequence], nil
puts "The time to complete with helpers is:", work(TASKS, RULES, 5)[:time]
