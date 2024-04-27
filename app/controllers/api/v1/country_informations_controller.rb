class Api::V1::CountryInformationsController < ApplicationController
  def search_country
    @country_information = CountryInformation.search(params[:country_name], params[:language])

    if @country_information
      render json: @country_information
    else
      render json: { error: 'Country not found' }, status: :not_found
    end
  end
end
