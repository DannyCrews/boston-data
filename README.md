# Boston Data

## Problem Statement
The problem is to gather Boston city employment data and provide the user with a means of finding 'Total Earnings' by searching by job title.

## Technical Choices
Since the task at hand doesn't require a database, I chose to use Sinatra DSL to implement the application. Using Sinatra vastly reduces the size of the codebase as compared to Rails and allows for future application growth, including addition of a database and the use of technologies familiar to Rails developers.

## The key technologies used are:

* Ruby 2.1.5
* Sinatra
* slim
* thin
* rack
* rest-client
* guard
* bundler
* sass
* foreman
* rspec
* capaybara
* cucumber

Very little of the code was generated. The Guardfile and mormalize.css are the only generated files that I'm aware of.

The file structure is configured to support upload to Heroku.

## Application Links
The Github repository is: https://github.com/DannyCrews/boston-data

The application is live on Heroku at: https://young-castle-28948.herokuapp.com

## API Information
The API being consumed is the City of Boston Employee Earnings Report, accessed through the Socrata Open Data API (SODA) - https://data.cityofboston.gov/Finance/Employee-Earnings-Report-2014/4swk-wcg8

The data is processed on the API server side using SODA filters and the Socrata Query Language (SoQL).

## Status
My last prior experience with Sinatra was for a short time and over two years ago. My experience with rspec/capaybara/cucumber is somewhat limited - I need to do more research how best to use these technologies in combination. I'm most dissatisfied with the current test coverage and my top priority is to increase that coverage. The necessary file structure is in place.

The file structure and chosen technologies are very familiar to Sinatra and Rails developers. Given more time, some additional tasks that need doing are:

* Clear :title from params when hitting the browser back button or the 'Search Again' link
* Formatting and styling of views - current views are simple and basically unformated
* Increase RSpec test coverage
* Incorporate SimpleCov
* Fine tune HTML caching
* Integrate search form and results into a single page app
* Better error handling
* Migrate from Thin to Passenger

## Profile and Resume
My professional information and resume can be found on LinkedIn at https://www.linkedin.com/in/danielcrews


