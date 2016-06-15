require 'csv'
require "open-uri"
require "nokogiri"
require 'pry'

class Indeed	
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
		puts "Extacting Data from Indeed"
		results = []
		data.each do |data|
			id=data['id'].split('p_').last
			title=data.css('h2 a').text.strip
			company=data.css('.company').text.strip
			location=data.css('.location').text.strip
			summary=data.css('.summary').text.strip
			date=data.css('.date').text.strip
			results.push(id: id, title: title, company: company, location: location, summary: summary, date: date)
			write_to_csv(results)
		end	
	end

	## Write to CSV file
	def write_to_csv(output)
		puts "Saving data to CSV file i.e indeed.csv file"
		CSV.open('indeed.csv', 'wb') do |csv|
			output.each do |out|
				id = out[:id]
				title = out[:title]
				company = out[:company]
				location = out[:location]
				summary = out[:summary]
				date = out[:date]
				csv << [id, title, company, location, summary, date]
			end
		end
	end

end

i = Indeed.new('ruby on rails', 'texas irving')

