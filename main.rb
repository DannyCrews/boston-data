require 'rubygems'
require 'bundler'
Bundler.setup
require 'sinatra'
require 'json'
require 'sinatra/reloader' if development?
require 'sinatra/base'
require 'pry'
require 'rest-client'
require 'rack-flash'
require 'better_errors'
require 'dotenv'


set :root, File.dirname(__FILE__)

Dotenv.load

configure :development do
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

get '/' do
  erb :form
end

post '/' do
  cap_title = params[:title].capitalize
  @title = params[:title]

  html = "https://data.cityofboston.gov/resource/ntv7-hwjm.json?$where=title like '%#{cap_title}%'&$limit=25000&$select=avg(total_earnings)"
  encoded_url = URI.encode html

  api_result = RestClient.get encoded_url
  result_array = JSON.parse api_result
  result = result_array.reduce Hash.new, :merge

  erb :index, :locals => {results: result['avg_total_earnings'].to_f.round(2)}
end

get '/dataset'do
  erb :dataset
end

not_found do
  halt 404, 'page not found'
end
