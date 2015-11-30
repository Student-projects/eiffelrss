indexing
	description: "Tester class for logfile."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_LOGFILE

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test feature `make'.
		local
			logfile: LOGFILE
		do
			create logfile.make_filename ("logfile.log")
			assert ("make [1]", logfile /= Void)

			create logfile.make_filename_threshold ("logfile.log", feature {LOGFILE}.Info)
			assert_equal ("make [2]", logfile.Info, logfile.output_threshold)
		end

	test_set_threshold is
			-- Test feature `set_threshold'.
		local
			logfile: LOGFILE
		do
			create logfile.make_filename ("logfile.log")
			logfile.set_threshold (logfile.Developer)
			assert_equal ("set_threshold[1]", logfile.Developer, logfile.output_threshold)
			logfile.set_threshold (logfile.Info)
			assert_equal ("set_threshold[2]", logfile.Info, logfile.output_threshold)
			logfile.set_threshold (logfile.Notice)
			assert_equal ("set_threshold[3]", logfile.Notice, logfile.output_threshold)
			logfile.set_threshold (logfile.Warning)
			assert_equal ("set_threshold[4]", logfile.Warning, logfile.output_threshold)
			logfile.set_threshold (logfile.Error)
			assert_equal ("set_threshold[5]", logfile.Error, logfile.output_threshold)
			logfile.set_threshold (logfile.Critical)
			assert_equal ("set_threshold[6]", logfile.Critical, logfile.output_threshold)
			logfile.set_threshold (logfile.Alert)
			assert_equal ("set_threshold[7]", logfile.Alert, logfile.output_threshold)
			logfile.set_threshold (logfile.Emerge)
			assert_equal ("set_threshold[8]", logfile.Emerge, logfile.output_threshold)
		end

	test_log_message is
			-- Test feature `log_message'.
		local
			logfile: LOGFILE
		do
			create logfile.make_filename_threshold ("logfile.log", feature {LOGFILE}.Notice)

			logfile.log_message ("Developer", logfile.Developer)
			logfile.log_message ("Info", logfile.Info)
			logfile.log_message ("Notice", logfile.Notice)
			logfile.log_message ("Warning", logfile.Warning)
			logfile.log_message ("Error", logfile.Error)
			logfile.log_message ("Critical", logfile.Critical)
			logfile.log_message ("Alert", logfile.Alert)
			logfile.log_message ("Emerge", logfile.Emerge)

			assert_equal ("log_message [1]", 6, logfile.messages_logged)
		end

end -- class TEST_LOGFILE
