indexing
	description	: "Strings for the Graphical User Interface"
	author		: "Martin Luder"
	date		: "$Date: 2005-01-31 18:17:23 +0100 (lun., 31 janv. 2005) $"
	revision	: "1.0.0"

deferred class
	WINDOWED_INTERFACE_NAMES

inherit
	INTERFACE_NAMES


feature -- Buttons

	Button_ok_item: STRING is "OK"
			-- String for "OK" buttons.
	
	Button_cancel_item: STRING is "Cancel"
			-- String for "Cancel" buttons

feature -- Menus

	Menu_file_item: STRING is "&File"
			-- String for menu "File"

	Menu_file_exit_item: STRING is "E&xit%TCtrl+Q"
			-- String for menu "File/Exit"

	Menu_edit_item: STRING is "E&dit"
			-- String for menu "Edit"
	
	Menu_edit_preferences_item: STRING is "&Preferences...%TCtrl+P"
			-- String for menu "Edit/Preferences..."
	
	Menu_channel_item: STRING is "&Channel"
			-- String for menu "Channel
	
	Menu_channel_add_item: STRING is "&Add...%TCtrl+N"
			-- String for menu "Channel/Add..."
	
	Menu_channel_refresh_item: STRING is "&Refresh%TCtrl+T"
			-- String for menu "Channel/Refresh"
	
	Menu_channel_feed_info_item: STRING is "Feed information...%TAlt+2"
			-- String for menu "Channel/Feed Information"
	
	Menu_channel_item_info_item: STRING is "Item information...%TAlt+3"
			-- String for menu "Channel/Item information"
	
	Menu_channel_feed_remove_item: STRING is "Re&move feed%TCtrl+D"
			-- String for menu "Channel/Remove"
	
	Menu_channel_item_remove_item: STRING is "Rem&ove item%TCtrl+Shift+D"
			-- String for menu "Channel/Remove item"
	
	Menu_channel_refresh_all_item: STRING is "Refresh a&ll%TCtrl+Shift+T"
			-- String for menu "Channel/Reload all"
	
	Menu_help_item: STRING is "&Help"
			-- String for menu "Help"

	Menu_help_contents_item: STRING is "&Contents and Index"
			-- String for menu "Help/Contents and Index"

	Menu_help_about_item: STRING is "&About..."
			-- String for menu "Help/About"


feature -- toolbar

	Toolbar_refresh_tooltip: STRING is "Refresh all feeds"
			-- String for toolbar item 'refresh' tooltip
	
	Toolbar_remove_tooltip: STRING is "Remove selected feed/item"
			-- String for toolbar item 'delete' tooltip
	
	Toolbar_info_tooltip: STRING is "Information on selected feed/item"
			-- String for toolbar item 'edit' tooltip
	
	Toolbar_preferences_tooltip: STRING is "Show preferences"
			-- String for toolbar item 'preferences' tooltip

feature -- info

	Info_title: STRING is "Information"
			-- String for info dialog title bar
	
	Info_name_item: STRING is "Name"
			-- String for 'Name' item in info dialog
	
	Info_address_item: STRING is "Address"
			-- String for 'Address' item in info dialog

feature -- item info

	Item_info_title: STRING is "Item information"
			-- String for item info title bar
feature -- add

	Add_title: STRING is "Add"
			-- String for add dialog title bar
			
	Add_address_item: STRING is "Address"
			-- String for 'Address' item in add dialog
	
	Add_empty_address_information: STRING is "Please enter an address"
			-- String for status bar when no address is entered in add dialog

feature -- preferences

	Preferences_title: STRING is "Preferences"
			-- String for preferences dialog title bar
			
	Preferences_ask_on_exit_item: STRING is "Ask on exit"
			-- String for 'Ask on exit' item in preferences
	Preferences_ask_on_exit_tooltip: STRING is "Enable to show a confirmation dialog %Nwhen exiting the program"
			-- String for 'Ask on exit' item tooltip in preferences
			
	Preferences_user_specific_item: STRING is "User specific settings"
			-- String for 'User specific settings' item in preferences
	Preferences_user_specific_tooltip: STRING is "Enable to allow custom preferences %Nfor each user"
			-- String for 'User specific settings' item tooltip in preferences
	
	Preferences_share_feeds_item: STRING is "Share feeds"
			-- String for 'Share feeds' item in preferences
	Preferences_share_feeds_tooltip: STRING is "Save new feeds to common directory %Ninstead of user directory"
			-- String for 'Share feeds' item tooltip in preferences
	
	Preferences_show_toolbar_item: STRING is "Show toolbar"
			-- String for 'Show toolbar' item in preferences
	Preferences_show_toolbar_tooltip: STRING is "Enable to show the toolbar %Nin the main window"
			-- String for 'Show toolbar' item tooltip in preferences
	
	Preferences_browser_path_item: STRING is "Browser path"
			-- String for 'Browser path' item in preferences
	Preferences_browser_path_tooltip: STRING is "Enter path to browser executable %Nthat you want to use"
			-- String for 'Browser path' item tooltip in preferences
	
	Preferences_date_format_item: STRING is "Date format"
			-- String for 'Date format' item in preferences
	Preferences_date_format_tooltip: STRING is "Set date format with a EIFFEL date format string%Nvisit award winning page http://www.eiffel.com"
			-- String for 'Format_string' item tooltip in preferences

feature -- feed representation
	Label_confirm_close_window: STRING is "Are you sure you want to close .%NClick OK to proceed."
			-- String for the confirmation dialog box that appears
			-- when the user try to close the first window.
	
	Newsfeed_list_label_item: STRING is "Feeds"
			-- String for the newsfeed list label
	
	Feed_detail_view_title_column: STRING is "Title"
			-- String for the title column in the feed detail view
	
	Feed_detail_view_description_column: STRING is "Description"
			-- String for the description column in the feed detail view
	
	Feed_detail_view_date_column: STRING is "Date"
			-- String for the date column in the feed detail view

end -- class INTERFACE_NAMES
