# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
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
env :PATH, ENV['PATH']

set :output, "./cron_log.log"


#BUILDER ROBOT SCHEDULE

every 1.minute do
    
    runner "BuilderRobotService.generateNewCars"

end

every 1.minute do
    
    runner "BuilderRobotService.installBasicStructure"

end
every 1.minute do
    
    runner "BuilderRobotService.installElectronicDevices"

end
every 1.minute do
    
    runner "BuilderRobotService.finishCar"

end


#GUARD ROBOT SCHEDULE

every 1.minute do
    
    runner "GuardRobotService.searchCarsWithDefects"

end
every 1.minute do
    
    runner "GuardRobotService.transferCarsToStore"

end
every 1.day do
    
    runner "GuardRobotService.deleteAllCars"

end

#BUYER ROBOT SCHEDULE

every 1.minute do
    
    runner "BuyerRobotService.buyCars"

end

every 1.minute do
    runner 'CarsFactory.checkStoreStock'
end