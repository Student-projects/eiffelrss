indexing
	description: "Tester class for item guid."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_ITEM_GUID

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test features `make_*'.
		local
			guid: ITEM_GUID
		do
			create guid.make ("NotAPermaLink")
			assert ("make [1]", guid /= Void)
			assert ("make [2]", not guid.is_perma_link)
			
			create guid.make_perma_link ("http://beeblebrox.net/Main/News/20050127")
			assert ("make [3]", guid /= Void)
			assert ("make [4]", guid.is_perma_link)			
		end
		
	test_set is
			-- Test features `set_*'.
		local
			guid: ITEM_GUID
		do
			create guid.make ("NotAPermaLink")
			assert ("set [1]", not guid.is_perma_link)
			
			guid.set_guid ("http://beeblebrox.net/Main/News/20050127")
			assert_equal ("set [2]", "http://beeblebrox.net/Main/News/20050127", guid.guid)
			
			guid.set_perma_link (True)
			assert ("set [3]", guid.is_perma_link)
			
			guid.set_perma_link (False)
			assert ("set [4]", not guid.is_perma_link)
		end

end -- class TEST_ITEM_GUID
