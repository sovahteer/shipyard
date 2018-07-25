require 'sinatra'
require 'sinatra/contrib/all' if development?
require_relative '../models/crew'
require_relative '../models/captain'
require_relative '../models/ship'
also_reload('../models/*')

get '/crews' do
    @crews = Crew.all
    erb( :"/crews/index" )
end

get '/crews/new' do
    erb( :"/crews/new" )
end

post '/crews' do
    Crew.new(params).save
    erb( :"/crews/new" )
    redirect to '/crews'
end

get '/crews/:id' do
    @crew = Crew.find(params['id'])
    erb( :"/crews/show" )
end

get '/crews/:id/edit' do
    @crew = Crew.find(params['id'])
    erb( :"/crews/edit" )
end

post '/crews/:id' do
    crew = Crew.new(params)
    crew.update
    redirect to "crews/#{params['id']}"
end

post '/crews/:id/delete' do
    crew = Crew.find(params['id'])
    crew.delete
    redirect to '/crews'
end