indexing
	description: "Base class for writer objects"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 11:00:52 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 255 $"

deferred class
	WRITER_DEF

feature -- Access

	get_name: STRING is
			-- Return a string with the format name
	deferred
	end
	
	write (a_feed: FEED): XM_DOCUMENT is
			-- Export `a_feed' into an xml document
	require
		valid_feed: a_feed /= Void
	deferred
	ensure
		valid_result: Result /= Void
	end
	
	add_to_element (a_element: XM_ELEMENT; a_name: STRING; a_value: STRING; a_namespace: XM_NAMESPACE) is
			-- Add a new element `a_element' with `a_name' and `a_value' if `a_value' is not Void
	local
		ele: XM_ELEMENT
		chardata: XM_CHARACTER_DATA
	do
		if a_value /= Void then
			create ele.make (a_element, a_name, a_namespace)
			create chardata.make (ele, a_value)
			ele.put_last (chardata)
			a_element.put_last (ele)
		end
	end
		
		

end -- class WRITER_DEF
