require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'
require "csv"
require "pp"
require_relative '../../lib/db_client'

class Crawler
  def main
    agent = Mechanize.new
    url = 'https://www.kankou-gifu.jp/model/index_1_2________.html'
    page = agent.get(url)
    doc = Nokogiri::HTML.parse(page.body.toutf8, nil, 'utf-8')
    doc.css('.articleList dl').each do |dl|
        href = 'https://www.kankou-gifu.jp/model/' + dl.css('a')[0][:href]
        title = dl.css('dt')[0].text
        img = dl.css('img')[0][:src]
        hash = {prefecture: '岐阜県', url: href, title: title, image_url: img, site_name: '岐阜の旅ガイド'}
        Courses.create!(hash)
    end
  end
end

crawler = Crawler.new
crawler.main