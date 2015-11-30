note
	description: "Class which loads data from an URL to a feed object"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	FEED_FETCHER

inherit
	FEED_READER

create
	make_from_url

feature -- Initialization

	make_from_url (a_url: STRING)
			-- Create with `a_url' as source of feed
		require
			valid_url: a_url /= Void
		do
			fetch (a_url)
		end

	fetch (a_url: STRING)
			-- Fetch the feed from `a_url'
		local
			fetcher: FETCH
			xml_parser: XML_PARSER
			tree_pipe: XML_CALLBACKS_NULL_FILTER_DOCUMENT
			error_handler: ERROR_READER
			reader: READER_DEF
		do
			error_handler ?= Format_list.get_reader ("Error")
			create fetcher.make_source (a_url)
			fetcher.fetch

			if fetcher.error = fetcher.none then
				create {XML_STRING_INPUT_STREAM} feed_source.make (fetcher.data)
			else
				create {XML_STRING_INPUT_STREAM} feed_source.make_empty
				if fetcher.error = fetcher.Invalid_address then
					error_handler.add_error ("Invalid Feed Address")
				elseif fetcher.error = fetcher.Transfer_failed then
					error_handler.add_error ("Could not read source data")
				end
			end
		end

end -- class FEED_FETCHER
