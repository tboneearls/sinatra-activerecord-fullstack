class UserController < ApplicationController

	get '/' do
		redirect '/user/login'
	end

	get '/login' do
		erb :login
	end

	get '/register' do
		erb :register
	end

	get '/logout' do
		session[:username] = nil
		session[:logged_in] = false
		session[:user_id] = nil
		redirect '/user/login'
	end

	post '/login' do
		@user = User.find_by(username: params[:username])
		@pw = params[:password]
		if @user && @user.authenticate(@pw)
			session[:username] = @user.username
			session[:logged_in] = true
			session[:user_id] = @user.id
			session[:message] = "Logged in as #{@user.username}"
			redirect '/items'
		else
			session[:message] = "Invalid username or password."
			redirect '/user/login'
		end
	end

	post '/register' do
		# instantiate user in database
		# update user attributes using input from register form
		@user = User.new
		@user.username = params[:username]
		@user.password = params[:password]
		@user.save
		# save info to session
		session[:logged_in] = true
		session[:username] = @user.username
		session[:user_id] = @user.id
		session[:message] = "Thank you for registering (as #{@user.username}).  Enjoy the site!"
		redirect '/items'	
	end

end