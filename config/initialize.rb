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
require 'bcrypt'
require_relative '../models/person'
require_relative '../models/user'

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

set :root, File.join(File.dirname(__FILE__), '..')
set :views, Proc.new { File.join(root, "views") }