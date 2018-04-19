class Person < Ohm::Model
	attribute :first_name
	attribute :last_name
	attribute :birth_year
	attribute :appearance_arrest_date
	attribute :case_number
	attribute :charge_number
	attribute :number_of_charges
	attribute :city
	attribute :state

	#attribute :description
	#attribute :company
	#attribute :police_report
	#attribute :company_report

	# Add other needed fields.

	index :first_name
	index :last_name
	index :birth_year
	index :appearance_arrest_date
	index :case_number
	index :charge_number
	index :city
	index :state
end