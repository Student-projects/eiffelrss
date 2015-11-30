indexing
	description: "Objects that have a reference to {EV_ENRIRONMENT}.application"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

deferred class
	APP_REF

feature -- Initialization

	make_app_ref is
			-- set application reference
		do
			application ?= (create {EV_ENVIRONMENT}).application
		ensure
			application_set: application = (create {EV_ENVIRONMENT}).application
		end
		
feature {NONE} -- Implementation
	
	application: APPLICATION
			-- reference to application

invariant
	app_not_void: application /= void
end -- class APPLICATION_REFERENCE
