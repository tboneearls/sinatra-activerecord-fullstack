# require './controllers/ApplicationController.rb'

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
	    @item.user_id = session[:user_id]
	    @item.save

	    session[:message] = "You added item #{@item.id}."
	    # @item.to_json
	    redirect '/items'
	end

	# delete route
	delete '/:id' do
		# there are many ways to do this find statement, this is just one
		# remember you can play around with ActiveRecord by adding binding.pry 
		# and trying stuff out
		@item = Item.find params[:id]
		@item.destroy
		session[:message] = "You deleted item \##{@item.id}"
		redirect '/items'
	end

	# edit route
	get '/edit/:id' do
		@item = Item.find params[:id]
		@page = "Edit Item #{@item.id}" #why am i using interpolation here?  try with concatenation and see what happens.
		erb :edit_item
	end

	# update route
	patch '/:id' do
		# like i said -- lots of ways to do this.  
		# http://api.rubyonrails.org/classes/ActiveRecord/FinderMethods.html
		# http://api.rubyonrails.org/classes/ActiveRecord/QueryMethods.html#method-i-where
		@items = Item.where(id: params[:id]) 

		# note: .where method gives us an array (Why?). So we must index. 
		# Might there have been a more appropriate query method to use 
		# instead of .where ?
		@item = @items[0]

		@item.title = params[:title]
		@item.save
		session[:message] = "You updated item \##{@item.id}"
		redirect '/items'
	end

	# making sure user is logged in 
	before do
		if !session[:logged_in]
			session[:message] = "You must be logged in to do that"
			redirect '/user/login'
		end
	end

end