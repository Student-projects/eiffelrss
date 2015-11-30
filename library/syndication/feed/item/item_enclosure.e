note
	description: "Class to represent an item enclosure sub-element."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	ITEM_ENCLOSURE
	
create
	make

feature -- Initialization

	make (a_url: URL; a_length: INTEGER; a_type: STRING)
			-- Create an item enclosure
		require
			non_void_url: a_url /= Void
			positive_length: a_length >= 0
			non_empty_type: a_type /= Void and then not a_type.is_empty			
		do
			set_url (a_url)
			set_length (a_length)
			set_type (a_type)
		end

feature -- Access

	url: URL
			-- URL of the enclosure
			
	length: INTEGER
			-- Length in bytes of the enclosure
			
	type: STRING
			-- MIME type of the enclosure

feature -- Setter

	set_url (a_url: URL)
			-- Set the URL to `url'
		require
			non_void_url: a_url /= Void
		do
			url := a_url
		ensure
			url_set: url = a_url
		end
		
	set_length (a_length: INTEGER)
			-- Set the length to `a_length'
		require
			positive_length: a_length >= 0
		do
			length := a_length
		ensure
			length_set: length = a_length
		end
		
	set_type (a_type: STRING)
			-- Set the MIME type to `a_type'
		require
			non_empty_type: a_type /= Void and then not a_type.is_empty
		do
			type := a_type
		ensure
			type_set: type = a_type
		end
		
feature -- Debug

	to_string: STRING
			-- Returns a string representation of enclosure
			-- This feature is especially useful for debugging
		do
			Result := "* URL: " + url.location + "%N* Length: " + length.out + "%N* Type: " + type + "%N"
		end

invariant
	non_void_url: url /= Void
	positive_length: length >= 0
	non_empty_type: type /= Void and then not type.is_empty

end -- class ITEM_ENCLOSURE
