note
	description: "Class to represent an item guid sub-element."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	ITEM_GUID
	
create
	make, make_perma_link
	
feature -- Initialization

	make (a_guid: STRING)
			-- Create an item guid with `is_perma_link' set to False
		require
			non_empty_guid: a_guid /= Void and then not a_guid.is_empty
		do
			set_guid (a_guid)
			set_perma_link (False)
		end
		
	make_perma_link (a_guid: STRING)
			-- Create an item guid with `is_perma_link' set to True
		require
			non_empty_guid: a_guid /= Void and then not a_guid.is_empty
		do
			set_guid (a_guid)
			set_perma_link (True)
		end
		
feature -- Access

	guid: STRING
			-- String representing a globally unique identifier (guid)
			
	is_perma_link: BOOLEAN
			-- Is this guid a perma link?

feature -- Setter

	set_guid (a_guid: STRING)
			-- Set guid to `a_guid'
		require
			non_empty_guid: a_guid /= Void and then not a_guid.is_empty
		do
			guid := a_guid
		ensure
			guid_set: guid = a_guid
		end
		
	set_perma_link (value: BOOLEAN)
			-- Set is_perma_link to `value'
		do
			is_perma_link := value
		ensure
			is_perma_link_set: is_perma_link = value
		end

feature -- Debug

	to_string: STRING
			-- Returns a string representation of guid
			-- This feature is especially useful for debugging
		do
			Result := "* GUID: " + guid + "%N* Perma link: " + is_perma_link.out + "%N"
		end

invariant
	non_empty_guid: guid /= Void and then not guid.is_empty

end -- class ITEM_GUID
