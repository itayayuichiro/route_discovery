require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'
require "csv"
require "pp"
require_relative './db_client'

class Crawler
  def main
    agent = Mechanize.new
    Courses.all.each do |courses|
      page = agent.get(courses.url)
      doc = Nokogiri::HTML.parse(page.body.toutf8, nil, 'utf-8')
      courses.update(html: doc.to_html)
      sleep 0.5
    end
  end
end

crawler = Crawler.new
crawler.main