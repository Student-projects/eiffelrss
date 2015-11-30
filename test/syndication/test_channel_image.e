indexing
	description: "Tester class for channel image."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_CHANNEL_IMAGE

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test feature `make'.
		local
			url: HTTP_URL
			link: HTTP_URL
			image: CHANNEL_IMAGE
		do
			create url.make ("http://eiffelrss.berlios.de/logo.png")
			create link.make ("http://eiffelrss.berlios.de")
			create image.make (url, "EiffelRSS", link)
			assert ("make [1]", image /= Void)
		end
		
	test_set is
			-- Test features `set_*'.
		local
			url: HTTP_URL
			link: HTTP_URL
			image: CHANNEL_IMAGE
		do
			create url.make ("http://eiffelrss.berlios.de/logo.png")
			create link.make ("http://eiffelrss.berlios.de")
			create image.make (url, "EiffelRSS", link)
			
			image.set_description ("EiffelRSS Logo")
			assert_equal ("set [1]", "EiffelRSS Logo", image.description)
			assert ("set [2]", image.has_description)
			
			image.set_height (23)
			assert_equal ("set [3]", 23, image.height)
			assert ("set [4]", image.has_height)
			
			create link.make ("http://eiffelrss.berlios.de/Main/News")
			image.set_link (link)
			assert_equal ("set [5]", link, image.link)
			
			image.set_title ("EiffelRSS - An Eiffel RSS library")
			assert_equal ("set [6]", "EiffelRSS - An Eiffel RSS library", image.title)

			create url.make ("http://eiffelrss.berlios.de/logo2.png")
			image.set_url (url)
			assert_equal ("set [7]", url, image.url)
			
			image.set_width (42)
			assert_equal ("set [8]", 42, image.width)
			assert ("set [9]", image.has_width)
		end

end -- class TEST_CHANNEL_IMAGE
