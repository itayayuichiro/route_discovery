require 'uri'
require 'nokogiri'
require 'kconv'
require 'mechanize'
require 'fileutils'
require 'sitemap_generator'
require_relative '../lib/db_client'
require_relative '../lib/const'

# Courses.where(site_name: 'オリオンツアー').delete_all

# Courses.where(site_name: 'HOKKAIDO LOVE!').each do |c|
#   if c.url.include?('______')
#     # p 
#     c.update(url: c.url.gsub('index_3_2______.html','').gsub('index_2_2______.html',''))
#   end
# end

# 乱数ばら撒き
# Courses.all.each do |course|
#   random = Random.new
#   course.update(sort: random.rand(1..100))
# end
