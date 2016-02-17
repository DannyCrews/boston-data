require 'spec_helper'

set :environment, :test

describe 'Boston Data' do

  def app
    Sinatra::Application
  end

  it "should load the home page" do
    get '/'
    expect(last_response.status).to eq(200)
  end

  it "should not load the home page" do
    get '/home'
    expect(last_response.status).to eq(404)
  end

  it "should load the other page" do
    get '/dataset'
    expect(last_response.status).to eq(200)
  end

  # it "returns status 200 when posting" do
  #   post "/"
  #   expect(last_response).to eq(304)
  # end


  # context "title param missing" do
  #   it "returns status 400" do
  #     post "/"
  #     expect(last_response.status).to eq 400
  #   end
  # end
end
