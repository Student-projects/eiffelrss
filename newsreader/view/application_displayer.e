indexing
	description: "Application interfaces"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

deferred class
	APPLICATION_DISPLAYER

inherit
	APP_REF
		undefine
			default_create,
			copy,
			is_equal
		end
		
	INTERFACE_NAMES
		undefine
			default_create,
			copy,
			is_equal
		end
		
feature -- Initialization
	
	make is
		deferred
		end
		
feature -- Access

	information_displayer: INFORMATION_DISPLAYER

feature -- Basic Operations

	load_and_initialize_feeds is
			-- load and initialize display of feeds
		deferred
		end

invariant
	information_displayer_not_void: information_displayer /= void

end -- class APPLICATION_DISPLAYER
