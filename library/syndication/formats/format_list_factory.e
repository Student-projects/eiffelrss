indexing
	description: "Singleton pattern factory for FORMAT_LIST"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	FORMAT_LIST_FACTORY
	
feature -- Access

	Format_list: FORMAT_LIST is
			-- Singleton of resource factory
		once
			create Result.make_list
		end

end -- class FORMAT_LIST_FACTORY
