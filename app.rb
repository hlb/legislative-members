#!/bin/env ruby
# encoding: UTF-8

require 'nokogiri'
require 'open-uri'
require 'cgi'
require 'sinatra'

get '/' do
  erb :index
end

get '/search' do
  lang = params["lang"] || "zh"
  s = params["s"]

  url = URI.parse("http://" + lang + ".wikipedia.org/w/index.php?action=render&title=" + CGI::escape(s))
  html = open(url)
  doc = Nokogiri::HTML(html.read)
  doc.encoding = 'utf-8'

  @name = doc.css('.vcard span.fn').text
  @avatar = doc.css('.vcard .image img')
  erb :search
end
