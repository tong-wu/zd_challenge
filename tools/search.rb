class Search
	def initialize(entries)
		@db = entries
	end

	# TODO: Handle case when field is blank (search all fields)
	def search(field, value)
		results = []
		@db.each { |entry|
			results << entry if entry[field]&.to_s == value
		}

		results
	end
end