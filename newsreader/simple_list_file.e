indexing
	description: "List that can write it's items into a file (each item one line) and read them back"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	SIMPLE_LIST_FILE

inherit
	LINKED_LIST[STRING]

create
	make

feature -- Persistence

	load (input: FILE) is
			-- Reads a property list from  the file `input'
		require
			input_not_void: input /= Void
			input_file_is_readable: input.is_readable
		do
			parse (input)
		end

	store (output: FILE) is
			-- Writes the property list to the file `output' and prepends `comment' and
			-- the actual date as comments
		require
			output_not_void: output /= Void
			output_file_is_writable: output.is_writable
		local
			string: STRING
		do
			from
				start
			until
				after
			loop
				string := store_convert (item, True)
				
				writeln (output, string)
				forth
			end

			output.flush
		end
		
feature -- Debug

	list: STRING is
			-- Returns a string representation of the list.
		do
			Result := "Listing list:%N"
			Result := Result + "-------------------%N"
			
			
			from
				start
			until
				after
			loop				
				Result := Result + item + "%N"
				forth
			end
		end

feature {NONE} -- Implementation

	writeln (output: FILE; s: STRING) is
			-- Convenience feature used to store a list
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
			-- Parses a logical line of a stored list
			-- and adds them to this list
		require
			input_not_void: input /= Void
			input_file_is_readable: input.is_readable
		local
			line: STRING
		do
			from
				input.start
			until
				input.after
			loop
				input.read_line
				line := load_convert (input.last_string)

					-- Remove leading whitespace

				line.prune_all_leading (' ')
				line.prune_all_leading ('%T')
				line.prune_all_leading ('%F')
			
					-- Remove trailing whitespace
				line.prune_all_trailing (' ')
				line.prune_all_trailing ('%T')
				line.prune_all_trailing ('%F')
				line.prune_all_trailing ('%N')
				line.prune_all_trailing ('%R')

				if not line.is_empty then
					extend (line)
				end
			end			
		end

end -- class SIMPLE_LIST_FILE
