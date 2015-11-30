indexing
	description: "Example class for feed writer."
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	WRITER_EXAMPLE

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
	local
			feed: FEED
			writer: FEED_WRITER
	do
			-- Create a simple feed
			create feed.make ("EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/AllRecentChanges?action=rss"), "EiffelRSS news")
			
			-- Add some simple items
			feed.new_item ("Version 23 released!", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/News"), 
				"Version 23 of EiffelRSS got release today. Happy syndicating!")			
			feed.new_item ("Microsoft uses EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/WhoUsesEiffelRSS"), 
				"Microsoft announced in a press release today that they will use EiffelRSS to syndicate news on their website.")
			feed.new_item ("EiffelRSS wins award", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/Awards"),
				"EiffelRSS has been awarded by ISE as best syndication software written in Eiffel. For more info see award-winning pages: http://eiffelrss.berlios.de")
				
			-- Write feed to file
			create writer.make_feed (feed)
			writer.write ("example.xml", "RSS 2.0")
	end

end -- class WRITER_EXAMPLE
