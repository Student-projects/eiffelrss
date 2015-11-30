indexing
	description: "Tester class for feed."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_FEED

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test features `make*'.
		local
			url: HTTP_URL
			feed: FEED
			channel: CHANNEL
		do
			create feed.make ("EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/"), "EiffelRSS news")
			assert ("make [1]", feed /= Void)
			
			create url.make ("http://eiffelrss.berlios.de/Main/AllRecentChanges?action=rss")
			create channel.make ("EiffelRSS", url, "EiffelRSS news")
			create feed.make_from_channel (channel)
			assert ("make [2]", feed /= Void)
		end
		
	test_set is
			-- Test features `set_*'
		local
			feed: FEED
			channel: CHANNEL
			url: HTTP_URL
			date: DATE_TIME
		do
			create feed.make ("EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/"), "EiffelRSS news")
		
			feed.set_refresh_period (10)
			assert_equal ("set [1]", 10, feed.refresh_period)
			assert ("set [2]", feed.has_refresh_period)
			
			create date.make_now
			feed.set_last_updated (date)
			assert_equal ("set [3]", date, feed.last_updated)
			assert ("set [4]", feed.has_last_updated)
			
			create url.make ("http://www.beeblebrox.net/rss2")
			create channel.make ("Beeblebrox.net", url, "Beeblebrox.net news")
			feed.set_channel (channel)
			assert_equal ("set [5]", "Beeblebrox.net", feed.title)
			assert_equal ("set [6]", url, feed.link)
			assert_equal ("set [7]", "Beeblebrox.net news", feed.description)
		end
		
	test_basic_operations is
			-- Test basic operations
		local
			feed: FEED
		do
			-- Create a simple feed with some categories
			create feed.make ("EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/"), "EiffelRSS news")
			feed.add_category (create {CATEGORY}.make_title ("RSS"))
			feed.add_category (create {CATEGORY}.make_title ("Programming"))
			feed.add_category (create {CATEGORY}.make_title ("Eiffel"))
			assert ("basic_operations [1]", feed.has_categories)
			
			-- Add a cloud to feed
			feed.create_cloud ("eiffelrss.berlios.de", 80, "/RPC2", "xmlStorageSystem.rssPleaseNotify", "xml-rpc")
			assert ("basic_operations [2]", feed.has_categories)
			
			-- Add an image to feed
			feed.create_image (create {HTTP_URL}.make ("http://eiffelrss.berlios.de/logo.png"), "EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de"))
			assert ("basic_operations [3]", feed.has_image)
			
			-- Add a text input field to feed
			feed.create_text_input ("Search", "Search award-winning pages", "search", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/SearchWiki/"))
			assert ("basic_operations [4]", feed.has_text_input)
			
			-- Add some simple items, use `feed.last_added_item' or directly create an item for finer control
			feed.new_item ("Version 23 released!", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/News"), 
				"Version 23 of EiffelRSS got release today. Happy syndicating!")
			feed.last_added_item.add_category (create {CATEGORY}.make_title_domain ("News", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/News/")))
			assert ("basic_operations [5]", feed.has_items)
			
			feed.new_item ("Microsoft uses EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/WhoUsesEiffelRSS"), 
				"Microsoft announced in a press release today that they will use EiffelRSS to syndicate news on their website.")
			feed.last_added_item.set_source (create {ITEM_SOURCE}.make ("Microsoft", create {HTTP_URL}.make ("http://www.microsoft.com")))
			feed.last_added_item.set_enclosure (create {ITEM_ENCLOSURE}.make (create {HTTP_URL}.make ("http://eiffelrss.berlios.de/files/ms-press-release.pdf"), 1000, "application/pdf"))
				
			feed.new_item ("EiffelRSS wins award", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/Awards"),
				"EiffelRSS has been awarded by ISE as best syndication software written in Eiffel. For more info see award-winning pages: http://eiffelrss.berlios.de")
			feed.last_added_item.set_guid (create {ITEM_GUID}.make_perma_link ("http://eiffelrss.berlios.de/newsItem42"))	
			assert_equal ("basic_operation [6]", 3, feed.items.count)
		end

end -- class TEST_FEED
