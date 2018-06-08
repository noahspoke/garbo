module Helpers
	def current_user
		User[session[:user_id]] if session[:user_id]
	end

	def verify_user
		redirect '/verify/email' unless current_user.email_verified
		redirect '/verify/phone' unless current_user.phone_verified
	end
end