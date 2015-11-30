indexing
	description: "Objects that handle the 'remove' command"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	CL_REMOVE_COMMAND

inherit
	CL_COMMAND
		redefine
			make
		end

create
	make

feature -- Initialization

	make (args: LIST [STRING]) is
			-- remove feed (no. in first argument)
		do
			Precursor (args)
			
		end
		
end -- class CL_REMOVE_COMMAND
