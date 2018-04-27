require "./tools/search.rb"
require "./lib/constants.rb"
require "json"
require "byebug"

module SearchHandler
	def self.perform(search_string)
		search = search_string.downcase.split(":")

		if search.length != 3
			pp "Invalid search format. Search must be in the form of search item:field:value"
			return
		end

		search_item = search[0]
		entries = search[0] == "" ? load_all_files : JSON.parse(File.read(Constants::ITEMS[search_item]))

		search_field = search[1]
		search_value = search[2]

		pp "--- Search result for #{search_string} ---"
		pp Search.new(entries).search(search_field, search_value)
	end

	private
	def self.load_all_files
		entries = []
		Constants::ITEMS.each { |_, file|
			file_to_parse = File.read(file)
			entries += JSON.parse(file_to_parse)
		}

		entries
	end
end