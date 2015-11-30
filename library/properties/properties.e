indexing
	description: "Class to represent a persistent set of properties."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	PROPERTIES
	
inherit
	HASH_TABLE [STRING, STRING]
	redefine
		make
	end
	
create
	make, make_defaults
	
feature -- Initialization

	make (n: INTEGER) is
			-- Create an empty property table of initial size `n'
		do
			Precursor (n)
			defaults := Void
			compare_objects
		end
		
	make_defaults (n: INTEGER; def: PROPERTIES) is
			-- Create a property table with `d' as default values and initial size `n'
		require
			defaults_not_void: def /= Void
		do
			make (n)
			defaults := def
		end
		
feature -- Access

	get, infix "&" (key: STRING): STRING is
			-- Item associated with `key', if present
			-- otherwise default value from `defaults'
		require else
			key_not_void: key /= Void
		do
			Result := item (key)
			
			-- If there is no entry with key `key' in the properties list, and `defaults'
			-- is defined, lookup `default' for key `key'
			if Result = Void and defaults /= Void then
				Result := defaults.get (key)
			end
		ensure
			default_value_if_not_present:
				defaults /= Void and then (not (has (key))) implies (Result = defaults.get (key))
		end

	get_default (key: STRING; def: STRING): STRING is
			-- Item associated with `key', if present
			-- otherwise default value `default'
		require
			key_not_void: key /= Void
			default_not_void: def /= Void
		do
			Result := get (key)
			
			-- If there is no entry with key `key' in the properties list, return
			-- `default'
			if Result = Void then
				Result := def
			end
		ensure then
			default_value_if_not_present:
				(get (key) = Void) implies (Result = def)
		end
		
feature -- Persistence

	load (input: FILE) is
			-- Reads a property list from  the file `input'
		require
			input_not_void: input /= Void
			input_file_is_readable: input.is_readable
		do
			parse (input)
		end

	store (output: FILE; comments: STRING) is
			-- Writes the property list to the file `output' and prepends `comment' and
			-- the actual date as comments
		require
			output_not_void: output /= Void
			output_file_is_writable: output.is_writable
		local
			now: DATE_TIME
			key, value: STRING
			old_iteration_position: INTEGER
		do
			if comments /= Void then
				writeln (output, "#" + comments)
			end
			create now.make_now
			writeln (output, "#" + now.out)

			old_iteration_position := iteration_position
			
			from
				start
			until
				after
			loop
				key := key_for_iteration
				value := item_for_iteration
				
				key := store_convert (key, True)
				
				-- No need to escape embedded and trailing spaces for values
				value := store_convert (value, False)
				
				writeln (output, key + "=" + value)
				forth
			end

			iteration_position := old_iteration_position

			output.flush
		end
		
feature -- Debug

	list: STRING is
			-- Returns a string representation of the property list.
		local
			key, value: STRING
			old_iteration_position: INTEGER
		do
			Result := "Listing properties:%N"
			Result := Result + "-------------------%N"
			
			old_iteration_position := iteration_position
			
			from
				start
			until
				after
			loop
				key := key_for_iteration
				value := item_for_iteration
				
				-- Crop long values
				if value.count > 40 then
					value := value.substring (1, 37) + "..."
				end
				
				Result := Result + key + "=" + value + "%N"
				forth
			end
			
			iteration_position := old_iteration_position
			
		end

feature {PROPERTIES} -- Arguments

	defaults: PROPERTIES
			-- Contains the default values for any keys not found in this property list

feature {NONE} -- Implementation

	writeln (output: FILE; s: STRING) is
			-- Convenience feature used to store a property list
		require
			output_not_void: output /= Void
			s_not_void: s /= Void
		do
			output.put_string (s)
			output.put_new_line
		end
		
	load_convert (s: STRING): STRING is
			-- Changes special saved characters to their original form
		require
			string_not_void: s /= Void
		local
			i: INTEGER
			char: CHARACTER
		do
			from
				i := 1
				create Result.make_empty
			until
				i > s.count
			loop
				char := s.item (i)
				if char = '\' then
					i := i + 1
					char := s.item (i)
					inspect
						char
					when 'T' then
						Result.append_character ('%T')
					when 'R' then
						Result.append_character ('%R')
					when 'N' then
						Result.append_character ('%N')
					when 'F' then
						Result.append_character ('%F')
					when ' ', '\', '=', ':', '#', '!' then
						Result.append_character (char)
					else
						Result.append_character ('\')
						Result.append_character (char)
					end
				else
					Result.append_character (char)
				end
				
				i := i + 1
			end
		end
		
	store_convert (s: STRING; escape_space: BOOLEAN): STRING is
			-- Escapes special characters with a preceding slash
		require
			string_not_void: s /= Void
		local
			i: INTEGER
			char: CHARACTER
		do
			from
				i := 1
				create Result.make_empty
			until
				i > s.count
			loop
				char := s.item (i)
				
				inspect
					char
				when ' ' then
					if i = 0 or escape_space then
						Result.append_character ('\')
					end
					Result.append_character (' ')
				when '%N' then
					Result.append ("\N")
				when '%T' then
					Result.append ("\T")
				when '%R' then
					Result.append ("\R")
				when '%F' then
					Result.append ("\F")
				when '\', '=', ':', '#', '!' then
					Result.append_character ('\')
					Result.append_character (char)
				else
					Result.append_character (char)
				end
				
				i := i + 1
			end
		end
		
	parse (input: FILE) is
			-- Parses a logical line of a stored property list into key and value
			-- and adds them to this property list
		require
			input_not_void: input /= Void
			input_file_is_readable: input.is_readable
		local
			line: LOGICAL_LINE
			key, value: STRING
		do
			from
				input.start
			until
				input.after
			loop
				input.read_line
				create line.make (input.last_string, True)
				
				if
					line.is_continuation_line
				then
					from
						-- Nothing
					until
						(not line.is_continuation_line) or
						input.after
					loop
						input.read_line
						line.append (input.last_string, True)
					end
				end
				
				-- Parse the logical line and put key and value into the property list
				if line.is_parsable then
					line.parse
					key := load_convert (line.key)
					value := load_convert (line.value)
					put (value, key)
				end
			end			
		end

end -- class PROPERTIES
