note
	description: "Class which loads data from an xml file or string to a feed object"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	FEED_READER

inherit

	FORMAT_LIST_FACTORY

create
	make_from_string,
	make_from_file

feature -- Initialization

	make_from_string (a_string: STRING)
			-- Create from `a_string' as source of feed
		require
			valid_string: a_string /= Void
		do
			create {XML_STRING_INPUT_STREAM} feed_source.make (a_string)
		ensure
			feed_source_set: feed_source /= Void
		end

	make_from_file (a_filename: STRING)
			-- Create from file `a_filename' as source of feed
		require
			valid_filename: a_filename /= Void
		do
			create {XML_FILE_INPUT_STREAM} feed_source.make_with_filename (a_filename)
		ensure
			feed_source_set: feed_source /= Void
		end

feature -- Operation

	read: FEED
			-- Parse the feed
		local
			xml_parser: XML_PARSER
			tree_pipe: XML_CALLBACKS_NULL_FILTER_DOCUMENT
			reader: READER_DEF
			error_handler: ERROR_READER
		do
			create tree_pipe.make_null

			create {XML_LITE_CUSTOM_PARSER} xml_parser.make
--			xml_parser.set_string_mode_mixed
--			tree_pipe.set_next (create {RSS_RESOLVER})
			xml_parser.set_callbacks (tree_pipe)
			if attached {XML_FILE_INPUT_STREAM} feed_source as src_file then
				src_file.start
				xml_parser.parse_from_stream (src_file)
				src_file.close
			elseif attached {XML_STRING_INPUT_STREAM} feed_source as src_content then
				src_content.start
				xml_parser.parse_from_stream (src_content)
				src_content.close
			else
				xml_parser.parse_from_stream (feed_source)
			end
			if attached xml_parser.last_error_description as l_err_desc then
				create error_handler.make
				error_handler.add_error (l_err_desc)
				reader := error_handler
			else
				reader := Format_list.get_reader (Format_list.detect_format (tree_pipe.document))
				if reader.is_error_reader then
					if attached {ERROR_READER} reader as err_r then
						err_r.add_error ("Unsupported feed format")
					else
						check is_error_reader: False end
					end
				end
			end
			if tree_pipe.document = Void then
				Result := reader.read (create {XML_DOCUMENT}.make)
			else
				Result := reader.read (tree_pipe.document)
			end
		end

feature {NONE} -- Implementation

	feed_source: XML_INPUT_STREAM
			-- Source of feed

end -- class FEED_READER
