note
	description: "Implementation of the RSS 2.0 format"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	RSS_2_0_FORMAT

inherit

	FORMAT_DEF

feature -- Access

	get_reader: READER_DEF
		do
			create {RSS_2_0_READER} Result
		end

	get_writer: WRITER_DEF
		do
			create {RSS_2_0_WRITER} Result
		end

	get_name: STRING
		do
			Result := "RSS 2.0"
		end

	is_of_format (a_document: XML_DOCUMENT): BOOLEAN
			-- Is this document an RSS 2.0 feed?
		do
			if a_document.root_element.name.is_equal ("rss") then
				if
					attached a_document.root_element.attribute_by_name ("version") as l_version and then
					l_version.value.is_equal ("2.0")
				then
					Result := true
				end
			end
		end

end -- class RSS_2_0_FORMAT
