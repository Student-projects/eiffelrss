indexing
	description: "Class that provides access to a global logfile"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

deferred class
	LOGGER

feature -- Logging
	
	logfile: LOGFILE
			-- logfile of the application

	create_log is
			-- create logfile
		deferred
		end

invariant
	logfile_not_void: logfile /= void
end -- class LOGGER
