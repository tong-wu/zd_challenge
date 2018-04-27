require "pp"
require "./lib/search_handler.rb"
require "./lib/item_handler.rb"

class ZendeskSearch
	def run
		@running = true
		welcome_script

		while @running
			parse_and_run_command(gets.downcase)
			pp "Ready for next input"
		end
	end

	private
	def quit
		@running = false
	end

	def welcome_script
		pp "Welcome to Zendesk search"
		pp "To Search, type the following -- 'search item:field:value'"
		pp "For a list of searchable items type -- 'items'"
		pp "For a list of searchable fields type -- 'fields item'"
		pp "To quit -- 'quit'"
	end

	def parse_and_run_command(command)
		command = command.split(" ")

		case command[0].downcase
		when "quit"
			quit
		when "items"
			list_items
		when "fields"
			list_fields(command[1])
		when "search"
			run_search(command[1])
		else
			pp "Not a valid command"
		end
	end

	def run_search(search_string)
		SearchHandler.perform(search_string)
	end

	def list_items
		ItemHandler.items
	end

	def list_fields(item)
		ItemHandler.fields(item)
	end
end

ZendeskSearch.new.run