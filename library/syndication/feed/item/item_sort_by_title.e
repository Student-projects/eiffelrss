note
	description: "Sort item by title."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	ITEM_SORT_BY_TITLE [G -> ITEM]

inherit
	ORDER_RELATION [G]

feature -- Criterion

	ordered (first, second: G): BOOLEAN
			-- Are `first' and `second' ordered (true if `first' < `second')
		local
			l_first_title, l_second_title: like {ITEM}.title
		do
			l_first_title := first.title
			if l_first_title = Void then
				Result := False
			else
				l_second_title := second.title
				if l_second_title = Void then
					Result := True
				else
					Result := l_first_title < l_second_title
				end
			end
		end

end -- class ITEM_SORT_BY_TITLE
