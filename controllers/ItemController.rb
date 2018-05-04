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
end