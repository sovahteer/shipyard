require 'sinatra'
require 'sinatra/contrib/all'
require_relative 'controllers/ships_controller'
require_relative 'controllers/captains_controller'
also_reload 'models/*'

get '/' do 
    erb ( :"app/index" )
end

