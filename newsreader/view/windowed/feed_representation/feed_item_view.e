indexing
	description: "Objects that represent a row in FEED_DETAIL_VIEW and can show a feed item"
	author: "Martin Luder"
	date: "$Date: 2008-03-05 17:43:27 +0100 (mer., 05 mars 2008) $"
	revision: "$Revision: 273 $"

class
	FEED_ITEM_VIEW

inherit
	EV_MULTI_COLUMN_LIST_ROW
		redefine
			initialize
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
	make_with_item

feature {NONE} -- Initialization

	make_with_item (an_item: ITEM) is
			-- create row with an_item
		require
			an_item_not_void: an_item /= void
		do
			make_app_ref
			feed_item := an_item
			default_create
		end

feature {EV_ANY} -- Implementation

	initialize is
		local
			date: STRING
		do
			Precursor
			if (feed_item.pub_date /= void) then
				date := feed_item.pub_date.formatted_out (application.properties.get ("Date_format"))
			else
				date := ""
			end
			fill (<<feed_item.title.as_string_32, feed_item.description.as_string_32, date.as_string_32>>)
			pointer_double_press_actions.force_extend (agent on_double_click)
		end


feature -- Events

	on_double_click is
			-- called when double clicked on item
		do
			application.logfile.log_message ("FEED_ITEM_VIEW: item double clicked, opening '" + feed_item.link.location + "'", feature {LOGFILE}.developer)
			open_url (feed_item.link, true)
		end


feature -- Access

	feed_item: ITEM


invariant
	feed_item_not_void: feed_item /= void

end -- class FEED_ITEM_VIEW
