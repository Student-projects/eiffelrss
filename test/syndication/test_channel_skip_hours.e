indexing
	description: "Tester class for channel skip hours."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_CHANNEL_SKIP_HOURS

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test feature `make'.
		local
			skip_hours: CHANNEL_SKIP_HOURS
		do
			create skip_hours.make
			assert ("make [1]", skip_hours /= Void)
		end
		
	test_element_change is
			-- Test features `put' and `extend'.
		local
			skip_hours: CHANNEL_SKIP_HOURS
		do
			create skip_hours.make
			skip_hours.extend (23)
			assert_equal ("element_change [1]", 23, skip_hours.last)
			
			skip_hours.extend (3)
			assert_equal ("element_change [2]", 23, skip_hours.last)
			assert_equal ("element_change [3]", 3, skip_hours.first)
		end

end -- class TEST_CHANNEL_SKIP_HOURS
