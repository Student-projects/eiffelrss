note
	description: "Writer object for error format"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	ERROR_WRITER

inherit

	WRITER_DEF

feature -- Access

	name: STRING
			-- Return the format
		once
			Result := "Error"
		end

	write (a_feed: FEED): XML_DOCUMENT
			-- Export `a_feed' into an xml document
		do
			create Result.make
		ensure then
			False
		end

end -- class ERROR_WRITER
