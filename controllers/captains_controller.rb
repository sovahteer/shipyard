require 'sinatra'
require 'sinatra/contrib/all' if development?
require_relative '../models/captain'
require_relative '../models/ship'
also_reload('../models/*')

get '/captains' do
    @captains = Captain.all
    erb( :"/captains/index" )
end

get '/captains/new' do
    erb( :"/captains/new" )
end

post '/captains' do
    Captain.new(params).save
    erb( :"/captains/new" )
    redirect to '/captains'
end

get '/captains/:id' do
    @captain = Captain.find(params['id'])
    erb( :"/captains/show" )
end

get '/captains/:id/edit' do
    @captain = Captain.find(params['id'])
    erb( :"/captains/edit" )
end

post 'captains/:id' do
    captain = Captain.new(params)
    Captain.update
    redirect to "captains/#{params['id']}"
end

post 'captains/delete/:id' do
    captain = Captain.find(params['id'])
    Captain.delete
    redirect to '/captains'
end