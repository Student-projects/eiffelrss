indexing
	description: "Tester class for category."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_CATEGORY

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test features `make_*'.
		local
			category: CATEGORY
			url: HTTP_URL
		do
			create category.make
			assert ("make [1]", category /= Void)
			assert_equal ("make [2]", "[unnamed category]", category.title)
			
			create category.make_title ("Category title")
			assert ("make [3]", category /= Void)
			assert_equal ("make [4]", "Category title", category.title)
			
			create url.make ("http://www.asdf.com")
			create category.make_title_domain ("Category title", url)
			assert ("make [5]", category /= Void)
			assert_equal ("make [6]", "Category title", category.title)
			assert_equal ("make [7]", url, category.domain)
			assert ("make [8]", category.has_domain)
		end
		
	test_set is
			-- Test features `set_*'.
		local
			category: CATEGORY
			url: HTTP_URL
		do
			create category.make
			
			category.set_title ("Category title")
			assert_equal ("set [1]", "Category title", category.title)
			
			create url.make ("http://www.asdf.com")
			category.set_domain (url)
			assert_equal ("set [2]", url, category.domain)
			assert ("set [3]", category.has_domain)
		end

end -- class TEST_CATEGORY
