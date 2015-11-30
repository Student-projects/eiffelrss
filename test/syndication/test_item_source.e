indexing
	description: "Tester class for item source."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_ITEM_SOURCE

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test feature `make'.
		local
			source: ITEM_SOURCE
			url: HTTP_URL
		do
			create url.make ("http://www.beeblebrox.net")
			create source.make ("Beeblebrox.net", url)
			
			assert ("make [1]", source /= Void)
			assert_equal ("make [2]", "Beeblebrox.net", source.name)
			assert_equal ("make [3]", url, source.url)
		end
		
	test_set is
			-- Test features `set_*'.
		local
			source: ITEM_SOURCE
			url: HTTP_URL
		do
			create url.make ("http://www.beeblebrox.net")
			create source.make ("Beeblebrox.net", url)
			
			source.set_name ("Zaphod.Beeblebrox.net")
			assert_equal ("make [2]", "Zaphod.Beeblebrox.net", source.name)
			
			create url.make ("http://zaphod.beeblebrox.net")
			source.set_url (url)
			assert_equal ("make [3]", url, source.url)
		end

end -- class TEST_ITEM_SOURCE
