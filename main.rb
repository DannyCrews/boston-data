require 'rubygems'
require 'bundler'
Bundler.setup
require 'json'
require 'pry'
require 'rack-flash' #not used so far
require 'rest-client'
require 'sinatra'
require 'sinatra/base'
require 'slim'
require 'uri'

set :root, File.dirname(__FILE__)

configure :development do
  require 'better_errors'
  require 'sinatra/reloader'
  use BetterErrors::Middleware
  BetterErrors.application_root = File.expand_path('..', __FILE__)
end

if Sinatra::Base.environment == :development
    require 'dotenv'
    Dotenv.load
end

  get '/' do
    slim :form
  end

  post '/' do
    headers "Cache-Control" => "public, must-revalidate, max-age=3600",
      "Expires" => Time.at(Time.now.to_i + (60 * 60)).to_s

    @time_rendered = "This page rendered at #{Time.now}."

    cap_title = params[:title].capitalize

    @title = params[:title]

    html = "https://data.cityofboston.gov/resource/ntv7-hwjm.json?$where=title like '%#{cap_title}%'&$limit=25000&$select=avg(total_earnings)"
    encoded_url = URI.encode html

    api_result = RestClient.get encoded_url
    result_array = JSON.parse api_result
    result = result_array.reduce Hash.new, :merge

    slim :index, :locals => {results: result['avg_total_earnings'].to_f.round(2)}
  end

  get '/dataset'do
    slim :dataset
  end

  not_found do
    halt 404, 'page not found'
  end
