indexing
	description: "feed information dialog box"
	author: "Martin Luder"
	date: "$Date: 2008-03-05 17:43:27 +0100 (mer., 05 mars 2008) $"
	revision: "$Revision: 273 $"

class
	FEED_INFO_DIALOG

inherit
	SETTINGS_DIALOG
		rename
			on_ok as on_edited
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
			application.logfile.log_message ("showing feed edit dialog", feature{LOGFILE}.Developer)

				-- title
			create hbox
			create label.make_with_text (Info_feed_title_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create feed_title
			hbox.extend (feed_title)
			content.extend (hbox)
				-- description
			create hbox
			create label.make_with_text (Info_feed_description_item + ":")
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
			create label.make_with_text (Info_feed_link_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create link
			hbox.extend (link)
			content.extend (hbox)
				-- publication date
			create hbox
			create label.make_with_text (Info_feed_pub_date_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create pub_date
			hbox.extend (pub_date)
			content.extend (hbox)
				-- language
			create hbox
			create label.make_with_text (Info_feed_language_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create language
			hbox.extend (language)
			content.extend (hbox)
				-- managing_editor
			create hbox
			create label.make_with_text (Info_feed_managing_editor_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create managing_editor
			hbox.extend (managing_editor)
			content.extend (hbox)
				-- web_master
			create hbox
			create label.make_with_text (Info_feed_web_master_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create web_master
			hbox.extend (web_master)
			content.extend (hbox)
				-- last_build_date
			create hbox
			create label.make_with_text (Info_feed_last_build_date_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create last_build_date
			hbox.extend (last_build_date)
			content.extend (hbox)
				-- feed_generator
			create hbox
			create label.make_with_text (Info_feed_feed_generator_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create feed_generator
			hbox.extend (feed_generator)
			content.extend (hbox)
				-- copyright
			create hbox
			create label.make_with_text (Info_feed_copyright_item + ":")
			label.set_minimum_width (label_width)
			label.align_text_left
			hbox.extend (label)
			hbox.disable_item_expand (label)
			create copyright
			hbox.extend (copyright)
			content.extend (hbox)

			set_minimum_width (300)

			load

			set_title (Info_title + ": '" + feed.title + "'")
		end

feature {NONE} -- Implementation

	on_edited is
			-- called when ok is clicked
		do

		end

	feed: FEED

	feed_title, link, pub_date, language, copyright, managing_editor, web_master, last_build_date, feed_generator, docs: EV_TEXT_FIELD

	description: EV_TEXT

	label_width: INTEGER is 90

	load is
			-- load feed information
		do
			feed := application.current_feed

			application.application_displayer.information_displayer.show_progress (11)
			application.application_displayer.information_displayer.progress_forward
				-- feed_title
			feed_title.set_text (feed.title)
			application.application_displayer.information_displayer.progress_forward
				-- description
			description.set_text (feed.description)
			application.application_displayer.information_displayer.progress_forward
				-- link
			link.set_text (feed.link.location)
			application.application_displayer.information_displayer.progress_forward
				-- pub_date
			if feed.has_pub_date then
				pub_date.set_text (feed.pub_date.formatted_out (application.properties.get ("Date_format")))
			end
			application.application_displayer.information_displayer.progress_forward
				-- language
			if feed.has_language then
				language.set_text (feed.language)
			end
			application.application_displayer.information_displayer.progress_forward
				-- copyright
			if feed.has_copyright then
				copyright.set_text (feed.copyright)
			end
			application.application_displayer.information_displayer.progress_forward
				-- managing_editor
			if feed.has_managing_editor then
				managing_editor.set_text (feed.managing_editor)
			end
			application.application_displayer.information_displayer.progress_forward
				-- web_master
			if feed.has_web_master then
				web_master.set_text (feed.web_master)
			end
				-- last_build_date
			if feed.has_last_build_date then
				last_build_date.set_text (feed.last_build_date.formatted_out (application.properties.get ("Date_format")))
			end
			application.application_displayer.information_displayer.progress_forward
				-- feed_generator
			if feed.has_feed_generator then
				feed_generator.set_text (feed.feed_generator)
			end
			application.application_displayer.information_displayer.progress_forward
			application.application_displayer.information_displayer.progress_done
		end

end -- class EDIT_DIALOG
