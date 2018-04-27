require "spec_helper"
require "./lib/item_handler.rb"

describe ItemHandler do
	describe ".items" do
		it "prints out the list of avialable items" do
			string_to_expect = "\"--- Searchable items ---\"\n"
			string_to_expect += Constants::ITEMS.keys.to_s + "\n"
			expect{ ItemHandler.items }.to output(string_to_expect).to_stdout
		end
	end

	describe ".all_fields" do
		it "calls .parse_last_item on all of the files" do
			Constants::ITEMS.each { |item, file|
				expect(ItemHandler).to receive(:parse_last_item).
				with(item, file)
			}
			ItemHandler.all_fields
		end
	end

	describe ".fields" do
		context "when item is nil" do
			it "calls .all_fields" do
				expect(ItemHandler).to receive(:all_fields)
				ItemHandler.fields(nil)
			end
		end

		context "when item is specified" do
			context "when no such item exists" do
				it "prints an error message to stdout" do
					expected_string = "\"No such item exists. Try one of the following:\"\n"
					expected_string += (ItemHandler.items.to_s + "\n")

					ItemHandler.fields("asdf")
				end

				it "does not call .parse_last_item" do
					expect(ItemHandler).to_not receive(:parse_last_item)
					ItemHandler.fields("asdf")
				end
			end

			context "when the item is valid" do
				it "calls .parse_last_item with the item and file" do
					item = Constants::ITEMS.keys[0]
					file = Constants::ITEMS[item]
					expect(ItemHandler).to receive(:parse_last_item).with(item, file)

					ItemHandler.fields(item)
				end
			end
		end
	end

	describe ".parse_last_item" do
		let(:stubbed_result) do
			[{
				"item" => "testing"
			}]
		end

		it "prints the fields for specified item" do
			allow(File).to receive(:read)
			allow(JSON).to receive(:parse).and_return(stubbed_result)

			expected_string = "\"--- Fields for users ---\"\n"
			expected_string += stubbed_result.last.keys.to_s + "\n"

			ItemHandler.parse_last_item("users", "users.json")

		end
	end
end