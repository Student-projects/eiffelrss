indexing
	description: "Implementation of INFORMATION_DISPLAYER as a status bar"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	STATUS_BAR

inherit
	INFORMATION_DISPLAYER
		undefine
			default_create,
			copy,
			is_equal
		redefine
			make
		end
	
	EV_STATUS_BAR
		redefine
			initialize
		end

create
	make,
	make_with_text

feature -- Initialization

	make is
			-- creation procedure
		do
			Precursor {INFORMATION_DISPLAYER}
			default_create
		end
	
	initialize is
		local
			sep: EV_VERTICAL_SEPARATOR
		do
			Precursor
			set_border_width (2)
			
			create main_label
			main_label.align_text_left
			extend (main_label)

			create progress_box
			create sep
			progress_box.extend (sep)
			progress_box.disable_item_expand (sep)
			create progress_bar
			progress_box.extend (progress_bar)
			progress_bar.set_minimum_width (100)
			progress_bar.set_minimum_height (height-4)
			progress_box.disable_item_expand (progress_bar)
			extend (progress_box)
			disable_item_expand (progress_box)
			progress_box.show
		end
		
feature -- Progress display

	show_progress (s: INTEGER) is
			-- show progress and set number of steps to s
			-- set text to t afterwards
		local
			pbar: EV_HORIZONTAL_PROGRESS_BAR
		do
			is_progressing := true
			create pbar.make_with_value_range (create {INTEGER_INTERVAL}.make (0, s))
			pbar.set_minimum_width (100)
			pbar.set_minimum_height (height-4)
			if progress_box.has (progress_bar) then
				progress_box.search (progress_bar)
				progress_box.replace (pbar)
				pbar.show
				pbar.disable_segmentation
				progress_bar := pbar
			end
			
		end
	
	progress_forward is
			-- increase progress
		do
			if is_progressing then
				progress_bar.step_forward
				if progress_bar.value = progress_bar.value_range.upper then
					progress_done
				end
			end
		end
	
	progress_backward is
			-- decrease progress
		do
			if is_progressing then
				progress_bar.step_backward
			end
		end
	
	progress_done is
			-- finish progress
		do
			progress_bar.set_value (0)
			is_progressing := false
		end
		

feature {NONE} -- Implementation

	show_current is
			-- update status bar to current message
		do
			main_label.set_text (current_text)
			show
		end
		
	main_label: EV_LABEL
	
	progress_box: EV_HORIZONTAL_BOX
	
	progress_bar: EV_HORIZONTAL_PROGRESS_BAR
	
	progress_count: INTEGER
	
	is_progressing: BOOLEAN

end -- class STATUS_BAR
