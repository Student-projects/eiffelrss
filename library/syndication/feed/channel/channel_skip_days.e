indexing
	description: "Class to represent skip days."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	CHANNEL_SKIP_DAYS
	
inherit
	TWO_WAY_SORTED_SET[STRING]
		redefine
			extend, put, make
		end
	EXCEPTIONS
		undefine
			is_equal
		end
		
create
	make

feature -- Initialization

	make is
			-- Create an empty list.
		do
			Precursor {TWO_WAY_SORTED_SET}
			compare_objects
		end

feature -- Element change

	extend, put (v: STRING) is
			-- Ensure that structure includes `v'.
		local
			found: BOOLEAN
			str: STRING
		do
			v.to_lower
			if 
				not (
					v.is_equal ("monday") or
					v.is_equal ("tuesday") or
					v.is_equal ("wednesday") or
					v.is_equal ("thursday") or
					v.is_equal ("friday") or
					v.is_equal ("saturday") or
					v.is_equal ("sunday")
				)
			then
				raise ("CHANNEL_SKIP_DAYS: Item out of bound")
			end
			
			str := v.item (1).out
			str.to_upper
			v.remove (1)
			v.prepend (str)
			
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

end-- class CHANNEL_SKIP_DAYS
