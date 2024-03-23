class Api::CronJobsController < ApplicationController
  def all 
    schedule_file = File.join(Rails.root, 'config', 'schedule.rb')
    schedule_content = File.read(schedule_file)

    # Parse the schedule.rb file using whenever gem's JobList
    job_list = Whenever::JobList.new(file: schedule_file)

    # Extract cron jobs
    cron_jobs = job_list.jobs.map do |job|
      {
        command: job.command,
        frequency: job.frequency,
        at: job.at,
        comment: job.comment
      }
    end
    cron_jobs
  end
end