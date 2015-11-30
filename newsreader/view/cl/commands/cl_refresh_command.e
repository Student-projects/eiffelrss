indexing
	description: "Objects that handle the 'refresh' command"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	CL_REFRESH_COMMAND

inherit
	CL_COMMAND
		redefine
			make
		end

create
	make

feature -- Initialization

	make (args: LIST [STRING]) is
			-- refresh all or just one feed (no. in first argument)
		do
			Precursor (args)
			if not args.is_empty then
				args.start
				if args.item.is_equal ("all") then
					refresh_all
				elseif args.item.is_integer then
					-- refresh feed no. item
				end
			end
		end
		
end -- class CL_REFRESH_COMMAND
