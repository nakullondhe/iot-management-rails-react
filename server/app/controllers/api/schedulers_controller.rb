
class Api::SchedulersController < ApplicationController
  def index
    @schedulers = Scheduler.all
    render json: @schedulers
  end

  
  def create
    scheduler = Scheduler.create(scheduler_params)
    if scheduler.save
      # Schedule the cron job
      render json: scheduler, status: :created
    else
      render json: scheduler.errors, status: :unprocessable_entity
    end
  end

  private

  def scheduler_params
    params.require(:scheduler).permit(:name,:device_id, :date_time, :action)
  end


  # def modify_schedule_file(id)
  #   schedule_file = "schedule.rb"
  #   custom_line_start = "#custom:#{id}:start\n"
  #   custom_line_end = "#custom:#{id}:end\n"
  #   new_schedule = []
  
  #   File.open(schedule_file, "r") do |file|
  #     file.each_line do |line|
  #       new_schedule << line
  #       if line.strip == custom_line_end
  #         new_schedule << custom_line_start
  #         new_schedule << "# every 1.minutes do\n"
  #         new_schedule << "#   runner \"puts 'Hello World'\"\n"
  #         new_schedule << "# end\n"
  #         new_schedule << custom_line_end
  #       end
  #     end
  #   end
  
  #   File.open(schedule_file, "w") do |file|
  #     new_schedule.each { |line| file.puts line }
  #   end
  
  #   # Run the commands
  #   system("crontab -r")
  #   system("whenever --update-crontab")
  # end
  
end
