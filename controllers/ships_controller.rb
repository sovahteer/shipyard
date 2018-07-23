require 'sinatra'
require 'sinatra/contrib/all'
require_relative '../models/ship'
require_relative '../models/captain'
also_reload '../models/*'

get '/ships' do
    @ships = Ship.all
    erb( :"ships/index" )
end

get '/ships/new' do
    erb( :new )
end

post '/ships' do
    Ship.new(params).save
    erb( :new )
    redirect to '/ships'
end

get '/ships/:id' do
    @ship = Ship.find(params['id'])
    erb( :show )
end

get '/ships/:id/edit' do
    @ship = Ship.find(params['id'])
    erb( :edit )
end

post 'ships/:id' do
    ship = Ship.new(params)
    ship.update
    redirect to "ships/#{params['id']}"
end

post 'ships/delete/:id' do
    ship = Ship.find(params['id'])
    ship.delete
    redirect to '/ships'
end