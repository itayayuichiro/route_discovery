require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'
require "csv"
require "pp"
require_relative '../crawlers/db_client'

class Parser
  def main
    Courses.where(site_name: '旅色').each do |course|
      p course.id
      begin 
        doc = Nokogiri::HTML.parse(course.html, nil, 'utf-8')
        text = doc.at_css('.plan-lead__info-item--area').text.gsub('(', '（').gsub(')', '）')
        area = text.split('（')[0]
        prefecture = text.split('（')[1].gsub('）','')
        course.update(area: area, prefecture: prefecture)
      rescue => e # 例外オブジェクトを代入した変数。
        p e
      end
    end
  end
end

parser = Parser.new
parser.main