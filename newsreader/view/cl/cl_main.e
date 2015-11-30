indexing
	description: "Main command line displayer"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	CL_MAIN

inherit
	APPLICATION_DISPLAYER
		rename
			information_displayer as output
		redefine
			make
		end
	
	CL_EVENTS
		undefine
			default_create,
			copy,
			is_equal
		end
		
	CL_INTERFACE_NAMES
	
	CL_PARSER
		rename
			make as make_parser
		redefine
			make_parser
		end

create
	make

feature -- Initialization

	make is
		do
			make_app_ref
			make_parser
			
			create {CL_OUTPUT}output.make_with_text ("Welcome to " + Application_name + "%N")
		end
	
	make_parser is
		do
			Precursor {CL_PARSER}
			known_commands.put (agent on_list_command, "list")
			known_commands.put (agent on_show_command, "show")
			known_commands.put (agent on_add_command, "add")
			known_commands.put (agent on_remove_command, "remove")
			known_commands.put (agent on_refresh_command, "refresh")
			known_commands.put (agent on_help_command, "help")
		end
		
	start is
			-- start
		do
			application.load_feeds
			parse
			application.destroy
		end


feature -- Events

	on_list_command is
			-- 
		local
			command: CL_LIST_COMMAND
		do
			create command.make (words)
		end
		
	on_show_command is
			--
		local
			command: CL_SHOW_COMMAND
		do
			create command.make (words)
		end
		
	on_add_command is
			-- 
		local
			command: CL_ADD_COMMAND
		do
			create command.make (words)
		end

	on_remove_command is
			-- 
		local
			command: CL_REMOVE_COMMAND
		do
			create command.make (words)
		end
	
	on_refresh_command is
			-- 
		local
			command: CL_REFRESH_COMMAND
		do
			create command.make (words)
		end		

feature -- Status setting

	request_exit is
			-- 
		do
			is_exit_requested := true
		end


feature -- Basic Operations

	load_and_initialize_feeds is
			-- load feeds and then show list of feeds
		do
			
		end
		
		
		
feature {NONE} -- Implementation
	
	command_string: STRING is ""
	
end -- class CL_MAIN
