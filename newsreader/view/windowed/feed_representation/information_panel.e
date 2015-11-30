indexing
	description: "Objects that provide a general layout for representation of lists and tables"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	INFORMATION_PANEL

inherit
	EV_VERTICAL_BOX

	WINDOWED_INTERFACE_NAMES
		export
			{NONE} all
		undefine
			default_create, copy, is_equal
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

feature -- Initialisation
	
	make is
			-- creation procedure
		local
			font: EV_FONT
			cell: EV_CELL
			hbox: EV_HORIZONTAL_BOX
		do
			default_create
			make_app_ref
			
				-- create label
			create label
			label.set_minimum_height (20)
			label.align_text_left
			create font
			font.set_weight (8)
			label.set_font (font)
			create hbox
			create cell
			cell.set_minimum_width (20)
			hbox.extend (cell)
			hbox.disable_item_expand (cell)
			create label_left_box
			label_left_box.extend (label)
			label_left_box.disable_item_expand (label)
			hbox.extend (label_left_box)
			create label_box
			label_box.extend (hbox)
			extend (label_box)
			disable_item_expand (label_box)
		end
		
		
	
feature {NONE} -- Implementation
	
	label_box: EV_HORIZONTAL_BOX
	label_left_box: EV_VERTICAL_BOX
	
	label: EV_LABEL
	
	set_label_text (text: STRING) is
			-- set the text of the label to 'text'
		require
			text_not_void: text /= void
		do
			label.set_text (text)
		end
		
		

end -- class INFORMATION_PANEL
