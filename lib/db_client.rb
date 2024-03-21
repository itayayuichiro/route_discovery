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