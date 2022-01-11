# frozen_string_literal: true

class PropertiesController < ApplicationController
  def index
    @current_page = [1, params[:page].to_i].max
    request = HTTParty.get(Rails.configuration.api['properties'],
                           query: { 'page' => @current_page, 'limit' => LIMIT, 'search[statuses][]' => STATUS },
                           headers: HEADERS)
    @response = JSON.parse(request.body)
    @total_pages = @response['pagination']['total'] / LIMIT
  end

  def show
    request = HTTParty.get("#{Rails.configuration.api['properties']}/#{params[:id]}",
                           headers: HEADERS)
    @response = JSON.parse(request.body)
  end

  def post_contact
    data = {
      name: params[:name],
      phone: params[:phone],
      email: params[:email],
      property_id: params[:property_id],
      message: params[:message],
      source: 'mydomain.com'
    }

    @response = HTTParty.post(Rails.configuration.api['contact'],
                              { body: data.to_json, headers: HEADERS })

    if @response['status'] == 'successful'
      flash[:notice] = '¡Mensaje enviado! Estaremos en contacto pronto'
    else
      flash[:danger] = @response['error']
    end
    redirect_back(fallback_location: root_path)
  end
end
