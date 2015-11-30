indexing
	description: "Main toolbar"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	TOOLBAR

inherit
	EV_VERTICAL_BOX

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
			-- creation procedure
		local
			toolbar_item: EV_TOOL_BAR_BUTTON
			toolbar_pixmap: EV_PIXMAP
		do
			make_app_ref
			default_create
			
			create toolbar
			
				-- create toolbar items
			create toolbar_item
			create toolbar_pixmap.make_with_size (24, 24)
			toolbar_pixmap.set_with_named_file ("graphics/stock_refresh.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.select_actions.extend (agent refresh_all)
			toolbar_item.set_tooltip (Toolbar_refresh_tooltip)
			toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap.make_with_size (24, 24)
			toolbar_pixmap.set_with_named_file ("graphics/stock_delete.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.select_actions.extend (agent on_remove)
			toolbar_item.set_tooltip (Toolbar_remove_tooltip)
			toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap.make_with_size (24, 24)
			toolbar_pixmap.set_with_named_file ("graphics/stock_edit.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.select_actions.extend (agent on_info)
			toolbar_item.set_tooltip (Toolbar_info_tooltip)
			toolbar.extend (toolbar_item)

			create toolbar_item
			create toolbar_pixmap.make_with_size (24, 24)
			toolbar_pixmap.set_with_named_file ("graphics/gnome-settings.png")
			toolbar_item.set_pixmap (toolbar_pixmap)
			toolbar_item.select_actions.extend (agent show_preferences)
			toolbar_item.set_tooltip (Toolbar_preferences_tooltip)
			toolbar.extend (toolbar_item)
			
			extend (toolbar)
			extend (create {EV_HORIZONTAL_SEPARATOR})
		ensure then
			is_not_empty: not is_empty
		end

feature {NONE} -- Implementation
	
	toolbar: EV_TOOL_BAR
	
end -- class TOOLBAR
