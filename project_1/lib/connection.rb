require 'active_record'

ActiveRecord::Base::establish_connection({
	:adapter => 'postgresql',
	:host => 'localhost',
	:username => 'AlexWpro15',
	:database => 'project_1'
	})

ActiveRecord::Base.logger = Logger.new(STDOUT)
