note
	description: "Class which manages all formats"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	FORMAT_LIST

inherit
	LINKED_LIST [FORMAT_DEF]

create
	make,
	make_list

feature -- Initialisation

	make_list
			-- Create the object and add the default formats
		do
			make
			extend (create {ERROR_FORMAT})
			extend (create {RSS_2_0_FORMAT})
		ensure
			count = 2
		end

feature -- Access

	get_reader (a_name: STRING): READER_DEF
			-- Get the reader object for the name `a_name'
		require
			valid_name: a_name /= Void
		do
			Result := get_format (a_name).get_reader
		end

	get_writer (a_name: STRING): WRITER_DEF
			-- Get the writer object for the name `a_name'
		require
			valid_name: a_name /= Void
		do
			Result := get_format (a_name).get_writer
		end

	get_format (a_name: STRING): FORMAT_DEF
			-- Get the format object for the name `a_name'
		require
			valid_name: a_name /= Void
		local
			res: detachable like get_format
		do
			from
				start
			until
				after
			loop
				if item.get_name.is_equal (a_name) then
					res := item
				end
				forth
			end
			if res = Void then
				create {ERROR_FORMAT} Result
			else
				Result := res
			end
		end

	detect_format (a_document: XML_DOCUMENT): STRING
			-- Get the format name for `a_document'
		do
			Result := "Error"
			from
				start
			until
				after
			loop
				if item.is_of_format (a_document) then
					Result := item.get_name
				end
				forth
			end
		end

end -- class FORMAT_LIST
