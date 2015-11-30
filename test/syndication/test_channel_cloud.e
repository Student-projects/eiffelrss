indexing
	description: "Tester class for channel cloud."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_CHANNEL_CLOUD

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test feature `make'.
		local
			cloud: CHANNEL_CLOUD
		do
			create cloud.make ("eiffelrss.berlios.de", 80, "/RPC2", "xmlStorageSystem.rssPleaseNotify", "xml-rpc")
			assert ("make [1]", cloud /= Void)
		end
		
	test_set is
			-- Test features `set_*'.
		local
			cloud: CHANNEL_CLOUD
		do
			create cloud.make ("eiffelrss.berlios.de", 80, "/RPC2", "xmlStorageSystem.rssPleaseNotify", "xml-rpc")

			cloud.set_domain ("beeblebrox.net")
			assert_equal ("set [1]", "beeblebrox.net", cloud.domain)
			
			cloud.set_port (42)
			assert_equal ("set [2]", 42, cloud.port)
			
			cloud.set_path ("/RPC")
			assert_equal ("set [3]", "/RPC", cloud.path)
		
			cloud.set_register_procedure ("xmlStorageSystem.rssPleaseNotify2")
			assert_equal ("set [4]", "xmlStorageSystem.rssPleaseNotify2", cloud.register_procedure)
			
			cloud.set_protocol ("xml-rpc2")
			assert_equal ("set [5]", "xml-rpc2", cloud.protocol)
		end

end -- class TEST_CHANNEL_CLOUD
