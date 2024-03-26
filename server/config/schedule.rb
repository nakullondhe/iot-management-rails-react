env :PATH, ENV['PATH']
# Use this file to easily define all of your cron jobs.

# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#

#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

#
# every 1.minutes do
#   runner "puts 'Hello World'"
# end



set :output, "./log/cron.log" 
set :environment, "development"


# every 1.minutes do
#   runner 'Scheduler.update_executed_field(2)'
# end


#custom:24:start
 every 1.day at: '16:00' do
   runner "Scheduler.update_executed_field(24)"
 end
#custom:24:end

#custom:25:start
 every 1.day at: '16:00' do
   runner "Scheduler.update_executed_field(25)"
 end
#custom:25:end

#custom:26:start
 every 1.day at: '09:27' do
   runner "Scheduler.update_executed_field(26)"
 end
#custom:26:end
