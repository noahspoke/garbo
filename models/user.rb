class User < Ohm::Model
	attribute :name
	attribute :email
	attribute :phone
	attribute :password
	attribute :email_token
	attribute :email_verified
	attribute :phone_verified

	index :name
	index :email
	index :phone
	index :email_token

	def self.authenticate(email, password)
		email_matches = Ohm.redis.call("SCAN", "0", "MATCH", "User:indices:email:#{email}", "COUNT", "10000")
		# Optimize this for more error cases.
		return false if email_matches.count < 1
		found_email = email_matches[1][0]

		id = Ohm.redis.call("SMEMBERS", found_email)[0]
		user = User[id]
		encrypted_password = BCrypt::Password.new(user.password)

		return user if user.email == email && encrypted_password == password
	end
end