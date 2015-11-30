indexing
	description: "Sort item by title."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	ITEM_SORT_BY_TITLE[G -> ITEM]
	
inherit
	ORDER_RELATION[G]

feature -- Criterion

	ordered (first, second: G): BOOLEAN is
			-- Are `first' and `second' ordered (true if `first' < `second')
		do
			if first.title = Void then
				Result := False
			elseif second.title = Void then
				Result := True
			else
				Result := first.title < second.title
			end
		end

end -- class ITEM_SORT_BY_TITLE
