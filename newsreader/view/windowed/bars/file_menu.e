indexing
	description: "'File' menu"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class 
	FILE_MENU

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
			
				-- set text of menu
			make_with_text (Menu_file_item)
			
				-- create menu items
			create menu_item.make_with_text (Menu_file_exit_item)
			menu_item.select_actions.extend (agent exit)
			
			extend (menu_item)
		end

end -- class FILE_MENU
