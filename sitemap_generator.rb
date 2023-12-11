require 'rubygems'
require 'sitemap_generator'
require_relative './crawlers/db_client'

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



SitemapGenerator::Sitemap.default_host = 'https://trip.masyumaroking.com'
SitemapGenerator::Sitemap.public_path = "docs"
SitemapGenerator::Sitemap.compress = false

SitemapGenerator::Sitemap.create do
  prefectures.each do |key, value|
    prefecture = value
    add '/' + key.to_s + '/'
    conditions.each do |k, v|
      courses = Courses.where(prefecture: prefecture).where('title like ?', "%#{v}%")
      p "#{key}:#{value}:#{v}"
      if courses.size > 0
        add '/' + key.to_s + '/' + k.to_s + '/'
      end
    end
  end
end