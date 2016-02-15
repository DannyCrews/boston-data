require 'rubygems'
require 'bundler'
Bundler.setup
require 'sinatra'
require 'json'
require 'sinatra/reloader' if development?
require 'pry'
require 'soda'

get '/' do
  client = SODA::Client.new({:domain => "data.cityofboston.gov", :app_token => "nXPqaTa5IpL5WmOGwORxoWGcF"})
  api_result = client.get("ntv7-hwjm.json", {"$limit" => 50000})

  output = ''
  total = 0
  count = 0

  api_result.each do |record|
    total += record.total_earnings.to_i
    count += 1
    output << "<tr><td>#{total}</td><td>#{count}<td>#{total/count}</tr>"
  end

  # output = "<tr><td>#{total}</td><td>#{count}</tr>"
  erb :index, :locals => {results: output}
end

get '/form/?' do
    erb :form
end

not_found do
  halt 404, 'page not found'
end


