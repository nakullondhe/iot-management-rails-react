# test.rb

def modify_schedule_file(device_id)
  schedule_file = "schedule.rb"
  custom_line_start = "#custom:#{device_id}:start\n"
  custom_line_end = "#custom:#{device_id}:end\n"
  new_schedule = []

  File.open(schedule_file, "r") do |file|
    file.each_line do |line|
      new_schedule << line
      if line.strip == custom_line_end
        new_schedule << custom_line_start
        new_schedule << "# every 1.minutes do\n"
        new_schedule << "#   runner \"puts 'Hello World'\"\n"
        new_schedule << "# end\n"
        new_schedule << custom_line_end
      end
    end
  end

  File.open(schedule_file, "w") do |file|
    new_schedule.each { |line| file.puts line }
  end

  # Run the commands
  system("crontab -r")
  system("whenever --update-crontab")
end

# Example usage:
modify_schedule_file("your_device_id")
