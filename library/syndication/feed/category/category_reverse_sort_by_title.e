indexing
	description: "Reverse sort category by title."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	CATEGORY_REVERSE_SORT_BY_TITLE[G -> CATEGORY]
	
inherit
	ORDER_RELATION[G]

feature -- Criterion

	ordered (first, second: G): BOOLEAN is
			-- Are `first' and `second' ordered (true if `first' > `second')
		require else
			first_non_void: first /= Void
			second_non_void: second /= Void
		do
			Result := first.title > second.title
		end

end -- class CATEGORY_REVERSE_SORT_BY_TITLE
