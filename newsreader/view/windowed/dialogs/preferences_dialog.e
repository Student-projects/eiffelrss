indexing
	description: "Preferences dialog box"
	author: "Martin Luder"
	date: "$Date: 2008-03-05 17:43:27 +0100 (mer., 05 mars 2008) $"
	revision: "$Revision: 273 $"

class
	PREFERENCES_DIALOG

inherit
	SETTINGS_DIALOG
		rename
			on_ok as save
		redefine
			initialize,
			make
		end

create
	make

feature {NONE} -- Initialization

	make is
		do
			Precursor
			load_properties
		end

feature {EV_ANY} -- Implementation

	initialize is
		local
			hbox: EV_HORIZONTAL_BOX
			cell: EV_CELL
			label: EV_LABEL
		do
			Precursor
			application.logfile.log_message ("showing preferences dialog", feature{LOGFILE}.Developer)

				-- create options widgets:

				-- Ask_on_exit
			create ask_on_exit.make_with_text (Preferences_ask_on_exit_item)
			ask_on_exit.set_tooltip (Preferences_ask_on_exit_tooltip)
			content.extend (ask_on_exit)
			content.disable_item_expand (ask_on_exit)
				-- User_specific
			create user_specific.make_with_text (Preferences_user_specific_item)
			user_specific.set_tooltip (Preferences_user_specific_tooltip)
			user_specific.select_actions.extend (agent on_user_specific_select)
			content.extend (user_specific)
			content.disable_item_expand (user_specific)
				-- Share_feeds
			create share_feeds.make_with_text (Preferences_share_feeds_item)
			share_feeds.set_tooltip (Preferences_share_feeds_tooltip)
			create hbox
			create cell
			cell.set_minimum_width (20)
			hbox.extend (cell)
			hbox.disable_item_expand (cell)
			hbox.extend (share_feeds)
			content.extend (hbox)
			content.disable_item_expand (hbox)
				-- Show_toolbar
			create show_toolbar.make_with_text (Preferences_show_toolbar_item)
			show_toolbar.set_tooltip (Preferences_show_toolbar_tooltip)
			content.extend (show_toolbar)
			content.disable_item_expand (show_toolbar)
				-- Browser_path
			create browser_path
			browser_path.set_tooltip (Preferences_browser_path_tooltip)
			browser_path.set_minimum_width (80)
			create hbox
			create label.make_with_text (Preferences_browser_path_item + ":")
			label.set_minimum_width (100)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			hbox.extend (browser_path)
			content.extend (hbox)
			content.disable_item_expand (hbox)
				-- Date_format
			create date_format
			date_format.set_tooltip (Preferences_date_format_tooltip)
			date_format.set_minimum_width (80)
			create hbox
			create label.make_with_text (Preferences_date_format_item + ":")
			label.set_minimum_width (100)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			hbox.extend (date_format)
			content.extend (hbox)
			content.disable_item_expand (hbox)


				-- set dialog options
			set_title (preferences_title)
			set_minimum_size (400, 200)
		end

feature {NONE} -- Implementation

	ask_on_exit: EV_CHECK_BUTTON
		-- Ask_on_exit option

	user_specific: EV_CHECK_BUTTON
		-- User_specific option

	share_feeds: EV_CHECK_BUTTON
		-- Share_feeds option

	show_toolbar: EV_CHECK_BUTTON
		-- Show_toolbar option

	browser_path: EV_TEXT_FIELD
		-- path to browser

	date_format: EV_TEXT_FIELD
		-- date format

	save is
			-- save properties to properties objects and write to files
			-- is callon on ok_button click
		local
			mw: MAIN_WINDOW
		do
			application.application_displayer.information_displayer.show_progress (8)
			application.application_displayer.information_displayer.progress_forward
				-- User_specific
			if user_specific.is_selected then
				if application.properties.get ("User_specific").is_equal ("no") then
					application.load_user_properties
				end
				application.logfile.log_message ("Preferences: setting 'User_specific' to 'yes'", application.logfile.developer)
				application.application_properties.force ("yes", "User_specific")
			else
				application.logfile.log_message ("Preferences: setting 'User_specific' to 'no'", application.logfile.developer)
				application.application_properties.force ("no", "User_specific")
			end
			application.application_displayer.information_displayer.progress_forward
				-- Share_feeds
			if share_feeds.is_selected then
				application.logfile.log_message ("Preferences: setting 'Share_feeds' to 'yes'", application.logfile.developer)
				application.application_properties.force ("yes", "Share_feeds")
			else
				application.logfile.log_message ("Preferences: setting 'Share_feeds' to 'no'", application.logfile.developer)
				application.application_properties.force ("no", "Share_feeds")
			end
			application.application_displayer.information_displayer.progress_forward
				-- Ask_on_exit
			if ask_on_exit.is_selected then
				application.logfile.log_message ("Preferences: setting 'Ask_on_exit' to 'yes'", application.logfile.developer)
				application.properties.force ("yes", "Ask_on_exit")
			else
				application.logfile.log_message ("Preferences: setting 'Ask_on_exit' to 'no'", application.logfile.developer)
				application.properties.force ("no", "Ask_on_exit")
			end
			application.application_displayer.information_displayer.progress_forward
				-- Show_toolbar
			mw ?= application.application_displayer
			if show_toolbar.is_selected then
				application.logfile.log_message ("Preferences: setting 'Show_toolbar' to 'yes'", feature{LOGFILE}.developer)
				application.properties.force ("yes", "Show_toolbar")
				if mw /= void then mw.toolbar.show end
			else
				application.logfile.log_message ("Preferences: setting 'Show_toolbar' to 'no'", feature{LOGFILE}.developer)
				application.properties.force ("no", "Show_toolbar")
				if mw /= void then mw.toolbar.hide end
			end
			application.application_displayer.information_displayer.progress_forward
				-- Browser_path
			application.logfile.log_message ("Preferences: setting 'Browser_path' to '" + browser_path.text + "'", feature{LOGFILE}.developer)
			application.properties.force (browser_path.text, "Browser_path")
				-- Date_format
			application.logfile.log_message ("Preferences: setting 'Date_format' to '" + date_format.text + "'", feature{LOGFILE}.developer)
			application.properties.force (date_format.text, "Date_format")

			application.application_displayer.information_displayer.progress_forward
				-- save properties
			application.save_properties
			application.application_displayer.information_displayer.progress_forward
			application.load_properties
			application.application_displayer.information_displayer.progress_done
			application.application_displayer.information_displayer.revert
		end

	load_properties is
			-- set widgets in window to current properties' values
			-- called in initialization of dialog
		do
			application.application_displayer.information_displayer.show_progress (6)
			application.application_displayer.information_displayer.progress_forward
			if application.properties.get ("Ask_on_exit").is_equal ("yes") then
				ask_on_exit.enable_select
			end
			application.application_displayer.information_displayer.progress_forward
			if application.properties.get ("User_specific").is_equal ("yes") then
				user_specific.enable_select
			else
				share_feeds.disable_sensitive
			end
			application.application_displayer.information_displayer.progress_forward
			if application.properties.get ("Show_toolbar").is_equal ("yes") then
				show_toolbar.enable_select
			end
			application.application_displayer.information_displayer.progress_forward
			browser_path.set_text (application.properties.get ("Browser_path"))
			application.application_displayer.information_displayer.progress_forward
			date_format.set_text (application.properties.get ("Date_format"))
			application.application_displayer.information_displayer.progress_done
		end

feature {NONE} -- Events

	on_user_specific_select is
			--
		do
			if user_specific.is_selected then
				share_feeds.enable_sensitive
			else
				share_feeds.disable_sensitive
			end
		end

end -- class PREFERENCES_DIALOG
