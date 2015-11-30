note
	description: "Reverse sort feed by title."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	FEED_REVERSE_SORT_BY_LAST_UPDATED[G -> FEED]

inherit
	ORDER_RELATION[G]

feature -- Criterion

	ordered (first, second: G): BOOLEAN
			-- Are `first' and `second' ordered (true if `first' > `second')
		local
			l_first_last_updated,
			l_second_last_updated: like {FEED}.last_updated
		do
			l_first_last_updated := first.last_updated
			if l_first_last_updated = Void then
				Result := False
			else
				l_second_last_updated := second.last_updated
				if l_second_last_updated = Void then
					Result := True
				else
					Result := l_first_last_updated > l_second_last_updated
				end
			end
		end

end -- class FEED_REVERSE_SORT_BY_LAST_UPDATED
