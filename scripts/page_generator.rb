require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'
require 'fileutils'
require 'sitemap_generator'
require_relative '../lib/db_client'
require_relative '../lib/const'

class Crawler
  def main(courses, path, prefecture, condition)
    param_size = [prefecture, condition].compact.length
    pre_path = param_size.times.map {|s|
      '../'
    }.join
    page = open("./base.html")
    doc = Nokogiri::HTML.parse(page, nil, 'utf-8')
    title_text = condition == nil ? "#{prefecture}の観光でおすすめモデルコース一覧" : "#{prefecture}の#{condition}の観光でおすすめのモデルコース一覧"
    doc.title = "#{title_text} | モデルコース特化サイト"
    doc.at_css("meta[name='description']")['content'] = "#{title_text}。モデルコース特化サイトであなたにあったモデルコースを提案します。"
    doc.at_css('h1').content = title_text
    doc.at_css('#favicon')['href'] = pre_path + 'favicon.ico'
    doc.at_css('#canonical')['href'] = 'https://trip.masyumaroking.com'+path.gsub('./','/').gsub('docs/','')+'/'
    doc.at_css('#style')['href'] = pre_path + 'css/style.css'
    doc.at_css('#icon')['src'] = pre_path + 'icon.png'
    doc.at_css('.nav_text') << (condition == nil ? prefecture : "<a href='../'>#{prefecture}</a> > #{condition}")
    courses.each do |course|
      href = course.url
      img = course.image_url
      title = course.title
      site_name = course.site_name
      content = "<a href='#{href}' class='list_content'>" + 
                "<div class='list_img'><img src='#{img}'/></div>" + 
                "<div class='list_text'>#{title}<div class='from'>from #{site_name}</div></div>" + 
                "</a>"
      doc.at_css('#content') << content
    end
    File.open(path + '/index.html', mode = "w"){|f|
      f.write(doc.to_html)
    }
  end
end

SitemapGenerator::Sitemap.default_host = 'https://trip.masyumaroking.com'
SitemapGenerator::Sitemap.public_path = "docs"
SitemapGenerator::Sitemap.compress = false
SitemapGenerator::Sitemap.create do
  crawler = Crawler.new
  Const::PREFECTURES.each do |key, prefecture|
    path = './docs/' + key.to_s
    add '/' + key.to_s + '/'
    courses = Courses.where(prefecture: prefecture)
    crawler.main(courses, path, prefecture, nil)
    # 一泊二日とかの条件生成
    Const::CONDITIONS.each do |k, v|
      path = './docs/' + key.to_s + '/' + k.to_s
      FileUtils.mkdir_p(path)
      courses = Courses.where(prefecture: prefecture).where('title like ?', "%#{v}%")
      p "#{key}:#{prefecture}:#{v}"
      if courses.size > 0
        p '該当あり'
        crawler.main(courses, path, prefecture, v)
        add '/' + key.to_s + '/' + k.to_s + '/'
      end
    end
    # 春夏秋冬用のページ生成
    Const::SEASON.each do |k, v|
      path = './docs/' + key.to_s + '/' + k.to_s
      FileUtils.mkdir_p(path)
      courses = Courses.where(prefecture: prefecture)
      p "#{key}:#{prefecture}:#{v}"
      if courses.size > 0
        p '該当あり'
        crawler.main(courses, path, prefecture, v)
        add '/' + key.to_s + '/' + k.to_s + '/'
      end
    end
  end
end
# sitemapの整形
`xmllint --format ./docs/sitemap.xml --output ./docs/sitemap.xml`

# index.html
# prefectures.each do |key, value|
#   prefecture = value
#   # add '/' + key.to_s + '/'
#   title_text = "#{prefecture}おすすめモデルコース一覧"
#   content = "<a href='#{'/' + key.to_s + '/'}' class='list_content'>" + 
#   "<div class='list_text'>#{title_text}</div>" + 
#   "</a>"

#   conditions.each do |k, v|
#     courses = Courses.where(prefecture: prefecture).where('title like ?', "%#{v}%")
#     # p "#{key}:#{value}:#{v}"
#     if courses.size > 0
#       title_text = "#{prefecture}の#{v}モデルコース一覧"
#       content = "<a href='#{'/' + key.to_s + '/' + k.to_s + '/'}' class='list_content'>" + 
#       "<div class='list_text'>#{title_text}</div>" + 
#       "</a>"
#       puts content
#       # add 
#     end
#   end
# end

