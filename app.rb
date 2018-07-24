require 'sinatra'
require 'sinatra/contrib/all'
require_relative 'controllers/ships_controller'
require_relative 'controllers/captains_controller'
also_reload 'models/*'

get '/' do 
    @ships = []
    @captains = []
    erb ( :"app/index" )
end

post '/' do
    @ships = Ship.search params['query']
    @captains = Captain.search params['query']
    erb ( :"app/index")
end