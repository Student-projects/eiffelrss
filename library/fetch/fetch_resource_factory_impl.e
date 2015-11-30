indexing
	description: "Resource factory which can generate the HTTP 1.1 object"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	FETCH_RESOURCE_FACTORY_IMPL

inherit
	DATA_RESOURCE_FACTORY_IMPL
	redefine
		create_http_url,
		create_http_resource
	end
	
create
	make

feature
	create_http_url: URL is
			-- Create HTTP URL.
		do
			create {FETCH_HTTP_URL} Result.make (address)
		end

	create_http_resource: DATA_RESOURCE is
			-- Create HTTP service.
		local
			u: HTTP_URL
		do
			u ?= url
				check
					type_correct: u /= Void
						-- Because factory has created the right URL type
				end

			create {FETCH_HTTP_PROTOCOL} Result.make (u)
		end

end -- class FETCH_RESOURCE_FACTORY_IMPL
