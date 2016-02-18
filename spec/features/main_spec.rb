require 'spec_helper'

set :environment, :test

describe 'Root Path' do
  describe 'GET /' do
    before { get '/' }
    it 'is successful' do
      expect(last_response.status).to eq(200)
    end
  end
end

describe 'Boston Data' , type: :view do


  it "loads home page" do
    get '/'
    expect(last_response).to be_ok
  end

  it "displays home page content" do
      get '/'
      expect(last_response.body).to include("Job Title:")
    end

  it "loads result page" do
    post '/', :title => "teacher"
    expect(last_response.status).to eq(200)
  end

  it "displays results page content" do
    post '/', :title => "mayor"
    expect(last_response.body).to include('Average Salary Results for "mayor"')
  end

  it "returns 404 page if route doesn't exist" do
    get '/home'
    expect(last_response.status).to eq(404)
    expect(last_response.body).to include("page not found")
  end

  it "displays the dataset page" do
    get '/dataset'
    expect(last_response.status).to eq(200)
    expect(last_response.body).to include("Employee Earnings Report 2014")
  end

end


