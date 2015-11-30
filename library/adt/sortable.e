indexing
	description: "ADT which can be sorted."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class SORTABLE[G]

inherit
	CONTAINER[G]

feature -- Order relation

	has_order: BOOLEAN is
			-- Is an order relation defined?
		do
			Result := order_relation /= Void
		end
		
	set_order (an_order_relation: ORDER_RELATION[G]) is
			-- Set the order relation.
		require
			order_relation_non_void: an_order_relation /= Void
		do
			order_relation := an_order_relation
		ensure
			order_relation_set: order_relation = an_order_relation
		end
		
feature -- Sorting

	sort is
			-- Sort all items.
		require
			has_order: has_order
		deferred
		ensure
			sorted: sorted
		end
		
	sorted: BOOLEAN is
			-- Is the structure sorted?
		require
			has_order: has_order
		deferred
		ensure
			empty_structure_is_sorted: is_empty implies Result
		end
			
feature {NONE} -- Implementation

	order_relation: ORDER_RELATION[G]

end -- class SORTABLE
