require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'
require 'fileutils'
require_relative './crawlers/db_client'


class Crawler
  def main(courses, path, prefecture, condition)
    page = open("./base.html")
    doc = Nokogiri::HTML.parse(page, nil, 'utf-8')
    title_text = condition == nil ? "#{prefecture}おすすめモデルコース一覧" : "#{prefecture}の#{condition}モデルコース一覧"
    doc.title = "#{title_text} | モデルルート特化サイト"
    doc.at_css('h1').content = title_text
    doc.at_css('#favicon')['href'] = '../../favicon.ico'
    doc.at_css('#canonical')['href'] = 'https://trip.masyumaroking.com'+path.gsub('./','/')+'/'
    doc.at_css('#style')['href'] = '../../css/style.css'
    doc.at_css('#icon')['src'] = '../../icon.png'
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



prefectures = {
  hokkaido: "北海道",
  hiroshima: "広島県",
  ishikawa: "石川県",
  okinawa: "沖縄県",
  kagoshima: "鹿児島県",
  miyazaki: "宮崎県",
  oita: "大分県",
  kumamoto: "熊本県",
  nagasaki: "長崎県",
  saga: "佐賀県",
  fukuoka: "福岡県",
  kochi: "高知県",
  ehime: "愛媛県",
  kagawa: "香川県",
  tokushima: "徳島県",
  yamaguchi: "山口県",
  okayama: "岡山県",
  shimane: "島根県",
  tottori: "鳥取県",
  wakayama: "和歌山県",
  nara: "奈良県",
  hyogo: "兵庫県",
  osaka: "大阪府",
  kyoto: "京都府",
  shiga: "滋賀県",
  mie: "三重県",
  aichi: "愛知県",
  shizuoka: "静岡県",
  gifu: "岐阜県",
  fukui: "福井県",
  toyama: "富山県",
  yamanashi: "山梨県",
  nagano: "長野県",
  nigata: "新潟県",
  kanagawa: "神奈川県",
  tokyo: "東京都",
  chiba: "千葉県",
  saitama: "埼玉県",
  gunma: "群馬県",
  tochigi: "栃木県",
  ibaraki: "茨城県",
  fukushima: "福島県",
  yamagata: "山形県",
  miyagi: "宮城県",
  akita: "秋田県",
  iwate: "岩手県",
  aomori: "青森県"
}
conditions = {
  'day': '日帰り',
  '1day2': '1泊2日',
  '2day3': '2泊3日',
  '3day4': '3泊4日',
  train: '電車',
  car: 'ドライブ',
  nocar: '車なし',
  girl: '女子旅',
  one: 'ひとり旅',
  gourmet: 'グルメ'
}

prefectures.each do |key, value|
  prefecture = value
  conditions.each do |k, v|
    path = './docs/' + key.to_s + '/' + k.to_s
    crawler = Crawler.new
    FileUtils.mkdir_p(path)
    courses = Courses.where(prefecture: prefecture).where('title like ?', "%#{v}%")
    p "#{key}:#{value}:#{v}"
    if courses.size > 0
      p '該当あり'
      crawler.main(courses, path, prefecture, v)
    end
  end
end


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

