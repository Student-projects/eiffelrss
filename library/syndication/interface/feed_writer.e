indexing
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

	make_feed (a_feed: FEED) is
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
	
	write (target, format: STRING) is
			-- Write the feed to a local file in the format `format'
	require
		valid_target: target /= Void
	local
		document: XM_DOCUMENT
		writer: WRITER_DEF
		formatter: XM_FORMATTER
		os: KL_TEXT_OUTPUT_FILE
	do
		create formatter.make
		
		create os.make (target)
		os.open_write

		if os.is_open_write then
			writer := Format_list.get_writer (format)
			if writer.get_name.is_equal ("Error") then
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
	
	None, Invalid_target, Invalid_format: INTEGER is unique

feature{NONE} -- Implementation

	feed: FEED
		-- The feed object
		

end -- class FEED_WRITER
