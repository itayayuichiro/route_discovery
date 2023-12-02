require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'
require "csv"
require "pp"

class Crawler
  def main
    csv = CSV.read("./memo.csv")
    csv.each do |row|
      f = File.open("./docs/aa.html", mode = "w")
      f.write("---\n")
      f.write("title: トップページ\n")
      f.write("---\n\n")
    end
  end
end

crawler = Crawler.new
crawler.main