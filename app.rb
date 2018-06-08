require_relative 'config/initialize'
require_relative 'config/helpers'
require_relative 'config/routes'

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