indexing
	description: "Tester class for channel."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_CHANNEL

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test features `make_*'.
		local
			url: HTTP_URL
			channel: CHANNEL
		do
			create url.make ("http://eiffelrss.berlios.de/")
			create channel.make ("Just a test", url, "This is just a test item")
			assert ("make [1]", channel /= Void)
		end
		
	test_set is
			-- Test features `set_*'.
		local
			url: HTTP_URL
			categories: SORTABLE_TWO_WAY_LIST[CATEGORY]
			category: CATEGORY
			cloud: CHANNEL_CLOUD
			image: CHANNEL_IMAGE
			text_input: CHANNEL_TEXT_INPUT
			date: DATE_TIME
			skip_hours: CHANNEL_SKIP_HOURS
			skip_days: CHANNEL_SKIP_DAYS
			item: ITEM	
			items: SORTABLE_TWO_WAY_LIST[ITEM]
			item_toc_list: TWO_WAY_LIST[URL]
			observers: TWO_WAY_LIST[SIMPLE_CHANNEL_OBSERVER]
			channel: CHANNEL
		do
			create url.make ("http://eiffelrss.berlios.de/")
			create channel.make ("EiffelRSS", url, "EiffelRSS news")
			
			create categories.make
			create category.make
			categories.extend (category)
			channel.set_categories (categories)
			assert_equal ("set [1]", categories, channel.categories)
			assert ("set [2]", channel.has_categories)
			
			create cloud.make ("eiffelrss.berlios.de", 80, "/RPC2", "xmlStorageSystem.rssPleaseNotify", "xml-rpc")
			channel.set_cloud (cloud)
			assert_equal ("set [3]", cloud, channel.cloud)
			assert ("set [4]", channel.has_cloud)
			
			channel.set_copyright ("Copyleft 2005 Zaphod Beeblebrox")
			assert_equal ("set [5]", "Copyleft 2005 Zaphod Beeblebrox", channel.copyright)
			assert ("set [6]", channel.has_copyright)

			channel.set_description ("EiffelRSS Project")
			assert_equal ("set [7]", "EiffelRSS Project", channel.description)
			
			create url.make ("http://feedvalidator.org/docs/rss2.html")
			channel.set_docs (url)
			assert_equal ("set [8]", url, channel.docs)
			assert ("set [9]", channel.has_docs)
			
			channel.set_feed_generator ("EiffelRSS")
			assert_equal ("set [10]", "EiffelRSS", channel.feed_generator)
			assert ("set [11]", channel.has_feed_generator)
		
			create image.make (create {HTTP_URL}.make ("http://eiffelrss.berlios.de/logo.png"), "EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de"))
			channel.set_image (image)
			assert_equal ("set [12]", image, channel.image)
			assert ("set [13]", channel.has_image)
			
			create items.make
			create item.make (channel, "Version 23 released!", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/News"), 
				"Version 23 of EiffelRSS got release today. Happy syndicating!")
			items.extend (item)
			channel.set_items (items)
			assert_equal ("set [14]", items, channel.items)
			assert ("set [15]", channel.has_items)

			create item_toc_list.make
			item_toc_list.extend (create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/News"))
			channel.set_items_toc (item_toc_list)
			assert_equal ("set [16]", item_toc_list, channel.items_toc)
			assert ("set [17]", channel.has_items_toc)
			
			channel.set_language ("en")
			assert_equal ("set [18]", "en", channel.language)
			assert ("set [19]", channel.has_language)
			
			create date.make_now
			channel.set_last_build_date (date)
			assert_equal ("set [20]", date, channel.last_build_date)
			assert ("set [21]", channel.has_last_build_date)
			
			create url.make ("http://eiffelrss.berlios.de/Main/AllRecentChanges")
			channel.set_link (url)
			assert_equal ("set [22]", url, channel.link)
			
			channel.set_managing_editor ("Zaphod Beeblebrox")
			assert_equal ("set [23]", "Zaphod Beeblebrox", channel.managing_editor)
			assert ("set [24]", channel.has_managing_editor)
			
			create observers.make
			observers.extend (create {SIMPLE_CHANNEL_OBSERVER})
			channel.set_observers (observers)
			assert_equal ("set [25]", observers, channel.observers)
			assert ("set [26]", channel.has_observers)
			
			channel.set_pub_date (date)
			assert_equal ("set [27]", date, channel.pub_date)
			assert ("set [28]", channel.has_pub_date)
			
			channel.set_rating ("(PICS-1.1 %"http://www.classify.org/safesurf/%" l r (SS~~000 1)))")
			assert_equal ("set [29]", "(PICS-1.1 %"http://www.classify.org/safesurf/%" l r (SS~~000 1)))", channel.rating)
			assert ("set [30]", channel.has_rating)
			
			create skip_days.make
			skip_days.extend ("MoNdAy")
			skip_days.extend ("FrIDAY")
			channel.set_skip_days (skip_days)
			assert_equal ("set [31]", skip_days, channel.skip_days)
			assert ("set [32]", channel.has_skip_days)
			
			create skip_hours.make
			skip_hours.extend (23)
			skip_hours.extend (5)
			channel.set_skip_hours (skip_hours)
			assert_equal ("set [33]", skip_days, channel.skip_days)
			assert ("set [34]", channel.has_skip_hours)
			
			create url.make ("http://eiffelrss.berlios.de/Main/SearchWiki/")
			create text_input.make ("Search", "Search award-winning pages", "search", url)
			channel.set_text_input (text_input)
			assert_equal ("set [35]", text_input, channel.text_input)
			assert ("set [36]", channel.has_text_input)
			
			channel.set_textinput (url)
			assert_equal ("set [37]", url, channel.textinput)
			assert ("set [38]", channel.has_textinput)
			
			channel.set_title ("A new title")
			assert_equal ("set [39]", "A new title", channel.title)
			
			channel.set_ttl (10)
			assert_equal ("set [40]", 10, channel.ttl)
			assert ("set [41]", channel.has_ttl)
			
			channel.set_web_master ("Ford Prefect")
			assert_equal ("set [42]", "Ford Prefect", channel.web_master)
			assert ("set [43]", channel.has_web_master)
		end
		
	test_add_remove is
			-- Test `add_*' and `remove_*' features
		local
			channel: CHANNEL
			url: HTTP_URL
			channel_observer: SIMPLE_CHANNEL_OBSERVER
		do
			create url.make ("http://eiffelrss.berlios.de/")
			create channel.make ("Just a test", url, "This is just a test item")
			
			channel.add_item_toc (url)
			assert ("add_remove [1]", channel.items_toc.has (url))
			
			channel.remove_item_toc (url)
			assert ("add_remove [2]", not channel.items_toc.has (url))
			
			create channel_observer
			channel.add_observer (channel_observer)
			assert ("add_remove [3]", channel.observers.has (channel_observer))
			
			channel.remove_observer (channel_observer)
			assert ("add_remove [4]", not channel.observers.has (channel_observer))
			
			channel.add_skip_day ("SatURDAY")
			assert ("add_remove [5]", channel.skip_days.has ("Saturday"))
			
			channel.remove_skip_day ("Saturday")
			assert ("add_remove [6]", not channel.skip_days.has ("Saturday"))

			channel.add_skip_hour (0)
			assert ("add_remove [7]", channel.skip_hours.has (0))
			
			channel.remove_skip_hour (0)
			assert ("add_remove [8]", not channel.skip_hours.has (0))
		end
		
		
	test_items is
			-- Test item related features
		local
			url: HTTP_URL
			channel: CHANNEL
			item: ITEM
		do
			create url.make ("http://eiffelrss.berlios.de/")
			create channel.make ("Just a test", url, "This is just a test item")
			assert ("items [1]", not channel.has_items)
			
			channel.add_item (create {ITEM}.make (channel, "Version 23 released!", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/News"), 
				"Version 23 of EiffelRSS got release today. Happy syndicating!"))
			channel.last_added_item.add_category (create {CATEGORY}.make_title_domain ("News", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/News/")))
			assert ("items [2]", channel.has_items)
			
			channel.add_item (create {ITEM}.make (channel, "Microsoft uses EiffelRSS", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/WhoUsesEiffelRSS"), 
				"Microsoft announced in a press release today that they will use EiffelRSS to syndicate news on their website."))
			channel.last_added_item.set_source (create {ITEM_SOURCE}.make ("Microsoft", create {HTTP_URL}.make ("http://www.microsoft.com")))
			channel.last_added_item.set_enclosure (create {ITEM_ENCLOSURE}.make (create {HTTP_URL}.make ("http://eiffelrss.berlios.de/files/ms-press-release.pdf"), 1000, "application/pdf"))
			channel.add_item (create {ITEM}.make (channel, "EiffelRSS wins award", create {HTTP_URL}.make ("http://eiffelrss.berlios.de/Main/Awards"),
				"EiffelRSS has been awarded by ISE as best syndication software written in Eiffel. For more info see award-winning pages: http://eiffelrss.berlios.de"))
			channel.last_added_item.set_guid (create {ITEM_GUID}.make_perma_link ("http://eiffelrss.berlios.de/newsItem42"))	
			assert ("items [3]", not channel.items.has_order)
			
			channel.sort_items_by_link
			assert ("items [4]", channel.items.sorted)
			
			channel.sort_items_by_pub_date
			assert ("items [5]", channel.items.sorted)
			
			channel.sort_items_by_title
			assert ("items [6]", channel.items.sorted)
			
			channel.reverse_sort_items_by_link
			assert ("items [7]", channel.items.sorted)
			
			channel.reverse_sort_items_by_pub_date
			assert ("items [8]", channel.items.sorted)
			
			channel.reverse_sort_items_by_title
			assert ("items [9]", channel.items.sorted)
			
			create item.make_title (channel, "Just a test!")
			channel.add_item (item)
			assert ("items [10]", channel.items.has (item))
			
			channel.remove_item (item)
			assert ("items [11]", not channel.items.has (item))
		end
		
	test_categories is
			-- Test categories related features
		local
			url: HTTP_URL
			channel: CHANNEL
			category: CATEGORY
		do
			create url.make ("http://eiffelrss.berlios.de/")
			create channel.make ("Just a test", url, "This is just a test item")
			assert ("categories [1]", not channel.has_categories)
			
			channel.add_category (create {CATEGORY}.make)
			assert ("categories [2]", channel.has_categories)

			channel.add_category (create {CATEGORY}.make_title ("Test"))
			channel.add_category (create {CATEGORY}.make_title ("Another Test"))
			channel.add_category (create {CATEGORY}.make_title_domain ("Just a test", url))
			assert ("categories [3]", not channel.categories.has_order)
			
			channel.sort_categories_by_title
			assert ("categories [4]", channel.categories.sorted)
			
			channel.sort_categories_by_domain
			assert ("categories [5]", channel.categories.sorted)
			
			channel.reverse_sort_categories_by_title
			assert ("categories [6]", channel.categories.sorted)
			
			channel.reverse_sort_categories_by_domain
			assert ("categories [7]", channel.categories.sorted)
			
			create category.make_title ("FooBar")
			channel.add_category (category)
			assert ("categories [8]", channel.categories.has (category))
			
			channel.remove_category (category)
			assert ("categories [9]", not channel.categories.has (category))
		end

end -- class TEST_CHANNEL
