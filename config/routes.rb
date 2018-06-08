require_relative 'api_routes'

include Helpers

before do
	redirect '/' and return if %w[welcome signin signup].include?(request.path_info.split('/')[1]) && session[:user_id]
	redirect '/welcome' unless session[:user_id]
	verify_user
end

get '/' do
	haml :index
end

get '/welcome' do
	haml :welcome
end

get '/signin' do
	haml :sign_in
end

get '/signup' do
	haml :sign_up
end

get '/signout' do
	session[:user_id] = nil
	redirect '/welcome' 
end

post '/signup' do
	param :name, String, required: true
	param :email, String, required: true
	param :password, String, required: true
	param :password_confirmation, String, required: true

	redirect '/signup' if !params[:password].eql?(params[:password_confirmation])

	encrypted_password = BCrypt::Password.create(params[:password])

	user = User.create(name: params[:name], password: encrypted_password, email: params[:email])

	session[:user_id] = user.id

	redirect '/'
end

post '/signin' do
	param :email, String, required: true
	param :password, String, required: true

	user = User.authenticate(params[:email], params[:password])
	session[:user_id] = user.id

	puts "USER #{user}"
	redirect '/signin' and return unless user && session[:user_id]
	redirect '/'
end

get '/verify/email' do
	"Verify Email"
end

get '/verify/phone' do
	"Verify Phone"
end

post '/verify/email/:email_token' do

end

get '/search' do
	param :q, String, required: true

	people = search_by(params[:q])
	puts people
	haml :results, :locals => { :people => people }
end

get '/person' do
	# New person
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