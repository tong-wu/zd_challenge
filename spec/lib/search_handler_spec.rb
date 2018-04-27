require "spec_helper"
require "./lib/search_handler.rb"
require "./tools/search.rb"

describe SearchHandler do
	describe ".perform" do
		context "when search string is valid" do
			context "when search string loads all files" do
				it "runs and calls .load_all_files" do
					expect(SearchHandler).to receive(:load_all_files)
					allow_any_instance_of(Search).to receive(:search)

					SearchHandler.perform(":_id:1")
				end
			end

			context "when seach string only searches one file" do
				it "runs the search" do
					expect_any_instance_of(Search).to receive(:search).
					with("_id", "1")

					SearchHandler.perform("users:_id:1")
				end

				it "does not call .load_all_files" do
					expect(SearchHandler).not_to receive(:load_all_files)

					SearchHandler.perform("users:_id:1")
				end

				it "prints the output" do
					allow_any_instance_of(Search).to receive(:search).
					with("_id", "1").and_return("StubSearchOutput")

					expect{ SearchHandler.perform("users:_id:1") }.
					to output("\"--- Search result for users:_id:1 ---\"\n\"StubSearchOutput\"\n").
					to_stdout
				end
			end
		end

		context "when search string is invalid" do
			it "prints error to stdout" do
				expect{ SearchHandler.perform("asdf") }.
				to output("\"Invalid search format. Search must be in the form of search item:field:value\"\n").
				to_stdout
			end
		end
	end

	describe ".load_all_files" do
		let(:stubbed_result) do
			[
				{
					"item" => "testing"
				}
			]
		end
		it "reads each file then calls JSON.parse" do
			expect(JSON).to receive(:parse).exactly(Constants::ITEMS.count).
			times.and_return(stubbed_result)

			Constants::ITEMS.each { |_, file|
				expect(File).to receive(:read).with(file)
			}

			expect(SearchHandler.perform(":_id:1")).to eq([])
		end
	end
end