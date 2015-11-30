note
	description: "Base class for writer objects"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 11:00:52 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 255 $"

deferred class
	WRITER_DEF

feature -- Access

	is_error_writer: BOOLEAN
		do
			Result := name.same_string ("Error")
		end

	name: STRING
			-- Return a string with the format name
		deferred
		end

	write (a_feed: FEED): XML_DOCUMENT
			-- Export `a_feed' into an xml document
		require
			not_error: not is_error_writer
			valid_feed: a_feed /= Void
		deferred
		ensure
			valid_result: Result /= Void
		end

	add_to_element (a_element: XML_ELEMENT; a_name: STRING; a_value: detachable STRING; a_namespace: XML_NAMESPACE)
			-- Add a new element `a_element' with `a_name' and `a_value' if `a_value' is not Void
		local
			ele: XML_ELEMENT
			chardata: XML_CHARACTER_DATA
		do
			if a_value /= Void then
				create ele.make (a_element, a_name, a_namespace)
				create chardata.make (ele, a_value)
				ele.put_last (chardata)
				a_element.put_last (ele)
			end
		end

end -- class WRITER_DEF
