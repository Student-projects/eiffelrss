note
	description: "Reverse sort item by link."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	ITEM_REVERSE_SORT_BY_LINK [G -> ITEM]

inherit
	ORDER_RELATION [G]

feature -- Criterion

	ordered (first, second: G): BOOLEAN
			-- Are `first' and `second' ordered (true if `first' > `second')
		local
			l_first_link: like {ITEM}.link
			l_second_link: like {ITEM}.link
		do
			l_first_link := first.link
			if l_first_link = Void then
				Result := False
			else
				l_second_link := second.link
				if l_second_link = Void then
					Result := True
				else
					Result := l_first_link.location > l_second_link.location
				end
			end
		end

end -- class ITEM_REVERSE_SORT_BY_LINK
