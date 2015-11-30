indexing
	description: "Tester class for feed manager."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_FEED_MANAGER

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test features `make*'.
		local
			feed: FEED
			feed_manager: FEED_MANAGER
		do
			create feed_manager.make
			assert ("make [1]", feed_manager /= Void)
			
			create feed_manager.make_custom (99)
			assert ("make [2]", feed_manager /= Void)
		end
		
	test_set_default_refresh_period is
			-- Test features `set_default_refresh_period'
		local
			feed: FEED
			feed_manager: FEED_MANAGER
		do
			create feed_manager.make
			feed_manager.set_default_refresh_period (100)
			assert_equal ("set_default_refresh_period [1]", 100, feed_manager.default_refresh_period)
			
			create feed_manager.make_custom (99)
			feed_manager.set_default_refresh_period (23)
			assert_equal ("set_default_refresh_period [1]", 23, feed_manager.default_refresh_period)
		end
		
	test_basic_operations is
			-- Test basic operations
		local
			feed: FEED
			feed_manager: FEED_MANAGER
			feed_addresses: LINKED_LIST[STRING]
			list_representation: SORTABLE_TWO_WAY_LIST[FEED]
		do
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

			create feed_manager.make
			feed_manager.add (feed, "http://eiffelrss.berlios.de/Main/AllRecentChanges?action=rss")
			
			assert_equal ("basic_operations [1]", 1, feed_manager.count)
			
			feed_addresses := feed_manager.feed_addresses
			assert ("basic_operations [2]", feed_addresses /= Void)
			assert_equal ("basic_operations [3]", 1, feed_addresses.count)
			
			list_representation := feed_manager.list_representation
			assert ("basic_operations [4]", list_representation /= Void)
			assert_equal ("basic_operations [5]", 1, list_representation.count)
			
			feed_manager.add (feed, "http://beeblebrox.net/Main/AllRecentChanges?action=rss")
			
			list_representation := Void
			list_representation := feed_manager.sorted_by_description
			assert ("basic_operations [6]", list_representation /= Void)
			assert ("basic_operations [7]", list_representation.sorted)
			assert_equal ("basic_operations [8]", 2, list_representation.count)
			
			list_representation := Void
			list_representation := feed_manager.sorted_by_last_updated
			assert ("basic_operations [9]", list_representation /= Void)
			assert ("basic_operations [10]", list_representation.sorted)
			assert_equal ("basic_operations [11]", 2, list_representation.count)
			
			list_representation := Void
			list_representation := feed_manager.sorted_by_link
			assert ("basic_operations [12]", list_representation /= Void)
			assert ("basic_operations [13]", list_representation.sorted)
			assert_equal ("basic_operations [14]", 2, list_representation.count)
			
			list_representation := Void
			list_representation := feed_manager.sorted_by_title
			assert ("basic_operations [15]", list_representation /= Void)
			assert ("basic_operations [16]", list_representation.sorted)
			assert_equal ("basic_operations [17]", 2, list_representation.count)
			
			list_representation := Void
			list_representation := feed_manager.reverse_sorted_by_description
			assert ("basic_operations [18]", list_representation /= Void)
			assert ("basic_operations [19]", list_representation.sorted)
			assert_equal ("basic_operations [20]", 2, list_representation.count)
			
			list_representation := Void
			list_representation := feed_manager.reverse_sorted_by_last_updated
			assert ("basic_operations [21]", list_representation /= Void)
			assert ("basic_operations [22]", list_representation.sorted)
			assert_equal ("basic_operations [23]", 2, list_representation.count)
			
			list_representation := Void
			list_representation := feed_manager.reverse_sorted_by_link
			assert ("basic_operations [24]", list_representation /= Void)
			assert ("basic_operations [25]", list_representation.sorted)
			assert_equal ("basic_operations [26]", 2, list_representation.count)
			
			list_representation := Void
			list_representation := feed_manager.reverse_sorted_by_title
			assert ("basic_operations [27]", list_representation /= Void)
			assert ("basic_operations [28]", list_representation.sorted)
			assert_equal ("basic_operations [29]", 2, list_representation.count)
		end

end -- class TEST_FEED_MANAGER
