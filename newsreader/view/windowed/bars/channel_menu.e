indexing
	description: "'Channel' menu"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 19:23:17 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 263 $"

class 
	CHANNEL_MENU

inherit
	EV_MENU

	WINDOWED_INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create,
			copy,
			is_equal
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

feature -- Initialization

	make is
		local
			menu_item: EV_MENU_ITEM
		do		
			make_app_ref

				-- set menu text
			make_with_text (menu_channel_item)
			
				-- create menu items
			create menu_item.make_with_text (menu_channel_add_item)
			menu_item.select_actions.extend (agent on_add)
			extend (menu_item)
			create menu_item.make_with_text (menu_channel_refresh_item)
			menu_item.select_actions.extend (agent refresh_current)
			extend (menu_item)
			create menu_item.make_with_text (menu_channel_feed_info_item)
			menu_item.select_actions.extend (agent show_feed_info)
			extend (menu_item)
			create menu_item.make_with_text (menu_channel_item_info_item)
			menu_item.select_actions.extend (agent show_item_info)
			extend (menu_item)
			create menu_item.make_with_text (menu_channel_feed_remove_item)
			menu_item.select_actions.extend (agent remove_feed)
			extend (menu_item)
			create menu_item.make_with_text (menu_channel_item_remove_item)
			menu_item.select_actions.extend (agent remove_selected_feed_item)
			extend (menu_item)
			create menu_item.make_with_text (menu_channel_refresh_all_item)
			menu_item.select_actions.extend (agent refresh_all)
			extend (menu_item)
		end

feature {NONE} -- Implementation

	remove_selected_feed_item is
			-- remove selected feed item
		local
			mw: MAIN_WINDOW
		do
			mw ?= application.application_displayer
			if mw /= void then
				mw.on_item_remove
			end			
		end
		
	
end -- class CHANNEL_MENU
