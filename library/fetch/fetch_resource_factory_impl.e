note
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

	create_http_url: HTTP_URL
			-- Create HTTP URL.
		do
			if attached address as add then
				create {FETCH_HTTP_URL} Result.make (add)
			else
				create {FETCH_HTTP_URL} Result.make ("")
			end
		end

	create_http_resource: HTTP_PROTOCOL
			-- Create HTTP service.
		do
			if attached {HTTP_URL} url as u then
				create {FETCH_HTTP_PROTOCOL} Result.make (u)
			else
				create {FETCH_HTTP_PROTOCOL} Result.make (create_http_url)
				check
					type_correct: False
					-- Because factory has created the right URL type
				end
			end
		end

end -- class FETCH_RESOURCE_FACTORY_IMPL
