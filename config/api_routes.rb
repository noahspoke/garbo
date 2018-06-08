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