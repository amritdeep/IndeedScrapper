require "nokogiri"
require "open-uri"
require "pry"


doc = Nokogiri::HTML(open("http://www.indeed.com/"))
tx = Nokogiri::HTML(open("http://www.indeed.com/jobs?q=software+engineer&l=Texas"))

# css = tx.css("div.row.result").map do |tx|
# 	 data = tx.text.strip
# end
css = tx.css("div.row.result").collect {|node| node.text.strip}

out_file = File.new("output.txt", "w")
out_file.puts(css)
out_file.close

