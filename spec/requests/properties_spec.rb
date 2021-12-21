require 'rails_helper'
require './app/variables.rb'

describe 'Call to EasyBroker API', :type => :request do
  it 'returns 15 properties' do
    VCR.use_cassette("get_properties") do
      @response = HTTParty.get(BASE_URL + 'properties', :query => QUERY, :headers => HEADERS)
      # Checks if the response code was 200
      expect(@response.code).to eq(200)

      @response = JSON.parse(@response.body)
      # Checks if the hash is returned properly
      expect(@response).to be_kind_of(Hash)
      # Checks if the response has 15 properties
      expect(@response["content"].size).to eq(15)
    end
  end

  it 'returns one property' do 
    VCR.use_cassette("get_property") do
      @response = HTTParty.get(BASE_URL + 'properties/EB-C0156', :query => QUERY, :headers => HEADERS)
      # Checks if the response code was 200
      expect(@response.code).to eq(200)

      @response = JSON.parse(@response.body)
      # Checks if the hash is returned properly
      expect(@response).to be_kind_of(Hash)
      # Checks if the title is the same as the one in the property ID
      expect(@response["title"]).to eq('Casa con uso de suelo prueba')
    end
  end

  it 'posts new lead' do 
    VCR.use_cassette('post_new_lead') do 
      data = {
        name: 'Test',
        phone: '123456789',
        email: 'test@test.com',
        property_id: 'EB-C0156',
        message: 'Test message',
        source: "mydomain.com"
      }
      @response = HTTParty.post(BASE_URL + 'contact_requests', {body: data.to_json, :headers => HEADERS })

      # Checks if the status is successful and the post request was made
      expect(@response["status"]).to eq('successful')
    end
  end
end