require_relative 'config/initialize'

def search_by(keyword)
	people = []

	first_name_keys = Ohm.redis.call("SCAN", "0", "MATCH", "Person:indices:first_name:*#{keyword.titleize}*", "COUNT", "1000")
	last_name_keys = Ohm.redis.call("SCAN", "0", "MATCH", "Person:indices:last_name:*#{keyword.titleize}*", "COUNT", "1000")
	keys = first_name_keys[1].to_a.concat(last_name_keys[1].to_a)
	puts keys

	keys.map { |key|
		ids = Ohm.redis.call("SMEMBERS", key)

		ids.each do |id|
			people.push(Person[id])
		end
	}

	people
end

get '/' do
	haml :index
end

get '/search' do
	param :q, String, required: true

	people = search_by(params[:q])
	puts people
	haml :results, :locals => { :people => people }
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