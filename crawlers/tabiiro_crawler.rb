require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'
require "csv"
require "pp"


require 'active_record' 

#DB接続設定
 ActiveRecord::Base.establish_connection( 
  adapter:  "mysql2", 
  host:     "localhost", #ローカルのDBに接続します。
  username: "root", #ユーザー名
  password: "",  #設定したMySQLのパスワード
  database: "route_discovery",  #接続したいDB名
)

class Courses < ActiveRecord::Base
end

class Crawler
  def main
    124.times do |i|
        agent = Mechanize.new
        url = "https://tabiiro.jp/plan/all/#{i+1}/"
        page = agent.get(url)
        doc = Nokogiri::HTML.parse(page.body.toutf8, nil, 'utf-8')
        doc.css('.ren-article-card').each do |a|
            href = 'https://tabiiro.jp' + a[:href]
            title = a.css('.ren-article-card__ttl')[0].text.gsub("\"", "'")
            img = a.css('.ren-article-card__img img')[0][:src]
            hash = {url: href, title: title, image_url: img, site_name: '旅色'}
            Courses.create!(hash)
        end
        sleep 0.5
    end
  end
end

crawler = Crawler.new
crawler.main