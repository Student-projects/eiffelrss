indexing
	description: "Class that provides access to common events %Nthat have to be accessible to all windowed classes"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	WINDOWED_EVENTS

inherit
	COMMON_EVENTS
		redefine
			refresh_current,
			refresh_all,
			remove_item,
			remove_feed
		end


feature {NONE} -- Events

	show_preferences is
			-- Open preferences dialog
		local
			preferences_dialog: PREFERENCES_DIALOG
			mw: MAIN_WINDOW
		do
			create preferences_dialog.make
			mw ?= application.application_displayer
			if mw /= void then preferences_dialog.show_modal_to_window (mw) end
		end
	
	exit is
			-- exit application
		local
			mw: MAIN_WINDOW
		do
			mw ?= application.application_displayer
			if mw /= void then mw.request_close_window end
		end

	show_about is
			-- open about dialog
		local
			about_dialog: ABOUT_DIALOG
			mw: MAIN_WINDOW
		do
			create about_dialog
			mw ?= application.application_displayer
			if mw /= void then about_dialog.show_modal_to_window (mw) end
		end

	on_add is
			-- open add dialog
		local
			add_dialog: ADD_DIALOG
			mw: MAIN_WINDOW
		do
			create add_dialog.make
			mw ?= application.application_displayer
			if mw /= void then add_dialog.show_modal_to_window (mw) end
		end

	on_info is
			-- open edit dialog for currently selected item/feed
		local
			mw: MAIN_WINDOW
		do
			mw ?= application.application_displayer
			if mw /= void then 
				if mw.has_feed_focus then
					show_feed_info
				elseif mw.has_item_focus then
					show_item_info
				end
			end
		end
	
	show_feed_info is
			-- open edit dialog for current feed
		local
			edit_dialog: FEED_INFO_DIALOG
			mw: MAIN_WINDOW
		do
			if application.feed_manager.count > 0 then
				create edit_dialog.make
				mw ?= application.application_displayer
				if mw /= void then edit_dialog.show_modal_to_window (mw) end
			end
		end
		
	
	show_item_info is
			-- open edit dialog fro current item
		local
			edit_dialog: ITEM_INFO_DIALOG
			mw: MAIN_WINDOW
		do
			if application.current_feed /= void and then application.current_feed.items.count > 0 then
				create edit_dialog.make
				mw ?= application.application_displayer
				if mw /= void then edit_dialog.show_modal_to_window (mw) end
			end
		end

	refresh_current is
			-- refresh current feed
		local
			mw: MAIN_WINDOW
		do
			Precursor
			mw ?= application.application_displayer
			if mw /= void then
				mw.show_feed
			end
		end

	refresh_all is
			-- refresh all feeds
		local
			mw: MAIN_WINDOW
		do
			Precursor
			mw ?= application.application_displayer
			if mw /= void then
				mw.show_feed
			end
		end
	
	remove_feed is
			-- remove current feed
		local
			mw: MAIN_WINDOW
		do
			Precursor
			mw ?= application.application_displayer
			if mw /= void then
				mw.show_feed
				mw.show_feed_list
				mw.show_feed
			end
		end
	
	remove_item (an_item: ITEM) is
			-- remove an_item from current feed
		local
			mw: MAIN_WINDOW
		do
			Precursor (an_item)
			mw ?= application.application_displayer
			if mw /= void then
				mw.show_feed
			end
		end

	on_remove is
			-- remove current feed/item
		local
			mw: MAIN_WINDOW
		do
			mw ?= application.application_displayer
			if mw /= void and application.current_feed /= void then 
				if mw.has_feed_focus then
					remove_feed
				elseif mw.has_item_focus then
					remove_item (mw.selected_item)
				end
			end
		end

	show_feed is
			-- show current feed
		local
			mw: MAIN_WINDOW
		do
			mw ?= application.application_displayer
			if mw /= void then
				mw.show_feed
			end
		end

end -- class WINDOWED_EVENTS
