indexing
	description: "Reverse sort feed by link."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	FEED_REVERSE_SORT_BY_LINK[G -> FEED]
	
inherit
	ORDER_RELATION[G]

feature -- Criterion

	ordered (first, second: G): BOOLEAN is
			-- Are `first' and `second' ordered (true if `first' > `second')
		require else
			first_non_void: first /= Void
			second_non_void: second /= Void
		do
			Result := first.link.location > second.link.location
		end

end -- class FEED_REVERSE_SORT_BY_LINK
