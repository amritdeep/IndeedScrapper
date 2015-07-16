require "nokogiri"
require "open-uri"
require 'json'
	
require "time"
# require "pry"

## Read Input from Command
puts "Reading Data From Input"
puts "What Job Do you Want ? (Job Title)"
job_title = gets.chomp
puts "Where Do you Want ? (Location)"
location = gets.chomp
# job_title="software developer"
# location="Texas"

puts "You are searching for #{job_title} in #{location}"

## Check title and location contain space or not
job_title=job_title.sub(/ /, '+') if job_title.match(/\s/)
location=location.sub(/ /, '+')  if location.match(/\s/)

puts "JOB : #{job_title} || LOC : #{location}" 

## Take input in indeed site to enter the value
url = Nokogiri::HTML(open("http://www.indeed.com/jobs?q=#{job_title}&l=#{location}"))

data = url.xpath('//div[@class="  row  result"]')

results = []

data.each do |data|
	id=data['id'].split('p_').last
	title=data.css('h2 a').text.strip
	company=data.css('.company').text.strip
	location=data.css('.location').text.strip
	summary=data.css('.summary').text.strip

	results.push(
		id: id,
		title: title,
		company: company,
		location: location,
		summary: summary
		)
end

result=JSON.pretty_generate(results)

puts result

## Handle on file
pwd = Dir.pwd
# Dir.mkdir 'Data' unless Dir.glob 'Data'
Dir.mkdir 'Data'
Dir.chdir("#{pwd}/Data")
File.open('indeed.json', 'w') { |file| file.write(result) }
chdir = Dir.pwd
if File.exist?('indeed.json')
	FileUtils.mv("#{chdir}/indeed.json", "#{chdir}/#{Time.now.strftime("%Y%M%d%H%M")}_indeed.json")
	File.open('indeed.json', 'w') { |file| file.write(result) }
end



 




