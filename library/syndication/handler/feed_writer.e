note
	description: "Class which writes a feed to a file"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	FEED_WRITER

inherit

	FORMAT_LIST_FACTORY

create
	make_feed

feature -- Initialisation

	make_feed (a_feed: FEED)
			-- Create a writer object for the feed `a_feed'
		require
			valid_feed: a_feed /= Void
		do
			feed := a_feed
			error := None
		ensure
			feed_set: feed = a_feed
			no_error: error = None
		end

	write (target, format: STRING)
			-- Write the feed to a local file in the format `format'
		require
			valid_target: target /= Void
		local
			document: XML_DOCUMENT
			writer: WRITER_DEF
			formatter: XML_FORMATTER
			os: XML_FILE_OUTPUT_STREAM
		do
			create formatter.make
			create os.make (create {RAW_FILE}.make_open_write (target))
			if os.is_open_write then
				writer := Format_list.get_writer (format)
				if writer.is_error_writer then
					error := Invalid_format
				else
					document := writer.write (feed)
					formatter.set_output (os)
					formatter.process_document (document)
					os.close
				end
			else
				error := Invalid_target
			end
		end

feature -- Status

	error: INTEGER

	None: INTEGER = 1
	Invalid_target: INTEGER = 2
	Invalid_format: INTEGER = 3

feature {NONE} -- Implementation

	feed: FEED
			-- The feed object

end -- class FEED_WRITER
