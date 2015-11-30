indexing
	description: "Tester class for fetch."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_FETCH

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test feature `make'.
		local
			fetcher: FETCH
		do
			create fetcher.make
			assert_equal ("make [1]", fetcher.Invalid_address, fetcher.error)

			create fetcher.make_source ("http://www.ethz.ch")
			assert_equal ("make [2]", "http://www.ethz.ch", fetcher.source_address)
			assert_equal ("make [3]", fetcher.None, fetcher.error)

			create fetcher.make_source ("file:///home/user/test.txt")
			assert_equal ("make [4]", "file:///home/user/test.txt", fetcher.source_address)
			assert_equal ("make [5]", fetcher.None, fetcher.error)

			create fetcher.make_source ("ftp://ftp.ethz.ch")
			assert_equal ("make [6]", "ftp://ftp.ethz.ch", fetcher.source_address)
			assert_equal ("make [7]", fetcher.Invalid_address, fetcher.error)
		end

	test_set_address is
			-- Test feature `set_address'.
		local
			fetcher: FETCH
		do
			create fetcher.make
			assert_equal ("set_address [1]", fetcher.source_address, Void)
			
			fetcher.set_address ("http://www.ethz.ch")
			assert_equal ("set_address [2]", "http://www.ethz.ch", fetcher.source_address)
			assert_equal ("set_address [3]", fetcher.None, fetcher.error)

			fetcher.set_address ("file:///home/user/test.txt")
			assert_equal ("set_address [4]", "file:///home/user/test.txt", fetcher.source_address)
			assert_equal ("set_address [5]", fetcher.None, fetcher.error)

			fetcher.set_address ("ftp://ftp.ethz.ch")
			assert_equal ("set_address [6]", "ftp://ftp.ethz.ch", fetcher.source_address)
			assert_equal ("set_address [7]", fetcher.Invalid_address, fetcher.error)
		end

	test_fetch is
			-- Test feature `fetch'.
		local
			fetcher: FETCH
		do
			create fetcher.make_source ("./ise55_linux")
			fetcher.fetch
			assert ("fetch [1]", fetcher.data /= Void)

			create fetcher.make_source ("./ise55_windows")
			fetcher.fetch
			assert ("fetch [2]", fetcher.data /= Void)
		end

end -- class TEST_FETCH
