require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'

class Crawler
  def main
    agent = Mechanize.new
    f = File.open("./md/index.md", mode = "w")
    f.write("---\n")
    f.write("title: トップページ\n")
    f.write("---\n\n")
    100.times { |i|
      begin
        page = open("./docs/article#{i+1}.html")
        doc = Nokogiri::HTML.parse(page, nil, 'utf-8')
        text = "- [#{doc.title}](./article#{i+1}.html)"
        f.write("#{text}\n")
      rescue => e
        p e
      end
    }
  end
end

crawler = Crawler.new
crawler.main