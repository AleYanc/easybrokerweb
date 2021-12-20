class PropertiesController < ApplicationController
  BASE_URL='https://api.stagingeb.com/v1/properties'
  HEADERS = { 
    "X-Authorization"  => ENV['API_KEY']
  }

  def index
    current_page = params[:page]
    query = {
      "limit" => "15",
      "page" => current_page || 1
    }
    request = HTTParty.get(BASE_URL, :query => query, :headers => HEADERS)
    @response = JSON.parse(request.body)
  end

  def show
  end
  
end