require "./lib/constants.rb"
require "json"

module ItemHandler
	def self.items
		pp "--- Searchable items ---"
		pp Constants::ITEMS.keys
	end

	def self.all_fields
		Constants::ITEMS.each { |item, file|
			parse_last_item(item, file)
		}
	end

	def self.fields(item)
		if item.nil?
			all_fields
		else
			file = Constants::ITEMS[item.downcase]

			if file.nil?
				pp "No such item exists. Try one of the following:"
				pp items
				return
			end

			parse_last_item(item, file)
		end
	end

	def self.parse_last_item(item, file)
		last_item = JSON.parse(File.read(file)).last
		pp "--- Fields for #{item} ---"
		pp last_item.keys
	end
end