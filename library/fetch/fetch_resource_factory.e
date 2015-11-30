indexing
	description: "Resource factory which uses HTTP 1.1"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	FETCH_RESOURCE_FACTORY

inherit
	DATA_RESOURCE_FACTORY
	redefine
		Resource_factory
	end
	
feature
	Resource_factory: DATA_RESOURCE_FACTORY_IMPL is
			-- Singleton of resource factory
		once
			create {FETCH_RESOURCE_FACTORY_IMPL} Result.make
		end

end -- class FETCH_RESOURCE_FACTORY
