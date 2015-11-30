indexing
	description: "Objects that give output to the command line"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	CL_OUTPUT

inherit
	INFORMATION_DISPLAYER

create
	make,
	make_with_text

feature -- Basic operations
	
	show_current is
			-- print current text message to command line
		do
			io.put_string (current_text + "%N")
		end

feature -- Progress display

	show_progress (s: INTEGER) is
			-- show progress and set number of steps to s
		do
			
		end
	
	progress_forward is
			-- increase progress
		do
			
		end
	
	progress_backward is
			-- decrease progress
		do
			
		end
	
	progress_done is
			-- finish progress
		do
			
		end
		

end -- class CL_OUTPUT
