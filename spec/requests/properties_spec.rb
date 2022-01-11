# frozen_string_literal: true

require 'rails_helper'
require './config/variables'

describe 'Call to EasyBroker API', type: :request do
  it 'returns invalid API key when no headers are sent' do
    VCR.use_cassette('get_properties_without_api') do
      @response = HTTParty.get("#{Rails.configuration.api['url']}properties", query: QUERY)
      expect(@response['error']).to eq('Your API key is invalid')
    end
  end

  it 'returns 15 properties' do
    VCR.use_cassette('get_properties') do
      @response = HTTParty.get("#{Rails.configuration.api['url']}properties", query: QUERY, headers: HEADERS)
      # Checks if the response code was 200
      expect(@response.code).to eq(200)

      @response = JSON.parse(@response.body)
      # Checks if the hash is returned properly
      expect(@response).to be_kind_of(Hash)
      # Checks if the response has 15 properties
      expect(@response['content'].size).to eq(15)
    end
  end

  it 'returns one property' do
    VCR.use_cassette('get_property') do
      @response = HTTParty.get("#{Rails.configuration.api['url']}properties/EB-C0156", query: QUERY,
                                                                                       headers: HEADERS)
      # Checks if the response code was 200
      expect(@response.code).to eq(200)

      @response = JSON.parse(@response.body)
      # Checks if the hash is returned properly
      expect(@response).to be_kind_of(Hash)
      # Checks if the title is the same as the one in the property ID
      expect(@response['title']).to eq('Casa con uso de suelo prueba')
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
        source: 'mydomain.com'
      }
      @response = HTTParty.post("#{Rails.configuration.api['url']}contact_requests",
                                { body: data.to_json, headers: HEADERS })

      # Checks if the status is successful and the post request was made
      expect(@response['status']).to eq('successful')
    end
  end
end
