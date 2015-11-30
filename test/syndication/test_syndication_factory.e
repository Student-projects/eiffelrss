indexing
	description: "Tester class for syndication factory."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_SYNDICATION_FACTORY

inherit
	TS_TEST_CASE

feature -- Test

	test_new is
			-- Test features `new_*'.
		local
			syndication: SYNDICATION_FACTORY
			feed_reader: FEED_READER
			feed_manager: FEED_MANAGER
			feed: FEED
			channel: CHANNEL
			channel_cloud: CHANNEL_CLOUD
			channel_image: CHANNEL_IMAGE
			channel_text_input: CHANNEL_TEXT_INPUT
			item: ITEM
			item_enclosure: ITEM_ENCLOSURE
			item_guid: ITEM_GUID
			item_source: ITEM_SOURCE
			category: CATEGORY
		do
			create syndication
			assert ("new [1]", syndication /= Void)
			
			category := syndication.new_category
			assert ("new [2]", category /= Void)
			
			category := syndication.new_category_with_title ("My title")
			assert ("new [3]", category /= Void)
			
			category := syndication.new_category_with_title_domain ("My title", create {HTTP_URL}.make ("http://mydomain.com/"))
			assert ("new [4]", category /= Void)
			
			channel := syndication.new_channel ("My channel", create {HTTP_URL}.make ("http://mydomain.com/"), "This is my little channel")
			assert ("new [5]", channel /= Void)
			
			channel_cloud := syndication.new_channel_cloud ("eiffelrss.berlios.de", 80, "/RPC2", "xmlStorageSystem.rssPleaseNotify", "xml-rpc")
			assert ("new [6]", channel_cloud /= Void)
			
			channel_image := syndication.new_channel_image (create {HTTP_URL}.make ("http://eiffelrss.berlios.de/logo.png"), "EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de"))
			assert ("new [7]", channel_image /= Void)
			
			channel_text_input := syndication.new_channel_text_input ("Search", "Search award-winning pages", "search", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/SearchWiki/"))
			assert ("new [8]", channel_text_input /= Void)
			
			feed := syndication.new_feed ("EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/"), "EiffelRSS news")
			assert ("new [9]", feed /= Void)
			
			feed := syndication.new_feed_from_channel (channel)
			assert ("new [10]", feed /= Void)
			
			feed_manager := syndication.new_feed_manager
			assert ("new [11]", feed_manager /= Void)
			
			feed_manager := syndication.new_feed_manager_custom (10)
			assert ("new [12]", feed_manager /= Void)
			
			item := syndication.new_item (channel, "Version 23 released!", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/News"), 
				"Version 23 of EiffelRSS got release today. Happy syndicating!")
			assert ("new [13]", item /= Void)
			
			item_enclosure := syndication.new_item_enclosure (create {HTTP_URL}.make ("http://eiffelrss.berlios.de/files/ms-press-release.pdf"), 1000, "application/pdf")
			assert ("new [14]", item_enclosure /= Void)
			
			item_guid := syndication.new_item_guid ("http://eiffelrss.berlios.de/newsItem42")
			assert ("new [15]", item_guid /= Void)
			
			item_guid := syndication.new_item_guid_perma_link ("http://eiffelrss.berlios.de/newsItem42")
			assert ("new [16]", item_guid /= Void)
			
			item_source := syndication.new_item_source ("ISE", create {HTTP_URL}.make ("http://www.eiffel.com"))
			assert ("new [17]", item_source /= Void)
			
			item := syndication.new_item_with_description (channel, "Just a simple item")
			assert ("new [18]", item /= Void)
			
			item := syndication.new_item_with_title (channel, "Simple item")
			assert ("new [19]", item /= Void)
			
			feed_reader := syndication.new_reader_from_url ("http://eiffelrss.berlios.de/")
			assert ("new [20]", feed_reader /= Void)
		end

end -- class TEST_SYNDICATION_FACTORY
