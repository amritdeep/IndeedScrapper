require "nokogiri"
require "open-uri"
require "fileutils"
require "time"

private
def create_file(file, variable)
	out_file = File.new(file, "w")
	out_file.puts(variable)
	out_file.close	
end

pwd = Dir.pwd
doc = Nokogiri::HTML(open("http://www.indeed.com/"))
tx = Nokogiri::HTML(open("http://www.indeed.com/jobs?q=software+engineer&l=Texas"))
css = tx.css("div.row.result").collect {|node| node.text.strip}

if File.exist?('output.txt')
	# FileUtils.mkdir_p 'Data'
	FileUtils.mv("#{pwd}/output.txt", "#{pwd}/#{Time.now.strftime("%Y%M%d%H%M")}_output.txt")
	create_file('output.txt', css)
else
	create_file('output.txt', css)
end
 




