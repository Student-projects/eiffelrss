indexing
	description: "Container with the list of feeds and the list of current feed's items"
	author: "Martin Luder"
	date: "$Date: 2008-03-05 17:43:27 +0100 (mer., 05 mars 2008) $"
	revision: "$Revision: 273 $"

class
	NEWS_VIEW

inherit
	EV_HORIZONTAL_SPLIT_AREA
		redefine
			initialize
		end
	WINDOWED_INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	APP_REF
		undefine
			default_create,
			copy,
			is_equal
		end

	WINDOWED_EVENTS
		undefine
			default_create,
			copy,
			is_equal
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
			make_app_ref
			default_create
		end

feature {EV_ANY} -- Implementation

	initialize is
		do
			Precursor
			set_minimum_width (500)
			create feed_detail_view.make
			create newsfeed_list.make
			set_first (newsfeed_list)
			set_second (feed_detail_view)
		end

feature --  Basic Operations

	display_list is
			-- display list of feeds
		do
			newsfeed_list.display_list
		end

	display_feed is
			-- set feed to be shown in detail view
		do
			if not application.feed_manager.is_empty then
				if application.current_feed /= void then
					feed_detail_view.display_feed (application.current_feed)
				end
			else
				feed_detail_view.wipe_out_list
			end
		end

feature -- Access

	selected_item: ITEM is
			-- selected feed item in feed_detail_view
		do
			Result := feed_detail_view.selected_item
		end

	has_item_focus: BOOLEAN is
			-- has item list focus?
		do
			Result := feed_detail_view.has_list_focus
		end

	has_feed_focus: BOOLEAN is
			-- has feed list focus?
		do
			Result := newsfeed_list.has_list_focus
		end



feature {NONE} -- Implementation

	newsfeed_list: NEWSFEED_LIST

	feed_detail_view: FEED_DETAIL_VIEW

end -- class NEWS_VIEW
