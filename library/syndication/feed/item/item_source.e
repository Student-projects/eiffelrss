note
	description: "Class to represent an item source sub-element."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	ITEM_SOURCE
	
create
	make

feature -- Initialization

	make (a_name: STRING; a_url: URL)
			-- Create an item source
		require
			non_empty_name: a_name /= Void and then not a_name.is_empty
			non_void_url: a_url /= Void
		do
			set_name (a_name)
			set_url (a_url)
		end
		
feature -- Access

	name: STRING
			-- Name of the item source
	
	url: URL
			-- URL of the item source

feature -- Setter

	set_name (a_name: STRING)
			-- Set name to `a_name'
		require
			non_empty_name: a_name /= Void and then not a_name.is_empty
		do
			name := a_name
		ensure
			name_set: name = a_name
		end
		
	set_url (a_url: URL)
			-- Set url to `a_url'
		require
			non_void_url: a_url /= Void
		do
			url := a_url
		ensure
			url_set: url = a_url
		end
		
feature -- Debug

	to_string: STRING
			-- Returns a string representation of source
			-- This feature is especially useful for debugging
		do
			Result := "* Name: " + name + "%N* URL: " + url.location + "%N"
		end

invariant
	non_empty_name: name /= Void and then not name.is_empty
	non_void_url: url /= Void

end -- class ITEM_SOURCE
