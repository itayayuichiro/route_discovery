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
    url = 'https://www.visit-hokkaido.jp/plan/index_3_2______.html'
    page = agent.get(url)
    doc = Nokogiri::HTML.parse(page.body.toutf8, nil, 'utf-8')
    doc.css('.spotList dl').each do |dl|
        href = url + dl.css('a')[0][:href]
        # TODO: 一部見切れているが一旦許容
        title = dl.css('a')[0][:alt]
        area = dl.css('dd')[1].text.gsub("\n",'').gsub("\t", '').split('エリア').join('、')
        img = 'https://www.visit-hokkaido.jp' + dl.css('img')[0][:src]
        hash = {prefecture: '北海道', area: area, url: href, title: title, image_url: img, site_name: 'HOKKAIDO LOVE!'}
        # p hash
        Courses.create!(hash)
    end
  end
end

crawler = Crawler.new
crawler.main