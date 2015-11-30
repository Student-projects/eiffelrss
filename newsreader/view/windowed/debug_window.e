indexing
	description: "Window that shows properties of application and can be used to show STRINGS in runtime"
	author: "Martin Luder"
	date: "$Date: 2008-03-05 17:43:27 +0100 (mer., 05 mars 2008) $"
	revision: "$Revision: 273 $"

class
	DEBUG_WINDOW

inherit
	EV_TITLED_WINDOW
		rename
			is_empty as window_is_empty
		redefine
			initialize,
			is_in_default_state
		select
			cl_put,
			default_create,
			dispose,
			prune,
			fill,
			full,
			extendible,
			copy,
			cl_extend,
			wipe_out,
			prunable,
			is_inserted,
			prune_all,
			has,
			empty,
			object_comparison,
			changeable_comparison_criterion,
			compare_objects,
			compare_references,
			linear_representation

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

	WINDOWED_EVENTS
		undefine
			default_create,
			copy,
			is_equal
		end

	LOGFILE
		rename
			put as logfile_put,
			item as logfile_item,
			readable as logfile_readable,
			writable as logfile_writable,
			make as logfile_make,
			default_create as logfile_default_create,
			dispose as logfile_dispose,
			prune as logfile_prune,
			fill as logfile_fill,
			count as logfile_count,
			full as logfile_full,
			extendible as logfile_extendible,
			copy as logfile_copy,
			extend as logfile_extend,
			wipe_out as logfile_wipe_out,
			prunable as logfile_prunable,
			is_inserted as logfile_is_inserted,
			prune_all as logfile_prune_all,
			has as logfile_has,
			replace as logfile_replace,
			empty as logfile_empty,
			object_comparison as logfile_object_comparison,
			changeable_comparison_criterion as logfile_changeable_comparison_criterion,
			compare_objects as logfile_compare_objects,
			compare_references as logfile_compare_references,
			linear_representation as logfile_linear_representation
		redefine
			make_filename_threshold,
			make_filename,
			log_message
		select
			is_empty
		end

create
	make_filename_threshold, make_filename

feature {NONE} -- Initialization

	make is
			-- create app_ref and window
		do
			make_app_ref
			default_create
		end

	make_filename_threshold (a_filename: STRING; a_threshold: INTEGER)  is
			-- Create logfile object with a_filename as file name and a_threshold as output threshold
		do
			Precursor {LOGFILE} (a_filename, a_threshold)
			make
		end

	make_filename (a_filename: STRING) is
			-- Create logfile object with a_filename as file name
		do
			Precursor {LOGFILE} (a_filename)
			make
		end

feature {EV_ANY} -- Implementation

	initialize is
		local
			accelerator: EV_ACCELERATOR
			key: EV_KEY
			icon: EV_PIXMAP
			mw: MAIN_WINDOW
		do
			Precursor
			create main_vbox

			create properties_box
			create show_properties.make_with_text ("Show properties")
			show_properties.select_actions.extend (agent on_show_properties)
			main_vbox.extend (show_properties)
			main_vbox.disable_item_expand (show_properties)
			create refesh_button.make_with_text_and_action ("Refresh", agent on_refresh)
			properties_box.extend (refesh_button)
			properties_box.disable_item_expand (refesh_button)
			properties_box.hide
			create properties_view
			properties_view.set_minimum_height (200)
			properties_view.disable_edit
			properties_box.extend (properties_view)
			main_vbox.extend (properties_box)
			create text_view
			text_view.disable_word_wrapping
			text_view.disable_edit
			main_vbox.extend (text_view)
			extend (main_vbox)

				-- set accelerators
			create key.make_with_code (feature {EV_KEY_CONSTANTS}.key_tab)
			create accelerator.make_with_key_combination (key, true, true, false)
			mw ?= application.application_displayer
			if mw /= void then
				accelerator.actions.extend (agent mw.on_debug_window)
			end
			accelerators.extend (accelerator)

			close_request_actions.extend (agent hide)

			set_title ("DEBUG")
			set_size (250, 700)
			set_minimum_size (150, 200)

				-- set icon of window
			create icon
			icon.set_with_named_file ("graphics/newsreader_icon.png")
			set_icon_pixmap (icon)
		end

feature {NONE} -- Implementation

	is_in_default_state: BOOLEAN is true

	main_vbox: EV_VERTICAL_BOX
	refesh_button: EV_BUTTON
	properties_box: EV_VERTICAL_BOX
	properties_view: EV_TEXT
	text_view: EV_TEXT
	show_properties: EV_CHECK_BUTTON
	logfile: LOGFILE


feature -- Events

	on_refresh is
			-- called when refresh button is clicked
		local
			string: STRING
		do
			string := application.application_default_properties.list
			string := string + "%N"
			string := string + application.application_properties.list
			string := string + "%N"
			string := string + application.user_properties.list
			properties_view.set_text (string)

			log_message ("debug window: refresh clicked", Developer)
		end

	on_show_properties is
			-- called when show_properties is clicked
		do
			if show_properties.is_selected then
				properties_box.show
				on_refresh
			else
				properties_box.hide
			end
		end


feature -- Basic operations

	log_message (a_message: STRING; a_priority: INTEGER) is
			-- Log the message to the logfile if a_priority is equal or greater than the threshold
			-- Add message to window
		do
			Precursor (a_message, a_priority)
			if (a_priority >= output_threshold) then
				text_view.append_text (a_message + "%N")
			end
		end


end -- class DEBUG_WINDOW
