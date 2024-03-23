require 'schedule_operations'

class Scheduler < ApplicationRecord
  enum action: { disable: 'disable', enable: 'enable' }
  attribute :executed, :boolean
  attribute :canceled, :boolean
  after_commit :add_cron_job,  on: :create

  def self.update_executed_field(scheduler_id)
    
    scheduler = Scheduler.find_by(id: scheduler_id)

    date_time = Time.parse(scheduler.date_time)
    schedule_date = date_time.strftime("%Y-%m-%d")
    todays_date = Date.today.strftime("%Y-%m-%d")

    if schedule_date != todays_date
      puts "Not the corrent date, will run again"
    return  
    end

    device = Device.find_by(id: scheduler.device_id)

    device.active = scheduler.action == 'enable' ? true : false
    device.save


    if scheduler && !scheduler.executed
      scheduler.update(executed: true)
      ScheduleOperations.remove_custom_job(scheduler_id)
    else
      puts "No need" 
    end
  end

  def add_cron_job
    puts "after create"
    ScheduleOperations.add_custom_job(self)
  end


  def compare_dates(datetime)
    date_time = Time.parse(datetime)
    schedule_date = date_time.strftime("%Y-%m-%d")
    todays_date = Date.today.strftime("%Y-%m-%d")
    if schedule_date == today_date
      return true
    else
      return false
    end
  end

end
