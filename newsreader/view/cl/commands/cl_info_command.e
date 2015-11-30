indexing
	description: "Objects that handle the 'info' command"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	CL_INFO_COMMAND

inherit
	CL_COMMAND
		redefine
			make
		end

create
	make

feature -- Initialization

	make (args: LIST [STRING]) is
			-- print info on feed (no. in first argument)
		local
			feed: FEED
			disp: INFORMATION_DISPLAYER
		do
			Precursor (args)
			args.start
			if args.count > 0 and then  application.current_feed.items.valid_index (args.item.to_integer) then
				feed := application.current_feed
				disp := application.application_displayer.information_displayer
				
				io.put_new_line
				disp.show_temporary_text (Info_feed_title_item + ": " + feed.title)
				disp.show_temporary_text (Info_feed_description_item + ": " + feed.description)
				if feed.description.count > 50 then
					io.put_new_line
					disp.show_temporary_text (Info_feed_description_item + ": ")
					disp.show_temporary_text (feed.description)
					io.put_new_line
				else
					disp.show_temporary_text (Info_feed_description_item + ": " + feed.description)
				end
				disp.show_temporary_text (Info_feed_link_item + ": " + feed.link.location)
				
				if feed.has_pub_date then
					disp.show_temporary_text (Info_feed_pub_date_item + ": " + feed.pub_date.formatted_out (application.properties.get ("Date_format")))
				end
				if feed.has_language then
					disp.show_temporary_text (Info_feed_language_item + ": " + feed.language)
				end
				if feed.has_copyright then
					disp.show_temporary_text (Info_feed_copyright_item + ": " + feed.copyright)
				end
				if feed.has_managing_editor  then
					disp.show_temporary_text (Info_feed_managing_editor_item + ": " + feed.managing_editor)
				end
				if feed.has_web_master  then
					disp.show_temporary_text (Info_feed_web_master_item + ": " + feed.web_master)
				end
				if feed.has_last_build_date  then
					disp.show_temporary_text (Info_feed_last_build_date_item + ": " + feed.last_build_date.formatted_out (application.properties.get ("Date_format")))
				end
				if feed.has_feed_generator  then
					disp.show_temporary_text (Info_feed_feed_generator_item + ": " + feed.feed_generator)
				end
				io.put_new_line
			else 
				application.application_displayer.information_displayer.show_temporary_text (Argument_error_item)
			end
			
		end
		
end -- class CL_INFO_COMMAND
