indexing
	description: "Objects that show feed items in an EV_MULTI_COLUMN_LIST"
	author: "Martin Luder"
	date: "$Date: 2008-03-05 17:43:27 +0100 (mer., 05 mars 2008) $"
	revision: "$Revision: 273 $"

class
	FEED_DETAIL_VIEW

inherit
	INFORMATION_PANEL
		redefine
			make
		end
create
	make

feature {NONE} -- Initialisation

	make is
			-- creation procedure
		do
			Precursor {INFORMATION_PANEL}

			create feed_url
			feed_url.align_text_left
			feed_url.set_font (create {EV_FONT}.make_with_values (feature {EV_FONT_CONSTANTS}.Family_screen, feature {EV_FONT_CONSTANTS}.Weight_regular, feature {EV_FONT_CONSTANTS}.Shape_italic, 11))
			feed_url.pointer_button_press_actions.extend (agent on_feed_url_click)
			label_left_box.extend (feed_url)
			label_left_box.disable_item_expand (feed_url)
			create feed_description
			feed_description.align_text_left
			label_left_box.extend (feed_description)
			label_left_box.disable_item_expand (feed_description)

			create list

			extend (list)
			list.set_column_titles (<<Feed_detail_view_title_column,Feed_detail_view_description_column,Feed_detail_view_date_column >>)

			set_minimum_height (200)
			list.set_minimum_width (350)
			list.set_column_widths (<<150,10,100>>)

			list.enable_multiple_selection
			list.resize_actions.extend (agent on_resize)

			list.column_title_click_actions.extend (agent on_column_title_click)

			title_sort := no_sort
			pub_date_sort := no_sort
		end

feature -- Basic operations

	display_feed (f: FEED) is
			-- display feed in widget
		require
			f_not_void: f /= void
		local
			desc_string: STRING
		do
			feed := f

			set_label_text (feed.title)
			application.logfile.log_message ("showing items of feed '" + feed.title + "'", feature{LOGFILE}.Developer)

			feed_url.set_text (feed.link.location)

			desc_string := feed.description
			if feed.description.count > 100 then
				desc_string := feed.description.substring (1, 100) + "..."
			end
			feed_description.set_text (desc_string)
			feed_description.set_tooltip (feed.description)

			list.wipe_out
			from
				feed.items.start
			until
				feed.items.after
			loop
				list.extend (create {FEED_ITEM_VIEW}.make_with_item (feed.items.item))
				feed.items.forth
			end
		end

	wipe_out_list is
			-- empty list
		do
			feed := void

			set_label_text ("")
			feed_url.set_text ("")
			feed_description.set_text ("")
			feed_description.set_tooltip ("")
			list.wipe_out
		end


	selected_item: ITEM is
			-- selected item in list
		local
			item_view: FEED_ITEM_VIEW
			item_row: EV_MULTI_COLUMN_LIST_ROW
		do
			item_view ?= list.selected_item
			item_row := list.selected_item
			if item_view /= void then
				Result := item_view.feed_item
			else
				item_view ?= list.first
				if item_view /= void then
					Result := item_view.feed_item
				end
			end
		ensure
			result_void_implies_empty_list: (Result = void) implies list.is_empty
			result_not_void: Result /= void
		end

feature -- Access

	has_list_focus: BOOLEAN is
			-- has list focus?
		do
			Result := list.has_focus
		end

feature -- Events

	on_column_title_click (c: INTEGER) is
			-- called when column title clicked
		require
			valid_index: c > 0 and c <= 3
		do
			inspect
				c
			when 1 then
				application.logfile.log_message ("FEED_DETAIL_VIEW: sorting after names", feature {LOGFILE}.developer)
				if title_sort /= asc_sort then
					feed.sort_items_by_title
					title_sort := asc_sort
				else
					feed.reverse_sort_items_by_title
					title_sort := desc_sort
				end
			when 3 then
				application.logfile.log_message ("FEED_DETAIL_VIEW: sorting after date", feature {LOGFILE}.developer)
				if pub_date_sort /= asc_sort then
					feed.sort_items_by_pub_date
					pub_date_sort := asc_sort
				else
					feed.reverse_sort_items_by_pub_date
					pub_date_sort := desc_sort
				end
			else

			end
			list.wipe_out
			display_feed (feed)
		end

	on_feed_url_click (a,b,c: INTEGER; d,e,f: DOUBLE; g,h: INTEGER) is
			-- called when url of feed (in the top label) is clicked
		do
			open_url (application.current_feed.link, true)
		end


feature {NONE} -- Implementation

	list: EV_MULTI_COLUMN_LIST

	feed: FEED

	feed_url, feed_description: EV_LABEL

	no_sort, asc_sort, desc_sort: INTEGER is unique

	title_sort: INTEGER
	pub_date_sort: INTEGER

	on_resize (x,y,w,h: INTEGER) is
			-- called on resize of list
		local
			title_width, description_width, date_width: INTEGER
		do
			title_width := list.column_width (1)
			description_width := list.column_width (2)
			date_width := list.column_width (3)
				list.set_column_width (title_width, 1)
				list.set_column_width (date_width, 3)
			if w - title_width - date_width > 0 then
				list.set_column_width (w - title_width - date_width, 2)
			else
				list.set_column_width (0, 2)
			end
		end


end -- class FEED_DETAIL_VIEW
