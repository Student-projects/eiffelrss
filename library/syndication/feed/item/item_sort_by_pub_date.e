note
	description: "Sort item by publication date."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	ITEM_SORT_BY_PUB_DATE[G -> ITEM]

inherit
	ORDER_RELATION[G]

feature -- Criterion

	ordered (first, second: G): BOOLEAN
			-- Are `first' and `second' ordered (true if `first' < `second')
		local
			l_first_pub_date, l_second_pub_date: like {ITEM}.pub_date
		do
			l_first_pub_date := first.pub_date
			if l_first_pub_date = Void then
				Result := False
			else
				l_second_pub_date := second.pub_date
				if l_second_pub_date = Void then
					Result := True
				else
					Result := l_first_pub_date < l_second_pub_date
				end
			end
		end

end -- class ITEM_SORT_BY_PUB_DATE
