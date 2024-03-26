module ScheduleOperations
  def self.add_custom_job(scheduler)
    date_time = Time.parse(scheduler.date_time)
    time_part = date_time.strftime("%H:%M")    


    schedule_file = "/home/nakul/rails_projects/dashboard/server/config/schedule.rb"
    custom_line_start = "#custom:#{scheduler.id}:start\n"
    custom_line_end = "#custom:#{scheduler.id}:end\n"
    new_schedule = "#{custom_line_start}" +
                   " every 1.day at: '#{time_part}' do\n" +
                   "   runner \"Scheduler.update_executed_field(#{scheduler.id})\"\n" +
                   " end\n" +
                   "#{custom_line_end}"

    existing_content = File.read(schedule_file)

    updated_content = existing_content + "\n#{new_schedule}"

    File.write(schedule_file, updated_content)

    system('crontab -r')
    system('whenever --update-crontab')
  end

  def self.remove_custom_job(scheduler_id)
    schedule_file = "/home/nakul/rails_projects/dashboard/server/config/schedule.rb"
    custom_line_start = "#custom:#{scheduler_id}:start"
    custom_line_end = "#custom:#{scheduler_id}:end"


    existing_content = File.read(schedule_file)

    updated_content = existing_content.gsub(/#{custom_line_start}.*?#{custom_line_end}\n?/m, '')

    File.write(schedule_file, updated_content)
    puts "Schedule with Id : #{scheduler_id} deleted succesfully"
  end
end
