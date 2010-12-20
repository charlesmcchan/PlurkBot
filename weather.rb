#!/usr/bin/env ruby 
require 'rubygems'
require 'plurk.rb'
require 'rss'
require 'open-uri'
USERNAME = ''
PASSWORD = ''
APIKEY = ''

plurk = Plurk::Client.new APIKEY 
plurk.login :username => USERNAME, :password => PASSWORD

# fetch rss
rss_feed = 'http://www.cwb.gov.tw/rss/forecast/36_06.xml'
rss_content = ''
open(rss_feed) do |f|
	rss_content = f.read
end

# parse rss
today = rss_content.split('<item>')[1].split('<title><![CDATA[ ')[1].split('</link>')[0]
desc = today.split("]]></title>\n<link>")[0].sub('(', ' [').sub(')', ']')
link = today.split("]]></title>\n<link>")[1].sub('&amp;', '&')

# post plurk
plkstr = link+' ('+desc+')'
newplk = plurk.plurk_add :content => plkstr, :qualifier => 'says', :lang => 'tr_ch'

plurk.logout
