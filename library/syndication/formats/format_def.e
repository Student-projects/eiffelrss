note
	description: "Base class for format objects"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

deferred class
	FORMAT_DEF

feature {FORMAT_LIST} -- Access

	get_reader: READER_DEF
			-- Return a reader object
		deferred
		ensure
			valid_result: Result /= Void
		end

	get_writer: WRITER_DEF
			-- Return a writer object
		deferred
		ensure
			valid_result: Result /= Void
		end

	get_name: STRING
			-- Return the format name
		deferred
		ensure
			valid_result: Result /= Void
		end

	is_of_format (a_document: XML_DOCUMENT): BOOLEAN
			-- Is this document a feed of our type?
		deferred
		end

end -- class FORMAT_DEF
