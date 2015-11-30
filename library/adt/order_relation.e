note
	description: "Objects that may be sorted according to a total order relation."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class ORDER_RELATION[G]

feature -- Criterion

	ordered (first, second: G): BOOLEAN
			-- Are `first' and `second' ordered (true if `first' < `second')
		deferred
		ensure
			asymmetric: Result implies not (ordered (second, first))
		end
		
	ordered_equal (first, second: G): BOOLEAN
			-- Are `first' and `second' ordered or equal (true if `first' <= `second').
			-- This feature is implemented with `ordered'
		do
			Result := not ordered (second, first)
		ensure
			definition: Result = ((ordered (first, second)) or ordered_equal (first, second))
		end

end -- class ORDER_RELATION
