note
	description: "HTTP URL which supports special chars"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	FETCH_HTTP_URL

inherit
	HTTP_URL
	redefine
		make
	end

create
	make

feature {NONE} -- Initialization

	make (a: STRING)
			-- Create address.
		do
			Precursor (a)
			
			path_charset.add ("?")			
			path_charset.add ("&")
			path_charset.add ("=")
			path_charset.add (";")
		end

end -- class FETCH_HTTP_URL
