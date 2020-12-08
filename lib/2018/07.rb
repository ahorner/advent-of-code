MATCHER = /\AStep (\w+) must be finished before step (\w+) can begin\.\z/.freeze
RULES = INPUT.split("\n").map do |line|
  match = line.match(MATCHER)
  [match[1], match[2]]
end
TASKS = RULES.flatten.uniq.sort

TIME_OFFSET ||= 4
WORKER_COUNT ||= 5

def job_for(tasks, rules, starts)
  task = tasks.detect { |task| rules.none? { |_, s| s == task } }
  [task, task.ord - TIME_OFFSET + starts] if task
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

solve!("The necessary sequence of tasks is:", work(TASKS, RULES)[:sequence])
solve!("The time to complete with helpers is:", work(TASKS, RULES, WORKER_COUNT)[:time])
