indexing
	description: "Example class for feed reader."
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	READER_EXAMPLE

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		local
			location: STRING
			reader: FEED_READER
			feed: FEED
		do
			-- Get a feed location from the user
			io.put_string ("Enter an URL: ")
			io.read_line
			
			location := io.last_string.twin
			
			-- Create the reader
			create reader.make_url (location)
			
			-- Get the feed
			feed := reader.read
			
			-- Print feed
			io.put_string ("%NReceived feed:%N")
			io.put_string ("==============%N%N%N")
			io.put_string (feed.to_string)
		end

end -- class FEED_EXAMPLE
