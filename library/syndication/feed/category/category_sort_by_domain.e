indexing
	description: "Sort category by domain."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	CATEGORY_SORT_BY_DOMAIN[G -> CATEGORY]
	
inherit
	ORDER_RELATION[G]

feature -- Criterion

	ordered (first, second: G): BOOLEAN is
			-- Are `first' and `second' ordered (true if `first' < `second')
		do
			if first.domain = Void then
				Result := False
			elseif second.domain = Void then
				Result := True
			else
				Result := first.domain.location < second.domain.location
			end
		end

end -- class CATEGORY_SORT_BY_DOMAIN
