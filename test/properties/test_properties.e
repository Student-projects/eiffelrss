indexing
	description: "Tester class for properties."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_PROPERTIES

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test feature `make'.
		local
			prop: PROPERTIES
		do
			create prop.make (10)
			assert ("make [1]", prop /= Void)
		end
		
	test_make_defaults is
			-- Test feature `make_defaults'
		local
			def: PROPERTIES
			prop: PROPERTIES
		do
			create def.make (10)
			def.put ("value", "key")
			
			create prop.make_defaults (10, def)
			assert ("make_defaults [1]", prop /= Void)
			assert_equal ("make_defaults [2]", prop.get("key"), "value")
		end
	
	test_get is
			-- Test feature `get'
		local
			def: PROPERTIES
			prop: PROPERTIES
		do
			create def.make (10)
			def.put ("def_value", "def_key")
			
			create prop.make_defaults (10, def)
			prop.put ("value", "key")
			
			assert_equal ("get [1]", prop.get ("def_key"), "def_value")
			assert_equal ("get [2]", prop.get ("key"), "value")
			assert_equal ("get [3]", prop.get ("non_existing_key"), Void)
		end
		
	test_infix_get is
			-- Test feature `&'
		local
			def: PROPERTIES
			prop: PROPERTIES
		do
			create def.make (10)
			def.put ("def_value", "def_key")
			
			create prop.make_defaults (10, def)
			prop.put ("value", "key")
			
			assert_equal ("infix get [1]", prop & "def_key", "def_value")
			assert_equal ("infix get [2]", prop & "key", "value")
			assert_equal ("infix get [3]", prop & "non_existing_key", Void)
		end
		
	test_get_default is
			-- Test feature `get_default'
		local
			def: PROPERTIES
			prop: PROPERTIES
		do
			create def.make (10)
			def.put ("def_value", "def_key")
			
			create prop.make_defaults (10, def)
			prop.put ("value", "key")
			
			assert_equal ("get [1]", prop.get_default ("def_key", "default"), "def_value")
			assert_equal ("get [2]", prop.get_default ("key", "default"), "value")
			assert_equal ("get [3]", prop.get_default ("non_existing_key", "default"),  "default")
		end
		
	test_load is
			-- Test feature `load'
		local
			settings, defaults: PROPERTIES
			input_unix, input_windows, defaults_file: PLAIN_TEXT_FILE
		do
			create input_unix.make_open_read ("./prop/input_unix.properties")
			create input_windows.make_open_read ("./prop/input_windows.properties")
			create defaults_file.make_open_read ("./prop/defaults.properties")
			
			-- Defaults
			create defaults.make (10)
			defaults.load (defaults_file)
			assert ("load: defaults non empty", not defaults.empty)
			
			-- Unix (properties file converted by dos2unix)
			create settings.make_defaults (10, defaults)
			settings.load (input_unix)
			assert ("load: Unix non empty", not settings.empty)
			assert_equal ("load [1]", settings.get_default ("hitchhikers", "Ford, Arthur"), "Zaphod, Ford, Arthur, Trillian, Marvin")
			assert_equal ("load [2]", settings & "paranoid", "Marvin")
			assert_equal ("load [3]", settings.get ("important"), "towel")
			assert_equal ("load [4]", settings.get_default ("reporter", "Ford"), "Ford")
			assert_equal ("load [5]", settings.get ("42"), "")
			assert_equal ("load [6]", settings.get ("life, the universe and everything").to_integer, 42)

			-- Windows (properties file converted by unix2dos)
			create settings.make_defaults (10, defaults)
			settings.load (input_windows)
			assert ("load: Unix non empty", not settings.empty)
			assert_equal ("load [7]", settings.get_default ("hitchhikers", "Ford, Arthur"), "Zaphod, Ford, Arthur, Trillian, Marvin")
			assert_equal ("load [8]", settings & "paranoid", "Marvin")
			assert_equal ("load [9]", settings.get ("important"), "towel")
			assert_equal ("load [10]", settings.get_default ("reporter", "Ford"), "Ford")
			assert_equal ("load [11]", settings.get ("42"), "")
			assert_equal ("load [12]", settings.get ("life, the universe and everything").to_integer, 42)
		end
		
	test_store is
			-- Test feature `store'
		local
			settings, loaded_settings: PROPERTIES
			output: PLAIN_TEXT_FILE
		do
			create output.make_create_read_write ("./prop/output.properties")
			create settings.make (10)
			create loaded_settings.make (10)
			
			settings.put ("Benjy%TFrankie", "mice")
			settings.put ("Slartibartfast", "fjord designer")
			settings.store (output, "PROPERTIES test")
			loaded_settings.load (output)
			
			assert_equal ("store [1]", settings.get ("mice"), loaded_settings.get ("mice"))
			assert_equal ("store [2]", settings.get ("fjord designer"), loaded_settings.get ("fjord designer"))
		end

end -- class PROPERTIES
