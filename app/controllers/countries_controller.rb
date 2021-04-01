class CountriesController < ApplicationController
  def index
    @countries = Country.all
  end

  def show
    puts '*' * 30
    puts 'hello'
    puts '*' * 30
  end
end
