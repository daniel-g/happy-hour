module TeamSchedule
  class Task
    attr_reader :team, :task, :local_time

    def initialize(task:, local_time:)
      @task = task
      @team = task.team
      @local_time = local_time
    end

    def team_name
      team.name
    end

    def local_schedule
      "#{format_time(local_time)} - #{format_time(local_time + task.team_cost)}"
    end

    def utc_schedule
      "#{format_time(utc_time)} - #{format_time(utc_time + task.team_cost)}"
    end

    def external_id
      task.external_id
    end

    private

    def format_time(time_in_hours)
      total_minutes = time_in_hours * 60
      hours = total_minutes.to_i / 60
      minutes = total_minutes - hours * 60
      Time.parse("#{hours.to_i}:#{minutes.to_i}").strftime("%l:%M%P").lstrip
    end

    def utc_time
      self.local_time - team.timezone
    end
  end
end
