note
	description: "Class which represents a log file"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	LOGFILE

inherit
	PLAIN_TEXT_FILE

create
	make_filename_threshold, make_filename

feature -- Initialization
	make_filename_threshold (a_filename: STRING; a_threshold: INTEGER)
			-- Create logfile object with a_filename as file name and a_threshold as output threshold
		require else
			valid_threshold: a_threshold >= 0
			valid_filename: a_filename /= Void
			filename_not_empty: not a_filename.is_empty
		do
			make_open_read_append (a_filename)
			set_threshold (a_threshold)
		ensure then
			threshold_set: output_threshold = a_threshold
			file_is_open: is_open_append
		end

	make_filename (a_filename: STRING)
			-- Create logfile object with a_filename as file name
		require else
			valid_filename: a_filename /= Void
			filename_not_empty: not a_filename.is_empty
		do
			make_open_read_append (a_filename)
		ensure then
			file_is_open: is_open_append
		end
		
feature -- Basic operations
		
	log_message (a_message: STRING; a_priority: INTEGER)
			-- Log the message to the logfile if a_priority is equal or greater than the threshold
		require
			valid_priority: a_priority >= 0
		local
			time_now: DATE_TIME				
			timestamp: STRING
			lines: LIST [STRING]
			i: INTEGER
		do
			if (a_priority >= output_threshold) then	
				create time_now.make_now				
				timestamp := "[" + time_now.formatted_out ("[0]hh:[0]mi:[0]ss [0]dd mmm yyyy") + "]: "
				
				lines := a_message.split ('%N')	
				
				from
					i := 1
				until
					i > lines.count
				loop
					if (i = 1) then
						put_string (timestamp)
					else
						put_string ("                        ")
					end
					
					put_string ( lines.i_th(i) )
					
					if (i = lines.count) then
						put_string ( " (" )
						put_integer( a_priority )
						put_string ( ")" )
					end
					put_new_line
					
					i := i + 1
				end
			
				flush ()
				messages_logged := messages_logged + 1
			end
		ensure
			(a_priority <= output_threshold) implies (messages_logged = old messages_logged + 1)
		end
	
	set_threshold (a_threshold: INTEGER)
			-- Set the output threshold to a_threshold
		require
			valid_threshold: a_threshold >= 0
		do
			output_threshold := a_threshold
		ensure
			threshold_set: output_threshold = a_threshold
		end
		
feature -- Access
	output_threshold: INTEGER
		-- The current threshold used
	messages_logged: INTEGER
		-- The number of messages which got logged
		
	Developer, Info, Notice, Warning, Error, Critical, Alert, Emerge: INTEGER = unique
		-- Predefined prioritys

invariant
	file_is_open: is_open_append
	valid_threshold: output_threshold >= 0
	
end -- class LOGFILE
