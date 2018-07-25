require 'sinatra'
require 'sinatra/contrib/all'
require_relative 'controllers/ships_controller'
require_relative 'controllers/captains_controller'
require_relative 'controllers/crews_controller'
also_reload 'models/*'

get '/' do 
    @ships = []
    @captains = []
    @crews = []
    erb ( :"app/index" )
end

post '/' do
    @ships = Ship.search params['query']
    @captains = Captain.search params['query']
    @crews = Crew.search params['query']
    erb ( :"app/index")
end