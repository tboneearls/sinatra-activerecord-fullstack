require './controllers/ApplicationController.rb'

class ItemController < ApplicationController

	# index route 
	get '/' do
		"this is get route in ItemController"
	end

	# add route
	get '/add' do
		@page = "Add Item"
		@action = "/items"
		@method = "POST"
		@placeholder = "Enter your Item!"
		@value = ""
		@buttontext = "Add Item"
		erb :add_item
	end

	# create route
	post '/' do
		# params are in a hash called params, check your terminal
	    # extra puts statements help you find this output amongst the very verbose terminal output
	    puts "HERE IS THE PARAMS---------------------------------------"
	    pp params
	    puts "---------------------------------------------------------"
	    "you posted. check your terminal."

	    @item = Item.new
	    @item.title = params[:title]
	    @item.user_id = params[:user_id] # for now
	    @item.save

	    @item.to_json
	    
	end
end