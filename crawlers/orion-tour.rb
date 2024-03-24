require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'
require "csv"
require "pp"
require_relative '../lib/db_client'

class Crawler
  def main
    agent = Mechanize.new
    url = 'https://www.orion-tour.co.jp/orion/air/model_course/page/3/?destination=hokkaido'
    page = agent.get(url)
    doc = Nokogiri::HTML.parse(page.body.toutf8, nil, 'utf-8')
    doc.css('.related__list .related__listItem').each do |li|
        href = li.css('a')[0][:href]
        title = li.css('a')[0].text
        area = li.css('.related__spotList')[0].text.gsub(/\R/,'').gsub(' ','').gsub('・','、')
        img = li.css('img')[0][:src]
        hash = {prefecture: '北海道', area: area, url: href, title: title, image_url: img, site_name: 'オリオンツアー'}
        p hash
        Courses.create!(hash)
    end
  end
end

crawler = Crawler.new
crawler.main