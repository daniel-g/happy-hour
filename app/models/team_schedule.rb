class TeamSchedule
  attr_reader :team, :tasks

  def initialize(team:)
    @team = team
    @tasks = team.tasks.order('tasks.id')
    @task_pointer = -1
  end

  def take_task!
    return nil if done?
    task = TeamSchedule::Task.new(
      task: next_task,
      local_time: Team::CHECK_IN_TEAM + current_load
    )
    self.task_pointer += 1
    task
  end

  def done?
    next_task.nil?
  end

  private

  attr_accessor :task_pointer

  def current_load
    return 0 if task_pointer < 0
    tasks[0..task_pointer].reduce(0){|result, task| result + task.team_cost }
  end

  def next_task
    tasks[task_pointer + 1]
  end
end
