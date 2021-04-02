class CountriesController < ApplicationController
  def index
    @countries = Country.all
  end

  def show
    @country = Country.find(params[:id])
    @embassy = @country.french_embassy
    @french_foreigners_countings = @country.french_foreigners_countings
  end
end
