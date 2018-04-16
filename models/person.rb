class Person < Ohm::Model
	attribute :name
	attribute :birth_date
	attribute :filing_date
	attribute :case_number
	attribute :category
	attribute :city
	attribute :state
	attribute :zipcde

	#attribute :description
	#attribute :company
	#attribute :police_report
	#attribute :company_report

	# Add other needed fields.

	index :name
	index :filing_date
	index :birth_date
	index :city
end