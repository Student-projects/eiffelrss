indexing
	description: "Main window for this application"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 19:23:17 +0100 (lun., 31 janv. 2005) $"
	revision: "1.0.0"

class 
	MAIN_WINDOW

inherit
	APPLICATION_DISPLAYER
		rename
			information_displayer as status_bar
		redefine
			make
		end
		
	EV_TITLED_WINDOW
		redefine
			initialize,
			is_in_default_state
		end
	
	WINDOWED_INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	WINDOWED_EVENTS
		undefine
			default_create,
			copy,
			is_equal
		redefine
			show_feed
		end
	
create 
	make

feature 

	make is
		do
			make_app_ref
			default_create
		end

	initialize is
		local
			sb: EV_STATUS_BAR
			icon: EV_PIXMAP
		do
			Precursor {EV_TITLED_WINDOW}
			application.logfile.log_message ("creating main window", feature{LOGFILE}.Info)
			
				-- build status bar
			create {STATUS_BAR}status_bar.make_with_text ("Welcome to " + Application_name)
			sb ?= status_bar
			if sb /= void then lower_bar.extend (sb) end
			
				-- build menus
			build_standard_menu_bar
			set_menu_bar (standard_menu_bar)
			upper_bar.extend (create {EV_HORIZONTAL_SEPARATOR})
			
				-- build tool bar
			create toolbar.make
			upper_bar.extend (toolbar)
			if application.properties.get ("Show_toolbar").is_equal ("no") then
				toolbar.hide
			end
			
			
				-- build main area
			build_main_view

				-- set window options
			close_request_actions.extend (agent request_close_window)
			set_title (application.properties.get ("Window_title"))
			set_accelerators
			resize_actions.extend (agent on_resize_or_move)
			move_actions.extend (agent on_resize_or_move)
			minimize_actions.extend (agent on_minimize)
			maximize_actions.extend (agent on_maximize)
			restore_actions.extend (agent on_restore)
			
			show_actions.extend (agent restore_maximize_minimize)
			restore_window_size_and_position
			
				-- set icon of window
			create icon
			icon.set_with_named_file ("graphics/newsreader_icon.png")
			set_icon_pixmap (icon)
		end

	is_in_default_state: BOOLEAN is
		do
			Result := true
		end
	
feature -- Window elements

		-- menus and toolbar
	toolbar: TOOLBAR
	standard_menu_bar: EV_MENU_BAR
	file_menu: FILE_MENU
	edit_menu: EDIT_MENU
	channel_menu: CHANNEL_MENU
	help_menu: HELP_MENU

	build_standard_menu_bar is
			-- create all menu objects
		require
			menu_bar_not_yet_created: standard_menu_bar = Void
		do
			create standard_menu_bar
			create file_menu.make
			standard_menu_bar.extend (file_menu)
			create edit_menu.make
			standard_menu_bar.extend (edit_menu)
			create channel_menu.make
			standard_menu_bar.extend (channel_menu)
			create help_menu.make
			standard_menu_bar.extend (help_menu)
		ensure
			menu_bar_created: standard_menu_bar /= Void and then not standard_menu_bar.is_empty
		end

	
feature -- Events

	on_debug_window is
		local
			dw: DEBUG_WINDOW
		do
			dw ?= application.logfile
			if dw /= void then
				if dw.is_show_requested then
					application.logfile.log_message ("Hiding debug window", feature{LOGFILE}.Info)
					dw.hide
				else
					application.logfile.log_message ("Showing debug window", feature{LOGFILE}.Info)
					dw.show
				end
			end
		end

	request_close_window is
			-- show confirmation dialog if Ask_on_exit is 'yes', else close window and application
		local
			question_dialog: EV_CONFIRMATION_DIALOG
		do			
			application.logfile.log_message ("Exit requested", feature{LOGFILE}.Info)
			if application.properties.get ("Ask_on_exit").is_equal ("yes") then
				create question_dialog.make_with_text (label_confirm_close_window)
				question_dialog.show_modal_to_window (Current)
				if question_dialog.selected_button.is_equal ((create {EV_DIALOG_CONSTANTS}).ev_ok) then
					application.logfile.log_message ("saving preferences", feature{LOGFILE}.Info)
					application.save_properties
					application.logfile.log_message ("saving feed uris", feature{LOGFILE}.Info)
					application.save_feed_urls
					application.logfile.log_message ("destroying window...", feature{LOGFILE}.Info)
					destroy
					application.logfile.log_message ("destroying application", feature{LOGFILE}.Info)
					application.destroy
				end
			elseif application.properties.get ("Ask_on_exit").is_equal ("no") then
				application.logfile.log_message ("saving preferences", feature{LOGFILE}.Info)
				application.save_properties
				application.logfile.log_message ("saving feed uris", feature{LOGFILE}.Info)
				application.save_feed_urls
				application.logfile.log_message ("destroying window...", feature{LOGFILE}.Info)
				destroy
				application.logfile.log_message ("destroying application", feature{LOGFILE}.Info)
				application.destroy
			end
		end
	
	on_resize_or_move (x,y, w, h: INTEGER)  is
			-- called when window was resized
		do
			application.properties.force (x.out, "Window_x_position")
			application.properties.force (y.out, "Window_y_position")
			application.properties.force (w.out, "Window_width")
			application.properties.force (h.out, "Window_height")
		end
	
	on_minimize is
			-- called when window was minimized
		require
			minimized: is_minimized
		do
			application.logfile.log_message ("minimizing main window", feature{LOGFILE}.Developer)
			application.properties.force ("yes", "Window_minimized")
			application.properties.force ("no", "Window_maximized")
		end
	
	on_maximize is
			-- called when window was maximized
		require
			maximized: is_maximized
		do
			application.logfile.log_message ("maximizing main window", feature{LOGFILE}.Developer)
			application.properties.force ("yes", "Window_maximized")
			application.properties.force ("no", "Window_minimized")
		end
		
	on_restore is
			-- called when window was restored
		require
			not_minimized_or_maximized: not is_minimized and not is_maximized
		do
			application.logfile.log_message ("restoring size of main window", feature{LOGFILE}.Developer)
			application.properties.force ("no", "Window_minimized")
			application.properties.force ("no", "Window_maximized")
		end
	
	on_item_remove is
			-- remove selected item
		do
			remove_item (selected_item)
		end
		

feature -- Access
		
	selected_item: ITEM is
			-- selected feed item in news_view
		do
			Result := news_view.selected_item
		end
	
	has_feed_focus: BOOLEAN is
			-- has feed list focus?
		do
			Result := news_view.has_feed_focus
		end
		
	
	has_item_focus: BOOLEAN is
			-- has item list focus?
		do
			Result := news_view.has_item_focus
		end


feature -- Basic Operations

	show_feed_list is
			-- show list of feeds
		do
			news_view.display_list			
		end
		
	
	show_feed is
			-- show current feed in feed detail view
		do
			news_view.display_feed
		end
	
	load_and_initialize_feeds is
			-- load feeds and show them in window
		do
			application.application_displayer.information_displayer.show_temporary_text (Application_load_feeds)
			application.load_feeds
			application.application_displayer.information_displayer.revert
			show_feed_list
			show_feed

		end
		
		
feature {NONE} -- Implementation

	main_container: EV_VERTICAL_BOX
	
	news_view: NEWS_VIEW -- list of feeds and list of items

	build_main_view is
		require
			main_container_not_yet_created: main_container = Void
		do
			create main_container
			create news_view.make
			main_container.extend (news_view)
			
			extend (main_container)
		ensure
			main_container_created: main_container /= Void
		end
		
	restore_window_size_and_position is
			-- restore window size and position from last session if stored
		do
			if application.properties.has ("Window_x_position") then
				set_x_position (application.properties.get ("Window_x_position").to_integer)
			end
			if application.properties.has ("Window_y_position") then
				set_y_position (application.properties.get ("Window_y_position").to_integer)
			end
			set_size (application.properties.get ("Window_width").to_integer, application.properties.get ("Window_height").to_integer)
		end
	
	restore_maximize_minimize is
			-- restore maximized and minimized states from last session
		do
			if 
				application.properties.has ("Window_maximized") 
				and then application.properties.get ("Window_maximized").is_equal ("yes") 
			then
				maximize
			end
			if 
				application.properties.has ("Window_minimized") 
				and then application.properties.get ("Window_minimized").is_equal ("yes") 
			then
				minimize
			end
		end
		
	set_accelerators is
			-- set accelerators for window
		local
			accelerator: EV_ACCELERATOR
			key: EV_KEY
		do
				-- CTRL-Q: quit application
			create key.make_with_code (feature {EV_KEY_CONSTANTS}.key_q)
			create accelerator.make_with_key_combination (key, true, false, false)
			accelerator.actions.extend (agent exit)
			accelerators.extend (accelerator)
				-- CTRL-P: open preferences
			create key.make_with_code (feature {EV_KEY_CONSTANTS}.key_p)
			create accelerator.make_with_key_combination (key, true, false, false)
			accelerator.actions.extend (agent show_preferences)
			accelerators.extend (accelerator)
				-- CTRL-N: add new feed
			create key.make_with_code (feature {EV_KEY_CONSTANTS}.key_n)
			create accelerator.make_with_key_combination (key, true, false, false)
			accelerator.actions.extend (agent on_add)
			accelerators.extend (accelerator)
				-- CTRL-T: refresh feed
			create key.make_with_code (feature {EV_KEY_CONSTANTS}.key_t)
			create accelerator.make_with_key_combination (key, true, false, false)
			accelerator.actions.extend (agent refresh_current)
			accelerators.extend (accelerator)
				-- CTRL-SHIFT-T: refresh all feeds
			create key.make_with_code (feature {EV_KEY_CONSTANTS}.key_t)
			create accelerator.make_with_key_combination (key, true, false, true)
			accelerator.actions.extend (agent refresh_all)
			accelerators.extend (accelerator)
				-- CTRL-U: edit feed/item
			create key.make_with_code (feature {EV_KEY_CONSTANTS}.key_u)
			create accelerator.make_with_key_combination (key, true, false, false)
			accelerator.actions.extend (agent on_info)
			accelerators.extend (accelerator)
				-- CTRL-D: remove selected feed
			create key.make_with_code (feature {EV_KEY_CONSTANTS}.key_d)
			create accelerator.make_with_key_combination (key, true, false, false)
			accelerator.actions.extend (agent remove_feed)
			accelerators.extend (accelerator)
				-- CTRL-SHIFT-D: remove selected item
			create key.make_with_code (feature {EV_KEY_CONSTANTS}.key_d)
			create accelerator.make_with_key_combination (key, true, false, true)
			accelerator.actions.extend (agent on_item_remove)
			accelerators.extend (accelerator)
				-- CTRL-ALT-TAB: open/close debug window
			create key.make_with_code (feature {EV_KEY_CONSTANTS}.key_tab)
			create accelerator.make_with_key_combination (key, true, true, false)
			accelerator.actions.extend (agent on_debug_window)
			accelerators.extend (accelerator)
		end
		

end -- class MAIN_WINDOW
