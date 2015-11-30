indexing
	description: "Example class for properties."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	PROPERTIES_EXAMPLE

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do	
			-- Open files
			create input_file.make_open_read ("./prop/input.properties")
			create output_file.make_create_read_write ("./prop/output.properties")
			create defaults_file.make_open_read ("./prop/defaults.properties")
			
			-- Create default properties
			create defaults.make (10)
			-- Load default properties from file
			defaults.load (defaults_file)
			-- Display defaults
			io.put_string ("Defaults: %N")
			io.put_string ("=========%N")
			io.put_string (defaults.list)
			
			io.put_new_line
			
			-- Create properties
			create settings.make_defaults (10, defaults)
			-- Load settings from file
			settings.load (input_file)
			-- Display defaults
			io.put_string ("Settings: %N")
			io.put_string ("=========%N")
			io.put_string (settings.list)
			
			io.put_new_line
			
			-- Query settings
			io.put_string ("Queries: %N")
			io.put_string ("========%N")
			-- From settings
			io.put_string ("Hitchhikers: " + settings.get_default ("hitchhikers", "Ford, Arthur") + "%N")
			io.put_string ("Paranoid: " + settings & "paranoid" + "%N")
			-- From defaults
			io.put_string ("Important item: " + settings.get ("important") + "%N")
			-- Not in property or defaults list, but default value specified in feature call
			io.put_string ("Reporter: " + settings.get_default ("reporter", "Ford") + "%N")
			
			io.put_new_line
			
			-- Create, display, store and load settings
			io.put_string ("Storage: %N")
			io.put_string ("========%N")
			create output.make (10)
			-- Put some values
			output.put ("Benjy%TFrankie", "mice")
			output.put ("Slartibartfast", "fjord designer")
			-- Display properties
			io.put_string (output.list)
			-- Store properties
			io.put_string ("%NSaving properties%N")
			output.store (output_file, "PROPERTIES example")
			-- Load properties
			io.put_string ("Loading properties%N%N")
			output.load (output_file)
			-- Display properties
			io.put_string (output.list)
		end
		
feature -- Arguments

	settings, output, defaults: PROPERTIES
			-- Properties
			
	input_file, output_file, defaults_file: PLAIN_TEXT_FILE
			-- Files for input, output and the defaults
	
end -- class PROPERTIES_EXAMPLE
