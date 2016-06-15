require 'pry'

class Indeed
	def initialize(job, location)
		@job = job
		@location = @location
	end

	## Check title and location contain space or not	
	def check_input
		@job = @job.split(" ").join("+")
		@location = @location.split(" ").join("+")
	end

end

i = Indeed.new('ruby on rails', 'texas irving')
i.check_input
