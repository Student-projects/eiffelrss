indexing
	description: "About dialog box"
	author: "Martin Luder"
	date: "$Date: 2008-03-05 17:43:27 +0100 (mer., 05 mars 2008) $"
	revision: "1.0.0"

class
	ABOUT_DIALOG

inherit
	EV_DIALOG
		redefine
			initialize
		end

	WINDOWED_INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create,
			copy
		end

	APP_REF
		undefine
			default_create,
			copy,
			is_equal
		end

create
	default_create

feature {EV_ANY} -- Implementation

	initialize is
		local
			main_horizontal_box: EV_HORIZONTAL_BOX
			left_vertical_box: EV_VERTICAL_BOX
			right_vertical_box: EV_VERTICAL_BOX
			buttons_box: EV_HORIZONTAL_BOX
			icon: EV_PIXMAP
			label: EV_LABEL
		do
			make_app_ref
			Precursor
			application.logfile.log_message ("showing about window", feature{LOGFILE}.Developer)
			create ok_button.make_with_text (button_ok_item)
			ok_button.set_minimum_size (75, 24)
			ok_button.select_actions.extend (agent destroy)
			create buttons_box
			buttons_box.extend (create {EV_CELL})
			buttons_box.extend (ok_button)
			buttons_box.disable_item_expand (ok_button)
			create left_vertical_box
			left_vertical_box.set_padding (7)
			create label.make_with_text (Application_name + " v" + Application_version_number)
			left_vertical_box.extend (label)
			left_vertical_box.disable_item_expand (label)
			create label.make_with_text (Application_about)
			left_vertical_box.extend (label)
			left_vertical_box.disable_item_expand (label)
			create right_vertical_box
			right_vertical_box.set_padding (7)
			right_vertical_box.extend (buttons_box)
			right_vertical_box.disable_item_expand (buttons_box)
			create main_horizontal_box
			main_horizontal_box.set_border_width (7)
			main_horizontal_box.extend (left_vertical_box)
			main_horizontal_box.extend (right_vertical_box)
			extend (main_horizontal_box)
			set_default_push_button (ok_button)
			set_default_cancel_button (ok_button)
			set_title (Application_about_title)
			set_size (400, 150)

				-- set icon of window
			create icon
			icon.set_with_named_file ("graphics/newsreader_icon.png")
			set_icon_pixmap (icon)
		end

feature {NONE} -- Implementation

	ok_button: EV_BUTTON

end -- class ABOUT_DIALOG
