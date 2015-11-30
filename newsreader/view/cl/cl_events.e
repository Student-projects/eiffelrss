indexing
	description: "Class that provides access to common events %Nthat have to be accessible to all command line classes"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

deferred class
	CL_EVENTS

inherit
	COMMON_EVENTS
		rename
			show_preferences as on_preferences_command,
			show_about as on_about_command,
			exit as on_exit_command
		end
	
	CL_INTERFACE_NAMES
	
feature -- Events / new

	on_exit_command is
			-- called when exit requested
		do
			is_exit_requested := true
		end
	
	on_help_command is
			-- called when help is requested
		local
			disp: INFORMATION_DISPLAYER
		do
			disp := application.application_displayer.information_displayer
			io.put_new_line
			disp.show_temporary_text ("list%T%T" + Help_list_command)
			disp.show_temporary_text ("show #%T%T" + Help_show_command)
			disp.show_temporary_text ("info #%T%T" + Help_info_command)
--			disp.show_temporary_text ("edit #%T%T" + Help_edit_command)
			disp.show_temporary_text ("add URL%T%T" + Help_add_command)
			disp.show_temporary_text ("remove #%T" + Help_remove_command)
			disp.show_temporary_text ("refresh all|#%T" + Help_refresh_command)
			disp.show_temporary_text ("about%T%T" + Help_about_command)
			disp.show_temporary_text ("exit%T%T" + Help_exit_command)
			io.put_new_line
		end
		

feature -- Events / redefined
	
	on_preferences_command is
		do
			
		end
	
	on_about_command is
			-- show information about this application
		do
			io.put_new_line
			application.application_displayer.information_displayer.show_temporary_text (Application_name + " v" + Application_version_number + "%N" + Application_about)
		end

feature -- Status report

	is_exit_requested: BOOLEAN
end -- class CL_EVENTS
