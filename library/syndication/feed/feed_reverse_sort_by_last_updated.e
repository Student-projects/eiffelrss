indexing
	description: "Reverse sort feed by title."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	FEED_REVERSE_SORT_BY_LAST_UPDATED[G -> FEED]
	
inherit
	ORDER_RELATION[G]

feature -- Criterion

	ordered (first, second: G): BOOLEAN is
			-- Are `first' and `second' ordered (true if `first' > `second')
		do
			if first.last_updated = Void then
				Result := False
			elseif second.last_updated = Void then
				Result := True
			else
				Result := first.last_updated > second.last_updated
			end
		end

end -- class FEED_REVERSE_SORT_BY_LAST_UPDATED
