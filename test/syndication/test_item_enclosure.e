indexing
	description: "Tester class for item enclosure."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_ITEM_ENCLOSURE

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test feature `make'.
		local
			enclosure: ITEM_ENCLOSURE
			url: HTTP_URL
		do
			create url.make ("http://www.beeblebrox.net/test.pdf")
			create enclosure.make (url, 100, "application/pdf")
			
			assert ("make [1]", enclosure /= Void)
			assert_equal ("make [2]", url, enclosure.url)
			assert_equal ("make [3]", 100, enclosure.length)
			assert_equal ("make [4]", "application/pdf", enclosure.type)
		end
		
	test_set is
			-- Test features `set_*'.
		local
			enclosure: ITEM_ENCLOSURE
			url: HTTP_URL
		do
			create url.make ("http://www.beeblebrox.net/test.pdf")
			create enclosure.make (url, 100, "application/pdf")
			
			create url.make ("http://www.beeblebrox.net/test.html")
			enclosure.set_url (url)
			assert_equal ("set [1]", url, enclosure.url)
			
			enclosure.set_length (200)
			assert_equal ("set [2]", 200, enclosure.length)
			
			enclosure.set_type ("text/html")
			assert_equal ("set [3]", "text/html", enclosure.type)
		end

end -- class TEST_ITEM_ENCLOSURE
