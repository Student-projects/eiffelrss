indexing
	description: "Objects that show a list of FEEDs in an EV_LIST"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 19:23:17 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 263 $"

class
	NEWSFEED_LIST

inherit
	INFORMATION_PANEL
		redefine
			make
		end

create
	make
	
feature -- Initialisation

	make is
			-- creation procedure
		do
			Precursor
			create list

			set_label_text ("Newsfeed List")
			
			extend (list)
			set_minimum_width (150)
			set_minimum_height (200)
		end

feature -- Basic Operations

	selected_feed: FEED is
			-- selected feed in list
		do
			
		end
	
	display_list is
			-- display list of feeds
		local
			l_item: FEED_VIEW
		do
			application.logfile.log_message ("displaying list of feeds", feature{LOGFILE}.Developer)
			list.wipe_out
			from
				application.feed_manager.start
			until
				application.feed_manager.after
			loop
				create l_item.make_with_feed (application.feed_manager.item_for_iteration)
				list.extend (l_item)
				application.feed_manager.forth
			end
		end
		

feature -- Access

	has_list_focus: BOOLEAN is
			-- has list focus?
		do
			Result := list.has_focus
		end
		
	
feature {NONE} -- Implementation
	
	list: EV_LIST

end -- class NEWSFEED_LIST
