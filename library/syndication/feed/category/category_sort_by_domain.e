note
	description: "Sort category by domain."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	CATEGORY_SORT_BY_DOMAIN[G -> CATEGORY]

inherit
	ORDER_RELATION[G]

feature -- Criterion

	ordered (first, second: G): BOOLEAN
			-- Are `first' and `second' ordered (true if `first' < `second')
		local
			l_first_domain, l_second_domain: like {CATEGORY}.domain
		do
			l_first_domain := first.domain
			if l_first_domain = Void then
				Result := False
			else
				l_second_domain := second.domain
				if l_second_domain = Void then
					Result := True
				else
					Result := l_first_domain.location < l_second_domain.location
				end
			end
		end

end -- class CATEGORY_SORT_BY_DOMAIN
