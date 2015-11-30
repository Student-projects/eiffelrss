indexing
	description: "Objects that represent an item in a NEWSFEED_LIST object"
	author: "Martin Luder"
	date: "$Date: 2008-03-05 17:43:27 +0100 (mer., 05 mars 2008) $"
	revision: "$Revision: 273 $"

class
	FEED_VIEW

inherit
	EV_LIST_ITEM
		redefine
			initialize,
			is_in_default_state
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
	make_with_feed

feature {NONE} -- Initialization

	make_with_feed (a_feed: FEED) is
			-- create item with a_feed
		require
			a_feed_not_void: a_feed /= void
		do
			make_app_ref
			feed := a_feed
			default_create
		end

feature {EV_ANY} -- Implementation

	initialize is
		do
			Precursor
			set_text (feed.title)
			select_actions.extend (agent on_click)
		end

	is_in_default_state: BOOLEAN is true

feature -- Events

	on_click is
			-- called when clicked on feed
			-- show feed items in detail view
		local
			mw: MAIN_WINDOW
		do
			application.logfile.log_message ("NEWSFEED_LIST: feed clicked", feature {LOGFILE}.Developer)
			application.set_current_feed (feed)

			mw ?= application.application_displayer
			if mw /= void then
				mw.show_feed
			end
		end


feature -- Access

	feed: FEED

invariant
	feed_not_void: feed /= void

end -- class FEED_VIEW
