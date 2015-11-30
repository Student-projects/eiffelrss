note
	description: "External resolver for xml parser which ignores all external entities"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	RSS_RESOLVER

inherit
	XML_EXTERNAL_RESOLVER

feature -- Action(s)

	resolve (a_system: STRING)
			-- Fails.
		do

		end

feature -- Result

	has_error: BOOLEAN
			-- Always false
		do
			Result := false
		end

	last_stream: detachable XML_STRING_INPUT_STREAM
			-- Last stream initialised from external entity.
		do
			create Result.make ("")
		end

	last_error: STRING
			-- Last error message
		do
			create Result.make (0)
		end

end -- class RSS_RESOLVER
