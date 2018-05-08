require 'rubygems'
require 'sinatra'
require 'json'
require 'redis'
require 'sinatra/reloader'
require 'dotenv'
require 'sinatra/param'
require 'sinatra/namespace'
require 'ohm'
require 'haml'
require 'active_support/all'
require 'sass'
require 'sprockets'
require 'bundler/setup'
require_relative 'models/person'

Dotenv.load

configure :development do
	enable :reloader
end

helpers Sinatra::Param
enable :sessions

environment = Sprockets::Environment.new
set :environment, environment

environment.append_path 'assets/stylesheets'
environment.css_compressor = :scss

get '/' do
	haml :index
end

get '/search' do
	param :q, String, required: true

	#begin
		# do the work code hurr
		"hello world"
	#rescue Sinatra::Param => error
		#redirect_to '/'
	#end
end

get '/person' do
	# New person
	# Blah
	# Blah 3
	haml :new_person
end

get '/person/:id' do
	person = Person[params[:id]]

	haml :show_person, :locals => {:person => person}
end

get '/assets/*' do
	env['PATH_INFO'].sub!('/assets', '')
	settings.environment.call(env)
end

namespace '/api' do
	before do
		content_type :json
	end

	get '/search' do
		{:status => "hello search"}
	end

	# Person endpoints

	# show all
	get '/people' do
		Person.all.to_a.map(&:last_name)
	end

	get '/person/:id' do
		person = Person[params[:id]]
		person
	end

	post '/person' do
		param :first_name, String, required: true
		param :last_name, String, required: true
		#param :filing_date, String, required: true



		person = Person.create(params.except(:captures))
		person.first_name
	end

	delete '/person/:id' do
		{:status => 'success'} if Person[params[:id]].delete
		{:status => 'error'}
	end

	after do
		response.body = JSON.dump(response.body)
	end
end