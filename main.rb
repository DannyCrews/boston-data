require 'rubygems'
require 'bundler'
Bundler.setup
require 'sinatra'
require 'json'
require 'rest-client'
require 'sinatra/reloader' if development?
require 'pry'

get '/' do
  api_result = RestClient.get 'https://data.cityofboston.gov/resource/ntv7-hwjm.json?'
  result_hash = JSON.parse(api_result)
  output = ''

  result_hash.each do |record|
    output << "<tr><td>#{record['total_earnings'].to_i}</td></tr>"
  end

  erb :index, :locals => {results: output}
end

