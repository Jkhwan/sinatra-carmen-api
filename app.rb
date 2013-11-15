require 'sinatra'
require 'sinatra/json'
require 'json'
require 'carmen'

get '/countries' do
  @all_countries = Carmen::Country.all
  @all_countries_official_name = []
  @all_countries.each do |country|
    @all_countries_official_name.push(country.name)
  end
  json :all_countries => @all_countries_official_name.sort
end

get '/countries/:type' do
  @all_countries = Carmen::Country.all
  @all_countries_codename = []
  @all_countries.each do |country|
    if params[:type] == "alpha2"
      @all_countries_codename.push(country.alpha_2_code)
    elsif params[:type] == "alpha3"
      @all_countries_codename.push(country.alpha_3_code)
    elsif params[:type] == "official"
      name = country.official_name
      @all_countries_codename.push(name) if name
    end
  end
  json :all_countries => @all_countries_codename.sort
end

get '/countries/full_name/:code' do
  json :name => Carmen::Country.coded(params[:code]).official_name
end

get '/countries/subregions/:code' do
  @subregion_objs = Carmen::Country.coded(params[:code]).subregions
  @subregions = []
  @subregion_objs.each do |subregion|
    @subregions.push({name: subregion.name, code: subregion.code, type: subregion.type})
  end
  json :subregions => @subregions
end