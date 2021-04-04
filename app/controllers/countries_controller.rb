class CountriesController < ApplicationController
  def index
    @countries = Country.all
  end

  def show
    @country = Country.find(params[:id])
    @embassy = @country.french_embassy
    @french_foreigners_countings = @country.french_foreigners_countings.sort {|c1, c2| c1.year <=> c2.year}
  end
end
