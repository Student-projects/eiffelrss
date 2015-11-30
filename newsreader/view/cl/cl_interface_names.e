indexing
	description: "Command line user interface strings"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

deferred class
	CL_INTERFACE_NAMES

inherit
	INTERFACE_NAMES

feature -- Parser

	Parser_unknown_command: STRING is "unknown command"
			-- String that is shown when an unknown command is entered

	Argument_error_item: STRING is "invalid argument"
			-- String that is shown when invalid arguments were entered
	
feature -- help
	
	Help_list_command: STRING is "show list of feeds"
			-- String describing command 'list'
	
	Help_show_command: STRING is "show feed no. #"
			-- String describing command 'show'
	Help_info_command: STRING is "show information on feed no. #"
			-- String describing command 'info'
	
	Help_edit_command: STRING is "edit feed no. #"
			-- String describing command 'edit'
	
	Help_add_command: STRING is "add feed with URI"
			-- String describing command 'add'
	
	Help_remove_command: STRING is "remove feed no. #"
			-- String describing command 'remove'
	
	Help_refresh_command: STRING is "refresh all feeds / feed no. #"
			-- String describing commmand 'refresh'
	
	Help_exit_command: STRING is "exit the application"
			-- String describing command 'exit'
	
	Help_about_command: STRING is "show information on this application"
			-- String describing command 'about'
	
	Help_feed_show_command: STRING is "redisplay this feed"
			-- String describing command 'show' in feed context
	
	Help_feed_open_command: STRING is "open item no. #"
			-- String describing command 'open' in feed context
	
	Help_feed_info_command: STRING is "show information on item no. #"
			-- String describing command 'info' in feed context
	
	Help_feed_edit_command: STRING is "edit item no. #"
			-- String describing command 'edit' in feed context
	
	Help_feed_remove_command: STRING is "remove item no. #"
			-- String describing command 'remove' in feed context
	
	Help_feed_refresh_command: STRING is "refresh current feed"
			-- String describing command 'refresh' in feed context
	
	Help_feed_back_command: STRING is "get back to feed list"
			-- String describing command 'back' in feed context

end -- class CL_INTERFACE_NAMES
