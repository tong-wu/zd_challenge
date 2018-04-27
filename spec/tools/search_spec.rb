require "spec_helper"
require "./tools/search.rb"

describe Search do 
	describe "#search" do
		let(:stub_db) do
			[
				{
					"_id": 1,
					"name": "personOne",
					"role": "employee",
				},
				{
					"_id": 2,
					"name": "personTwo",
					"role": "admin",
				},
				{
					"_id": 3,
					"name": "personThreee",
					"role": "admin",
				},
			]
		end
		let(:searcher) { Search.new(stub_db) }

		context "when theres is no results" do
			it "returns an empty array" do
				expect(searcher.search(:_id, "12345")).to eq([])
			end
		end

		context "when there are matches" do
			it "returns the results of the matches" do
				expected_result = [
					{
						_id: 2,
						name: "personTwo",
						role: "admin",
					},
					{
						_id: 3,
						name: "personThreee",
						role: "admin",
					},
				]
				expect(searcher.search(:role, "admin")).to eq(expected_result)
			end
		end

		context "when field does not exist" do
			it "returns an empty array" do
				expect(searcher.search(:who_cares, "1")).to eq([])
			end
		end
	end
end