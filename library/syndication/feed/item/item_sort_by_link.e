indexing
	description: "Sort item by link."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	ITEM_SORT_BY_LINK[G -> ITEM]
	
inherit
	ORDER_RELATION[G]

feature -- Criterion

	ordered (first, second: G): BOOLEAN is
			-- Are `first' and `second' ordered (true if `first' < `second')
		do
			if first.link = Void then
				Result := False
			elseif second.link = Void then
				Result := True
			else
				Result := first.link.location < second.link.location
			end
		end

end -- class ITEM_SORT_BY_LINK
