require "nokogiri"
require "open-uri"
require 'pry'

class Indeed
	# attr_accessor :job, :location
	
	def initialize(job, location)
		@job = job
		@location = location
		url
	end

	def url
		check_space
		@url = Nokogiri::HTML(open("http://www.indeed.com/jobs?q=#{@job}&l=#{@location}"))
		@data = @url.xpath('//div[@class="  row  result"]')
		extract_data(@data)
	end


	private

	## Check title and location contain space or not	
	def check_space
		@job = @job.split(" ").join("+")
		@location = @location.split(" ").join("+")
	end	

	## Exact the Data
	def extract_data(data)
		results = []
		data.each do |data|
			id=data['id'].split('p_').last
			title=data.css('h2 a').text.strip
			company=data.css('.company').text.strip
			location=data.css('.location').text.strip
			summary=data.css('.summary').text.strip
			results.push(id: id, title: title, company: company, location: location, summary: summary)
			puts results
		end	
	end

end

i = Indeed.new('ruby on rails', 'texas irving')

