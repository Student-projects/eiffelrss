indexing
	description: "Object that output Information to the user"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

deferred class
	INFORMATION_DISPLAYER

inherit
	APP_REF
	
feature -- Initialization
	
	make is
			-- creation procedure
		do
			make_app_ref
			create initial_text.make_empty
			create text.make_empty
			create temporary_text.make_empty			
		end
		
	
	make_with_text (a_text: STRING) is
			-- create with initial text message
		require
			a_text_not_void: a_text /= void
		do
			make
			show_initial_text (a_text)
		end
		
	
feature -- Text display

	show_initial_text (a_text: STRING) is
			-- set initial text message
		require
			a_text_not_void: a_text /= void
		do
			initial_text.copy (a_text)
			current_text := initial_text
			show_current
		end
	
	show_text (a_text: STRING) is
			-- set text message
		require
			a_text_not_void: a_text /= void
		do
			text.copy (a_text)
			current_text := text
			show_current
		end
	
	show_temporary_text (a_text: STRING) is
			-- set temporary text message
		require
			a_text_not_void: a_text /= void
		do
			temporary_text.copy (a_text)
			current_text := temporary_text
			show_current
		end
	
	revert is
			-- revert temporary state to standard state
		do
			current_text := text
			show_current
		end

feature -- Progress display

	show_progress (s: INTEGER) is
			-- show progress and set number of steps to s
		require
			s_positive: s > 0
		deferred end
	
	progress_forward is
			-- increase progress
		deferred end
	
	progress_backward is
			-- decrease progress
		deferred end
	
	progress_done is
			-- progess is done
		deferred end
		


feature {NONE} -- Implementation

	initial_text: STRING
	text: STRING
	temporary_text: STRING
	current_text: STRING
	
	
	show_current is
			-- show current text message
		deferred
		end

invariant
	initial_text_not_void: initial_text /= void
	text_not_void: text /= void
	temporary_text_not_void: temporary_text /= void

end -- class INFORMATION_AREA
