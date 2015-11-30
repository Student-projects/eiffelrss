indexing
	description: "Example class for feed manager."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	FEED_MANAGER_EXAMPLE

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			-- Create a simple feed with some categories
			create feed.make ("EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de"), "EiffelRSS news")
			feed.add_category (create {CATEGORY}.make_title ("RSS"))
			feed.add_category (create {CATEGORY}.make_title ("Programming"))
			feed.add_category (create {CATEGORY}.make_title ("Eiffel"))
			feed.set_refresh_period (15)
			feed.set_last_updated (create {DATE_TIME}.make_now)
			
			-- Add a cloud to feed
			feed.create_cloud ("eiffelrss.berlios.de", 80, "/RPC2", "xmlStorageSystem.rssPleaseNotify", "xml-rpc")
			
			-- Add an image to feed
			feed.create_image (create {HTTP_URL}.make ("http://eiffelrss.berlios.de/logo.png"), "EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de"))
			
			-- Add a text input field to feed
			feed.create_text_input ("Search", "Search award-winning pages", "search", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/SearchWiki/"))
			
			-- Add some simple items, use `feed.last_added_item' or directly create an item for finer control
			feed.new_item ("Version 23 released!", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/News"), 
				"Version 23 of EiffelRSS got release today. Happy syndicating!")
			feed.last_added_item.add_category (create {CATEGORY}.make_title_domain ("News", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/News/")))
			
			feed.new_item ("Microsoft uses EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/WhoUsesEiffelRSS"), 
				"Microsoft announced in a press release today that they will use EiffelRSS to syndicate news on their website.")
			feed.last_added_item.set_source (create {ITEM_SOURCE}.make ("Microsoft", create {HTTP_URL}.make ("http://www.microsoft.com")))
			feed.last_added_item.set_enclosure (create {ITEM_ENCLOSURE}.make (create {HTTP_URL}.make ("http://eiffelrss.berlios.de/files/ms-press-release.pdf"), 1000, "application/pdf"))
				
			feed.new_item ("EiffelRSS wins award", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/Awards"),
				"EiffelRSS has been awarded by ISE as best syndication software written in Eiffel. For more info see award-winning pages: http://eiffelrss.berlios.de")
			feed.last_added_item.set_guid (create {ITEM_GUID}.make_perma_link ("http://eiffelrss.berlios.de/newsItem42"))

			io.put_string ("Feed manager:%N")
			io.put_string ("============%N%N%N")

			create feed_manager.make
			feed_manager.add (feed, "http://eiffelrss.berlios.de/Main/AllRecentChanges?action=rss")
			feed_manager.refresh_all
			io.put_string (feed_manager.item ("http://eiffelrss.berlios.de/Main/AllRecentChanges?action=rss").to_string)
		end
		
feature -- Arguments

	feed: FEED
			-- Example feed
			
	feed_manager: FEED_MANAGER
			-- Feed manager

end -- class FEED_MANAGER_EXAMPLE
