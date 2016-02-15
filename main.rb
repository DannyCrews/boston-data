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
  total = 0
  count = 0

  result_hash.each do |record|
    total += record['total_earnings'].to_i
    count += 1
    output << "<tr><td>#{total}</td><td>#{count}</tr>"
  end

  # output = "<tr><td>#{total}</td><td>#{count}</tr>"


  erb :index, :locals => {results: output}
end

