class Api::DashboardController < ApplicationController
  def get_info
    device_count = Device.count
    alarm_count = Alarm.count
    scheduler_count = Scheduler.count

    counts_hash = {
      device_count: device_count,
      alarm_count: alarm_count,
      scheduler_count: scheduler_count
    }

    render json: counts_hash, status: :ok
  end

  def modify_schedule_file()
    device_id = 2
    schedule_file = "/home/nakul/rails_projects/dashboard/server/config/schedule.rb"
    custom_line_start = "#custom:#{device_id}:start\n"
    custom_line_end = "#custom:#{device_id}:end\n"
    new_schedule = "#{custom_line_start}" +
                 "every 1.minutes do\n" +
                 "runner \"puts 'Hello World'\"\n" +
                 "end\n" +
                 "#{custom_line_end}"

  existing_content = File.read(schedule_file)
  updated_content = existing_content + "\n#{new_schedule}"
  File.write(schedule_file, updated_content)

    system("crontab -r")
    system("whenever --update-crontab")
  end

  def remove_custom_section()
    device_id = 3
    schedule_file = "/home/nakul/rails_projects/dashboard/server/config/schedule.rb"
    custom_start = "#custom:#{device_id}:start"
    custom_end = "#custom:#{device_id}:end"
  
    existing_content = File.read(schedule_file)

    updated_content = existing_content.gsub(/#{custom_start}.*?#{custom_end}\n?/m, '')
  
    File.write(schedule_file, updated_content)
    # Execute commands to update crontab
    system('crontab -r')
    system('whenever --update-crontab')
  end

end
