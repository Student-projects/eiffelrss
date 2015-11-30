indexing
	description: "Class to represent skip hours (integers from 0 to 23)."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	CHANNEL_SKIP_HOURS
	
inherit
	TWO_WAY_SORTED_SET[INTEGER]
		redefine
			extend, put
		end
	EXCEPTIONS
		undefine
			is_equal
		end
		
create
	make

feature -- Element change

	extend, put (v: INTEGER) is
			-- Ensure that structure includes `v'.
		local
			found: BOOLEAN
		do
			if v < 0 or v > 23 then
				raise ("CHANNEL_SKIP_HOURS: Item out of bound")
			end
			
			search_after (v)
			if after or else not item.is_equal (v) then
				put_left (v)
				back
			end
			if object_comparison then
				if after or else not equal (item, v) then
					put_left (v)
					back
				end
			else
				from
				until
					found or after or else not equal (item, v)
				loop
					found := item = v
					forth
				end
				if not found then
					put_left (v)
				end
				back
			end
		end

end -- class CHANNEL_SKIP_HOURS
