require "nokogiri"
require "open-uri"
require "fileutils"
require "time"
require "pry"

private
def create_file(file, variable)
	out_file = File.new(file, "w")
	out_file.puts(variable)
	out_file.close	
end

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
doc = Nokogiri::HTML(open("http://www.indeed.com/"))
tx = Nokogiri::HTML(open("http://www.indeed.com/jobs?q=#{job_title}&l=#{location}"))
css = tx.css("div.row.result").collect {|node| node.text.strip}

## Create file or move it
pwd = Dir.pwd
if File.exist?('output.txt')
	# FileUtils.mkdir_p 'Data'
	FileUtils.mv("#{pwd}/output.txt", "#{pwd}/#{Time.now.strftime("%Y%M%d%H%M")}_output.txt")
	create_file('output.txt', css)
else
	create_file('output.txt', css)
end
 




