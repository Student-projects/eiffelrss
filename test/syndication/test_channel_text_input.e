indexing
	description: "Tester class for channel text input."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_CHANNEL_TEXT_INPUT

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test feature `make'.
		local
			url: HTTP_URL
			text_input: CHANNEL_TEXT_INPUT
		do
			create url.make ("http://eiffelrss.berlios.de/Main/SearchWiki/")
			create text_input.make ("Search", "Search award-winning pages", "search", url)
			assert ("make [1]", text_input /= Void)
		end
		
	test_set is
			-- Test features `set_*'.
		local
			url: HTTP_URL
			text_input: CHANNEL_TEXT_INPUT
		do
			create url.make ("http://eiffelrss.berlios.de/Main/SearchWiki/")
			create text_input.make ("Search", "Search award-winning pages", "search", url)
			
			text_input.set_description ("Enter your comment")
			assert_equal ("set [1]", "Enter your comment", text_input.description)
			
			create url.make ("http://eiffelrss.berlios.de/Main/Comments/")
			text_input.set_link (url)
			assert_equal ("set [2]", url, text_input.link)
			
			text_input.set_name ("Comments")
			assert_equal ("set [3]", "Comments", text_input.name)
			
			text_input.set_title ("Comments")
			assert_equal ("set [4]", "Comments", text_input.title)
		end

end -- class TEST_CHANNEL_TEXT_INPUT
