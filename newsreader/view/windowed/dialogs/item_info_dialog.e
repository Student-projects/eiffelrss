indexing
	description: "item information dialog box"
	author: "Martin Luder"
	date: "$Date: 2008-03-05 17:43:27 +0100 (mer., 05 mars 2008) $"
	revision: "$Revision: 273 $"

class
	ITEM_INFO_DIALOG

inherit
	SETTINGS_DIALOG
		redefine
			initialize
		end

create
	make

feature {EV_ANY} -- Implementation

	initialize is
		local
			hbox: EV_HORIZONTAL_BOX
			vbox: EV_VERTICAL_BOX
			label: EV_LABEL
		do
			Precursor
			application.logfile.log_message ("showing item edit dialog", feature{LOGFILE}.Developer)

				-- title
			create hbox
			create label.make_with_text (Info_item_title_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create item_title
			hbox.extend (item_title)
			content.extend (hbox)
				-- description
			create hbox
			create label.make_with_text (Info_item_description_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			create vbox
			vbox.extend (label)
			vbox.disable_item_expand (label)
			vbox.extend (create {EV_CELL})
			hbox.extend (vbox)
			hbox.disable_item_expand (vbox)
			create description
			description.set_minimum_height (description.height * 2)
			description.enable_word_wrapping
			hbox.extend (description)
			content.extend (hbox)
				-- link
			create hbox
			create label.make_with_text (Info_item_link_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create link
			hbox.extend (link)
			content.extend (hbox)
				-- author
			create hbox
			create label.make_with_text (Info_item_author_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create author
			hbox.extend (author)
			content.extend (hbox)
				-- publication date
			create hbox
			create label.make_with_text (Info_item_pub_date_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create pub_date
			hbox.extend (pub_date)
			content.extend (hbox)

			set_minimum_width (300)

			load

			set_title (Item_info_title + ": '" + feed_item.title + "'")
		end

feature {NONE} -- Implementation

	on_ok is
			-- click on ok
		do

		end

	item_title, link, author, pub_date: EV_TEXT_FIELD

	description: EV_TEXT

	label_width: INTEGER is 70

	feed_item: ITEM

	load is
			-- load information from feed item
		local
			mw: MAIN_WINDOW
		do
			mw ?= application.application_displayer
			if mw /= void then
				feed_item := mw.selected_item

				application.application_displayer.information_displayer.show_progress (6)
				application.application_displayer.information_displayer.progress_forward
				item_title.set_text (feed_item.title)
				application.application_displayer.information_displayer.progress_forward
				description.set_text (feed_item.description)
				application.application_displayer.information_displayer.progress_forward
				link.set_text (feed_item.link.location)
				application.application_displayer.information_displayer.progress_forward
				if feed_item.has_author then
					author.set_text (feed_item.author)
				end
				application.application_displayer.information_displayer.progress_forward
				if feed_item.has_pub_date then
					pub_date.set_text (feed_item.pub_date.formatted_out (application.properties.get ("Date_format")))
				end
				application.application_displayer.information_displayer.progress_done

			end
		end


end -- class ITEM_EDIT_DIALOG
