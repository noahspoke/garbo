require 'rubygems'
require 'sinatra'
require 'json'
require 'redis'
require 'sinatra/reloader' if development?
require 'dotenv'
require 'sinatra/param'
require 'sinatra/namespace'
require 'ohm'
require 'haml'
require 'bundler/setup'
require_relative 'models/person'

Dotenv.load

helpers Sinatra::Param
enable :sessions

# Ohm.redis = Redic.new

get '/' do
	"hello worldddd"
end

get '/search' do
	# render search view
	"hello world"
end

get '/person' do
	# New person
	haml :new_person
end

get '/person/:id' do
	person = Person[params[:id]]

	haml :show_person, :locals => {:person => person}
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
		Person.all
	end

	get '/person/:id' do
		person = Person[params[:id]]
		person
	end

	post '/person' do
		param :name, String, required: true
		param :birth_date, String, required: true
		param :filing_date, String, required: true


		person = Person.create(params.except(:captures))
		person
	end

	delete '/person/:id' do
		{:status => 'success'} if Person[params[:id]].delete
		{:status => 'error'}
	end

	after do
		response.body = JSON.dump(response.body)
	end
end