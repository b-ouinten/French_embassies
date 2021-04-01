require 'csv'

def normalize(str)
  result = str.downcase
  
  accents = {
    ['á','à','â','ä','ã'] => 'a',
    ['é','è','ê','ë'] => 'e',
    ['í','ì','î','ï'] => 'i',
    ['ó','ò','ô','ö','õ'] => 'o',
    ['ú','ù','û','ü'] => 'u',
    ['ç'] => 'c',
    ['ñ'] => 'n',
  }
  
  accents.each do |ac,rep|
    ac.each do |s|
      result.gsub!(s, rep)
    end
  end

  result
end

def get_country(country_title)
  Country.where("
    REPLACE(
      REPLACE(
        REPLACE(
          REPLACE(
            REPLACE(
              REPLACE(
                REPLACE(
                  REPLACE(LOWER(fr_title),'à', 'a') 
                ,'è', 'e') 
              ,'é', 'e')
            ,'ì', 'i')
          ,'ï', 'i')
        ,'ò', 'o') 
      ,'ù', 'u') 
    ,'ç', 'c') LIKE ?", "%" + normalize(country_title)  + "%").first
end

namespace :import_data do
  desc "update the countries table with countries.csv data"
  task import_countries: :environment do
    # Delete countries table
    model = Country
    model.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!(model.table_name)
    puts "The table #{model.table_name} is deleted !"
    
    # Importe countries
    counter = 0
    file = 'csv/countries.csv'
    CSV.foreach(file, headers: true) do |values|
      country_hash = values.to_hash
      Country.create!(country_hash)
      counter += 1
    end
    
    # Check integrity
    if counter == model.count
      puts 'Data imported successfully'
    else
      puts 'Something wrong !'
    end
  end
  
  desc "update the fench_embassies table with embassy.csv data"
  task import_embassies: :environment do
    # Delete french_embassies table
    model = FrenchEmbassy
    model.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!(model.table_name)
    puts "The table #{model.table_name} is deleted !"
    
    # import embassies
    counter = 0
    file = 'csv/french_embassies.csv'
    CSV.foreach(file) do |values|
      values.map! do |item|
        item.split(';')
      end
        .flatten!.shift
      
      coordinates = values.pop(2).join(',')
      values.push(coordinates)
      
      country = get_country(values[0])
      country_id = country ? country.id : nil
      values.push(country_id)

      keys = ['country_title', 'latitude', 'longitude', 'coordinates', 'country_id']
      embassy_hash = keys.zip(values).to_h
      
      FrenchEmbassy.create!(embassy_hash)
      counter += 1
    end

    # Check integrity
    if counter == model.count
      puts 'Data imported successfully'
    else
      puts 'Something wrong !'
    end
  end

  desc "update the fench_foreigners_countings table with french_foreigners_countings.csv data"
  task import_foreigners_countings: :environment do
    # Delete french_foreigners_countings table
    model = FrenchForeignersCounting
    model.delete_all
    ActiveRecord::Base.connection.reset_pk_sequence!(model.table_name)
    puts "The table #{model.table_name} is deleted !"
    
    # import foreigners_counting
    counter = 0
    file = 'csv/french_foreigners_countings.csv'
    CSV.foreach(file) do |values|
      values.map! do |item|
        item.split(';')
      end
        .flatten!
      
      country = get_country(values[0])
                    
      country_id = country ? country.id : nil
      
      values.push(country_id)
      keys = ['country_title', 'year', 'number_of_foreigners', 'country_id']
      foreigners_counting_hash = keys.zip(values).to_h
      
      FrenchForeignersCounting.create!(foreigners_counting_hash)
      counter += 1
    end

    # Check integrity
    if counter == model.count
      puts 'Data imported successfully'
    else
      puts 'Something wrong !'
    end
  end
end
