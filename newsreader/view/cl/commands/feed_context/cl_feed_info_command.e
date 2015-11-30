indexing
	description: "Objects that handle the 'info' command in feed context"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	CL_FEED_INFO_COMMAND

inherit
	CL_COMMAND
		redefine
			make
		end

create
	make

feature -- Initialization

	make (args: LIST [STRING]) is
			-- 
		local
			feed_item: ITEM
			disp: INFORMATION_DISPLAYER
		do
			Precursor (args)
			args.start
			if args.count > 0 and then application.current_feed.items.valid_index (args.item.to_integer) then
				feed_item := application.current_feed.items.i_th (args.item.to_integer)
				disp := application.application_displayer.information_displayer
				
				io.put_new_line
				disp.show_temporary_text (Info_item_title_item + ": " + feed_item.title)
				if feed_item.description.count > 50 then
					io.put_new_line
					disp.show_temporary_text (Info_item_description_item + ": ")
					disp.show_temporary_text (feed_item.description)
					io.put_new_line
				else
					disp.show_temporary_text (Info_item_description_item + ": " + feed_item.description)
				end
				disp.show_temporary_text (Info_item_link_item + ": " + feed_item.link.location)
				if feed_item.pub_date /= void then
					disp.show_temporary_text (Info_item_pub_date_item + ": " + feed_item.pub_date.formatted_out (application.properties.get ("Date_format")))
				end
				if feed_item.author /= void then
					disp.show_temporary_text (Info_item_author_item + ": " + feed_item.author)
				end
				io.put_new_line
			else 
				application.application_displayer.information_displayer.show_temporary_text (Argument_error_item)
			end
			
		end
		
end -- class CL_FEED_INFO_COMMAND
