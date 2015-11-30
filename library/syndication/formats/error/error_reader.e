indexing
	description: "Reader object for error format"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	ERROR_READER

inherit
	READER_DEF
	
create
	make
	
feature -- Initialisation
	make is
			-- Create object
	do
		create errors.make
	end
		
	
feature -- Access

	get_name: STRING is
			-- Return the format
	once
		Result := "Error"
	end
	
	read (a_document: XM_DOCUMENT): FEED is
			-- Create a feed with error message
	do
		create Result.make ("Error", create {HTTP_URL}.make (" "), "An error occured")
		
		from
			errors.start
		until
			errors.after
		loop
			Result.new_item (errors.item, create {HTTP_URL}.make ("http://"), errors.item)
			
			errors.forth
		end
	end
	
	has_errors: BOOLEAN is
			-- Has an error occured?
	do
		Result := not errors.is_empty
	end
		

feature -- Basic operations

	add_error (a_error: STRING) is
			-- Add `a_error' to the error messages
	require
		valid_error: a_error /= Void
	do
		errors.extend (a_error)
	ensure
		errors.count = old errors.count + 1
	end
		
feature{NONE} -- Implementation

	errors: LINKED_LIST [STRING]

end -- class ERROR_READER
