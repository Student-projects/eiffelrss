indexing
	description: "Properties of Application"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

deferred class
	APPLICATION_PROPERTIES

inherit
	LOGGER

feature -- Properties
	
	application_default_properties: PROPERTIES
			-- default properties that cannot be changed
	application_properties: PROPERTIES
			-- customized application properties
	user_properties: PROPERTIES
			-- properties set on a per user basis
	
	properties: PROPERTIES is
			-- get application or user properties based on 'User_specific'
		do
			if user_properties.get ("User_specific").is_equal ("yes") then
				Result := user_properties
			else
				Result := application_properties
			end
		end
	
	load_properties is
			-- load properties in right order
		do
			load_application_default_properties
			load_application_properties
			load_user_properties
			logfile.log_message ("All properties loaded", feature{LOGFILE}.Info)
		ensure
			properties_not_void: properties /= void
		end
		
	save_properties is
			-- save properties
		local
			path: STRING
			filename: STRING
			file: PLAIN_TEXT_FILE
		do
				-- save application_properties
			create file.make_open_write ("settings" + operating_environment.directory_separator.out + application_default_properties.get ("application_properties_file"))
			application_properties.store (file, "newsreader preferences")
			
				-- save user properties, overwrite application_properties file if User_specific is 'no'
			if properties.get ("User_specific").is_equal ("yes") then
				path := user_properties_path
				filename := application_default_properties.get ("user_properties_file")
				create file.make_open_write (path + operating_environment.directory_separator.out + filename)
				properties.store (file, "newsreader user preferences")
			end

		end

	load_application_properties is
			-- load custom properties from file
		require
			application_default_properties_not_void: application_default_properties /= void
		local
			file: PLAIN_TEXT_FILE
			filename: STRING
			dir: DIRECTORY
		do
				-- open directory 'settings', create if not exists
			create dir.make ("settings")
			if not dir.exists then
				dir.create_dir
			end
			
				-- open file in read_write mode, create if not exists
			filename := "settings" + operating_environment.directory_separator.out + application_default_properties.get ("application_properties_file")
			create file.make (filename)
			if not file.exists then
				file.create_read_write
			else
				file.open_read_write
			end
				
				-- create application_properties, set defaults to application_default_properties
			create application_properties.make_defaults (20, application_default_properties)
			
				-- load properties from file
			application_properties.load (file)
			
			logfile.log_message ("Application properties loaded from '" + file.name + "'", feature{LOGFILE}.Info)
			check_and_correct_properties (application_properties)
		ensure
			application_properties_loaded: application_properties /= void
		end
	
	load_user_properties is
			-- load user properties from file in user directory
		require
			application_properties_not_void: application_properties /= void
		local
			file: PLAIN_TEXT_FILE
		do
				-- create properties, set default to application_properties
			create user_properties.make_defaults (20, application_properties)
				
				-- if User_specific is 'yes', load user properties file, create if not exists
			if (user_properties.get ("User_specific")).is_equal ("yes") then
				
				create file.make (user_properties_path + operating_environment.directory_separator.out + application_default_properties.get ("user_properties_file"))
				if not file.exists then
					file.create_read_write
				else
					file.open_read_write
				end
				user_properties.load (file)
			
				logfile.log_message ("User properties loaded from '" + file.name + "'",feature{LOGFILE}.Info)
				
			end
			check_and_correct_properties (user_properties)
		end
		
feature {NONE} -- Implementation

	load_application_default_properties is
			-- load default properties into default_properties
		do
				-- create application_default_properties and put values in it
			create application_default_properties.make (10)
			application_default_properties.put ("newsreader","Window_title")
			application_default_properties.put ("800","Window_width")
			application_default_properties.put ("600","Window_height")
			application_default_properties.put ("yes","Ask_on_exit")
			application_default_properties.put ("no", "User_specific")
			application_default_properties.put ("no", "Share_feeds")
			application_default_properties.put ("yes", "Show_toolbar")
			application_default_properties.put ("[0]mm/[0]dd/yyyy [0]hh:[0]mi", "Date_format")
			application_default_properties.put ("feeds", "Feed_file")
			
			
				-- properties that cannot be changed 
			application_default_properties.put ("user.properties","user_properties_file")
			application_default_properties.put ("default.properties","application_properties_file")

			logfile.log_message ("Application default properties loaded",feature{LOGFILE}.Developer)
			check_and_correct_properties (application_default_properties)
		ensure
			application_default_properties_loaded: application_default_properties /= void
		end
	
	check_and_correct_properties (p: PROPERTIES) is
			-- check p for validity and remove incorrect entries
		require
			p_not_void: p /= void
		do
			if not p.get ("Window_width").is_integer then
				logfile.log_message ("WARNING: Window_width is no integer, loading default value",feature{LOGFILE}.Warning)
				p.remove ("Window_width")
			end
			if p.get ("Window_width").to_integer <= 0 then
				logfile.log_message ("WARNING: Window_width is negative, loading default value", feature{LOGFILE}.Warning)
				p.remove ("Window_widht")
			end
			if not p.get ("Window_height").is_integer then
				logfile.log_message ("WARNING: Window_height is no integer, loading default value", feature{LOGFILE}.Warning)
				p.remove ("Window_height")
			end
			if p.get ("Window_height").to_integer <= 0 then
				logfile.log_message ("WARNING: Window_height is negative, loading default value", feature{LOGFILE}.Warning)
				p.remove ("Window_height")
			end
			if not (p.get ("Ask_on_exit").is_equal ("yes") or p.get ("Ask_on_exit").is_equal ("no")) then
				logfile.log_message ("WARNING: Ask_on_exit is not 'yes' or 'no', loading default value", feature{LOGFILE}.Warning)
				p.remove ("Ask_on_exit")
			end
			if not (p.get ("User_specific").is_equal ("yes") or p.get ("User_specific").is_equal ("no")) then
				logfile.log_message ("WARNING: User_specific is not 'yes' or 'no', loading default value", feature{LOGFILE}.Warning)
				p.remove ("User_specific")
			end
			if not (p.get ("Share_feeds").is_equal ("yes") or p.get ("Share_feeds").is_equal ("no")) then
				logfile.log_message ("WARNING: Share_feeds is not 'yes' or 'no', loading default value", feature{LOGFILE}.Warning)
				p.remove ("Share_feeds")
			end
			if not (p.get ("Show_toolbar").is_equal ("yes") or p.get ("Show_toolbar").is_equal ("no")) then
				logfile.log_message ("WARNING: Show_toolbar is not 'yes' or 'no', loading default value", feature{LOGFILE}.Warning)
				p.remove ("Show_toolbar")
			end
		end
	
	user_properties_path: STRING is
			-- path to custom properties file
			-- will create path if not exists
		local
			env: EXECUTION_ENVIRONMENT
			platform: PLATFORM
			dir: DIRECTORY
		do
			create platform
			create env
			Result := "settings"
				-- platform specific path
			if platform.is_windows then
				Result := env.get ("APPDATA")
				create dir.make (Result)
				if dir.exists then
					Result := Result + operating_environment.directory_separator.out + "newsreader"
				else
					Result := "settings"
				end
			elseif platform.is_unix then
				Result := env.get ("HOME")
				create dir.make (Result)
				if dir.exists then
					Result := Result + operating_environment.directory_separator.out + ".newsreader"
				else
					Result := "settings"
				end
			end
			
				-- create directory if not exists
			create dir.make (Result)
			if not dir.exists then
				dir.create_dir
			end
		end


invariant
	application_default_properties_not_void: application_default_properties /= void
	application_properties_not_void: application_properties /= void
	user_properties_not_void: user_properties /= void
	
end -- class APPLICATION_PROPERTIES
