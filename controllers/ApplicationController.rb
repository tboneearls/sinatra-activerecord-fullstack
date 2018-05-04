class ApplicationController < Sinatra::Base

	require 'bundler'
	Bundler.require()

	set :views, File.expand_path('../views', File.dirname(__FILE__))

	get '/' do
		erb :hello
	end

end