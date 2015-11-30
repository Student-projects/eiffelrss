indexing
	description: "Sort item by publication date."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	ITEM_SORT_BY_PUB_DATE[G -> ITEM]
	
inherit
	ORDER_RELATION[G]

feature -- Criterion

	ordered (first, second: G): BOOLEAN is
			-- Are `first' and `second' ordered (true if `first' < `second')
		do
			if first.pub_date = Void then
				Result := False
			elseif second.pub_date = Void then
				Result := True
			else
				Result := first.pub_date < second.pub_date
			end
		end

end -- class ITEM_SORT_BY_PUB_DATE
