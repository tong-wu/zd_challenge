# Zendesk Search

This is an implementation of the Zendesk search project in Ruby.

### To run:
> ruby zendesk_search.rb

### To run tests:
> rspec spec

### Use instructions:
This application can do a couple of things
- List the fields of all searchable items 
- List the fields of a specific item
- List all searchable items
- Search an item for a field of a specific value and list those entries
- Search all items for a field of a specific value and list those entries

To do that, we have the following commands
Listing fields -> **fields** OR **fields item**
Listing searchable items -> **items**
Searching -> **search item:field:value**. The item entry is optional. If no item is specified, the application will search all items for the field/value


## Assumptions
- The data schema will take the last entry as the most up to date. So, if the data changes, the fields listed by the list command will reflect the last data entry
- If there are multiple commands in 1 line, the application will only run the first command
- If data is empty, we do not list any searchable fields
- Instead of an error message, we can just return an empty array when there are no results

### TODO
Some things I would like to do but did not get through due to schedule
- Finish up the tests in zendesk_search_spec.rb
- Add a 'help' command which will list the avialable commands to end user
- Make is so field search is also optional. This way we can just search all fields for a specified value
- Store the data somewhere other than in a json file... like an actual db.
- Do not load the file every time we want to search from it. Lazy load when we need the file then keep that stored until it's not being used or until the application exists.
