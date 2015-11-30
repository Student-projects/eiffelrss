indexing
	description: "Add dialog box"
	author: "Martin Luder"
	date: "$Date: 2008-03-05 17:43:27 +0100 (mer., 05 mars 2008) $"
	revision: "$Revision: 273 $"

class
	ADD_DIALOG

inherit
	SETTINGS_DIALOG
		rename
			on_ok as on_add_feed
		redefine
			initialize
		end

create
	make

feature {EV_ANY} -- Implementation

	initialize is
		local
			hbox: EV_HORIZONTAL_BOX
			label: EV_LABEL
		do
			Precursor
			application.logfile.log_message ("showing add dialog", feature{LOGFILE}.Developer)

			create hbox
			create label.make_with_text (Add_address_item + ":")
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create address
			address.set_minimum_width (200)
			hbox.extend (address)
			content.extend (hbox)
			content.extend (create {EV_CELL})

			ok_button.select_actions.finish
			ok_button.select_actions.remove

				-- set dialog options
			set_title (Add_title)
		end

feature {NONE} -- Implementation

	address: EV_TEXT_FIELD

	on_add_feed is
			-- called when ok is clicked
		local
			mw: MAIN_WINDOW
		do
			if address.text_length > 0 then
				application.application_displayer.information_displayer.revert
				destroy
				add_feed (address.text)
				mw ?= application.application_displayer
				if mw /= void then
					mw.show_feed_list
					mw.show_feed
				end
			else
				application.application_displayer.information_displayer.show_temporary_text (Add_empty_address_information)
			end
		end


end -- class ADD_DIALOG
