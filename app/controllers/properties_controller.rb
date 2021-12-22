class PropertiesController < ApplicationController
  require './config/variables.rb'

  def index
    @current_page = [1, params[:page].to_i].max
    request = HTTParty.get(Rails.configuration.api['url'] + 'properties', :query => {"page"=>@current_page,"limit"=>"15"}, :headers => HEADERS)
    @response = JSON.parse(request.body)
  end

  def show
    request = HTTParty.get(Rails.configuration.api['url'] + "properties/#{params[:id]}", :headers => HEADERS)
    @response = JSON.parse(request.body)
  end

  def post_contact
    data = {
      name: params[:name],
      phone: params[:phone],
      email: params[:email],
      property_id: params[:property_id],
      message: params[:message],
      source: "mydomain.com"
    }

    @response = HTTParty.post(Rails.configuration.api['url'] + 'contact_requests', {body: data.to_json, :headers => HEADERS })

    if @response["status"] == "successful"
      flash[:notice] = "¡Mensaje enviado! Estaremos en contacto pronto"
      redirect_back(fallback_location: root_path)
    else
      flash[:danger] = @response["error"]
      redirect_back(fallback_location: root_path)
    end
  end
  
end
