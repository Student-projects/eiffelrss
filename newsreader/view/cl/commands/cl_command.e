indexing
	description: "Objects that hande commands"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

deferred class
	CL_COMMAND

inherit
	
	CL_EVENTS
	
feature -- Initialization

	make (args: LIST[STRING]) is
			-- 
		require
			args_not_void: args /= void
		do
			make_app_ref
		end

end -- class CL_COMMAND
