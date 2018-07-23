require 'sinatra'
require 'sinatra/contrib/all' if development?
require_relative '../models/ship'
require_relative '../models/captain'
also_reload '../models/*'

get '/ships' do
    @ships = Ship.all
    erb( :"ships/index" )
end

get '/ships/new' do
    erb( :"ships/new" )
end

post '/ships' do
    Ship.new(params).save
    erb( :"ships/new" )
    redirect to '/ships'
end

get '/ships/:id' do
    @ship = Ship.find(params['id'])
    erb( :"ships/show" )
end

get '/ships/:id/edit' do
    @ship = Ship.find(params['id'])
    erb( :"ships/edit" )
end

post '/ships/:id' do
    ship = Ship.new(params)
    ship.update
    redirect to "ships/#{params['id']}"
end

post '/ships/:id/delete' do
    ship = Ship.find(params['id'])
    ship.delete
    redirect to '/ships'
end