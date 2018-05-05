require './controllers/ApplicationController.rb'

class ItemController < ApplicationController

	# index route 
	get '/' do
		@items = Item.all
		@page = "Index of Items"
		erb :item_index
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

	    # @item.to_json
	    redirect '/items'
	end

	delete '/:id' do
		# there are many ways to do this find statement, this is just one
		# remember you can play around with ActiveRecord by adding binding.pry 
		# and trying stuff out
		@item = Item.find params[:id]
		@item.destroy
		redirect '/items'
	end
end