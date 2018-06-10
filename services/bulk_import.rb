require 'csv'

class BulkImport
	def self.call(path, options = {})
		return unless File.extname(path) == '.csv'

		raw = CSV.read(path)
		people = CSV.parse(raw, :headers => options[:useHeaders] || true)

		puts people.first

		# Create and persists the people objects.
		#people.each do |person|
			#Person.create()
		#end
	end
end