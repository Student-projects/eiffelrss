indexing
	description: "Writer object for error format"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	ERROR_WRITER
	
inherit
	WRITER_DEF

feature -- Access
	get_name: STRING is
			-- Return the format
	once
		Result := "Error"
	end
	
	write (a_feed: FEED): XM_DOCUMENT is
			-- Export `a_feed' into an xml document
	do
	
	end

end -- class ERROR_WRITER
