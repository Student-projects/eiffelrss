indexing
	description: "Tester class for item."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_ITEM

inherit
	TS_TEST_CASE
		redefine
			set_up
		end

feature -- Test

	test_make is
			-- Test features `make_*'.
		local
			url: HTTP_URL
			item: ITEM
		do
			create url.make ("http://eiffelrss.berlios.de/Main/News")
			create item.make (channel, "Just a test", url, "This is just a test item")
			assert ("make [1]", item /= Void)
			
			create item.make_description (channel, "This is just a test item")
			assert ("make [2]", item /= Void)
			
			create item.make_title (channel, "Just a test")
			assert ("make [3]", item /= Void)
			
			assert ("make [4]", not item.is_read)
		end
		
	test_set is
			-- Test features `set_*'.
		local
			url: HTTP_URL
			categories: SORTABLE_TWO_WAY_LIST[CATEGORY]
			category: CATEGORY
			enclosure: ITEM_ENCLOSURE
			guid: ITEM_GUID
			source: ITEM_SOURCE
			date: DATE_TIME
			item: ITEM
		do
			create url.make ("http://eiffelrss.berlios.de/Main/News")
			create item.make (channel, "Just a test", url, "This is just a test item")
			
			item.set_author ("Zaphod Beeblebrox")
			assert_equal ("set [1]", "Zaphod Beeblebrox", item.author)
			assert ("set [2]", item.has_author)
			
			create categories.make
			create category.make
			categories.extend (category)
			item.set_categories (categories)
			assert_equal ("set [3]", categories, item.categories)
			assert ("set [4]", item.has_categories)
			
			item.set_channel (channel)
			assert_equal ("set  [5]", channel, item.channel)
			
			create url.make ("http://eiffelrss.berlios.de/Main/WikiSandbox")
			item.set_comments (url)
			assert_equal ("set [6]", url, item.comments)
			assert ("set [7]", item.has_comments)
			
			create date.make_now
			item.set_date_found (date)
			assert_equal ("set [8]", date, item.date_found)
			assert ("set [9]", item.date_found /= Void)
			
			item.set_description ("Just a little test...")
			assert_equal ("set [10]", "Just a little test...", item.description)
			assert ("set [11]", item.has_description)
			
			create url.make ("http://www.beeblebrox.net/test.pdf")
			create enclosure.make (url, 100, "application/pdf")
			item.set_enclosure (enclosure)
			assert_equal ("set [12]", enclosure, item.enclosure)
			assert ("set [13]", item.has_enclosure)
			
			create guid.make_perma_link ("http://beeblebrox.net/Main/News/20050127")
			item.set_guid (guid)
			assert_equal ("set [14]", guid, item.guid)
			assert ("set [15]", item.has_guid)
			
			create url.make ("http://www.beeblebrox.net/Main/News")
			item.set_link (url)
			assert_equal ("set [16]", url, item.link)
			assert ("set [17]", item.has_link )
			
			item.set_pub_date (date)
			assert_equal ("set [18]", date, item.pub_date)
			assert ("set [19]", item.has_pub_date )
			
			item.set_read (True)
			assert ("set [20]", item.is_read)
			
			create url.make ("http://www.beeblebrox.net")
			create source.make ("Beeblebrox.net", url)
			item.set_source (source)
			assert_equal ("set [21]", source, item.source)
			assert ("set [22]", item.has_source )
			
			item.set_title ("EiffelNet sucks!")
			assert_equal ("set [23]", "EiffelNet sucks!", item.title)
			assert ("set [24]", item.has_title )
		end
		
	test_categories is
			-- Test categories related features
		local
			url: HTTP_URL
			item: ITEM
			category: CATEGORY
		do
			create url.make ("http://eiffelrss.berlios.de/Main/News")
			create item.make (channel, "Just a test", url, "This is just a test item")
			assert ("categories [1]", not item.has_categories)
			
			item.add_category (create {CATEGORY}.make)
			assert ("categories [2]", item.has_categories)

			item.add_category (create {CATEGORY}.make_title ("Test"))
			item.add_category (create {CATEGORY}.make_title ("Another Test"))
			item.add_category (create {CATEGORY}.make_title_domain ("Just a test", url))
			assert ("categories [3]", not item.categories.has_order)
			
			item.sort_categories_by_title
			assert ("categories [4]", item.categories.sorted)
			
			item.sort_categories_by_domain
			assert ("categories [5]", item.categories.sorted)
			
			item.reverse_sort_categories_by_title
			assert ("categories [6]", item.categories.sorted)
			
			item.reverse_sort_categories_by_domain
			assert ("categories [7]", item.categories.sorted)
			
			create category.make_title ("FooBar")
			item.add_category (category)
			assert ("categories [8]", item.categories.has (category))
			
			item.remove_category (category)
			assert ("categories [9]", not item.categories.has (category))
		end

feature -- Access

	channel: CHANNEL
			-- Channel object
		
feature -- Setup/Teardown

	set_up is
			-- Set up
		do
			create channel.make ("Test channel", create {HTTP_URL}.make ("http://eiffelrss.berlios.de"), "Just a test channel")
		end

end -- class TEST_ITEM
