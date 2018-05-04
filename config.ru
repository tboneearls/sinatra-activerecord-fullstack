require 'sinatra/base'

# controllers
require './controllers/ApplicationController'

# routes
map('/') {
	run ApplicationController
}