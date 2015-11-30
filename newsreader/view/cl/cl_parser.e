indexing
	description: "Objects that parse the command line using a COMMAND_LIST to execute commands"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

deferred class
	CL_PARSER

inherit
	CL_EVENTS
	
	CL_INTERFACE_NAMES

feature -- Initialization
	make is
			-- Creation procedure.
		do
			create known_commands.make (10)
			
			known_commands.put (agent on_exit_command, "exit")
			known_commands.put (agent on_about_command, "about")
			known_commands.put (agent on_help_command, "help")
			known_commands.put (agent on_info_command, "info")
		end

feature -- Basic operations

	parse is
			-- parse command line
		do
			from
				
			until
				is_stop_requested or is_exit_requested
			loop
				io.put_string (command_string + cl)
				io.read_line

				read_line := io.last_string
				words := read_line.split (' ')
				clean_list
				if not words.is_empty then
					words.start
					entered_command := words.item
					words.remove
					if is_known_command then
						known_commands.item (entered_command).apply
					else
						application.application_displayer.information_displayer.show_temporary_text (Parser_unknown_command)
					end
				end
			end
		end

feature -- Events

	on_info_command is
			-- show information about feed
		local
			command: CL_INFO_COMMAND
		do
			create command.make (words)
		end


feature {NONE} -- Implementation

	read_line: STRING
	words: LIST[STRING]
	known_commands: COMMAND_LIST
	command_string: STRING is deferred end
	entered_command: STRING
	cl: STRING is ">> "
	is_stop_requested: BOOLEAN

	show_list is
		do
			from
				words.start
			until
				words.after
			loop
				io.put_string ("-")
				io.put_string (words.item)
				io.put_string ("-")
				io.put_new_line
				words.forth
			end
		end
	
	clean_list is
		do
			from
				words.start
			until
				words.after
			loop
				if words.item.is_empty then
					words.remove
				else
					words.forth
				end
			end
		end
		
	is_known_command: BOOLEAN is
		do
			Result := known_commands.has (entered_command)
		end
		
invariant
	known_commands_not_void: known_commands /= void
end -- class CL_PARSER
