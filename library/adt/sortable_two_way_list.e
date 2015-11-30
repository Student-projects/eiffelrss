note
	description: "Sequential, two-way linked, sortable lists"
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	SORTABLE_TWO_WAY_LIST[G]

inherit
	TWO_WAY_LIST[G]
		redefine
			make, has
		end

	SORTABLE[G]
		undefine
			is_equal,
			copy
		end

create
	make, make_with_order_relation

create {TWO_WAY_LIST}
	make_sublist

feature -- Initialization

	make
			-- Create an empty two way list, with no order relation
		do
			Precursor {TWO_WAY_LIST}
		end

	make_with_order_relation (an_order_relation: ORDER_RELATION [G])
			-- Create an empty two way list, with `an_order_relation' as order relation
		require
			order_relation_non_void: an_order_relation /= Void
		do
			make
			set_order (an_order_relation)
		end


feature -- Access

	has (v: G): BOOLEAN
			-- Does structure include `v'?
 			-- (Reference or object equality,
			-- based on `object_comparison'.)
		local
			pos: CURSOR
		do
			if not is_empty then
				pos := cursor
				start
				search (v)
				Result := not after
				go_to (pos)
			end
		end

feature -- Sorting

	sort
			-- Sort all items.
			-- Has O(`count' * log (`count')) complexity.
			--| Uses comb-sort (BYTE February '91)
		local
			no_change: BOOLEAN
			gap: INTEGER
			left_cell, cell: like first_element
			left_cell_item, cell_item: like item
		do
			if
				attached order_relation as l_order_relation and then not is_empty and then
				attached first_element as l_first_element
			then
				from
					gap := count * 10 // 13
				until
					gap = 0
				loop
					from
						no_change := False
						go_i_th (1 + gap)
					until
						no_change
					loop
						no_change := True
						from
							left_cell := l_first_element
							cell := active	-- position of first_element + gap
						until
							cell = Void or left_cell = Void
						loop
							left_cell_item := left_cell.item
							cell_item := cell.item
							if l_order_relation.ordered (cell_item, left_cell_item) then
									-- Swap `left_cell_item' with `cell_item'
								no_change := False
								cell.put (left_cell_item)
								left_cell.put (cell_item)
							end
							left_cell := left_cell.right
							cell := cell.right
						end
					end
					gap := gap * 10 // 13
				end
			end
		end

	sorted: BOOLEAN
			-- Is the structure sorted?
		local
			c: CURSOR
			prev: like item
		do
			Result := True
			if attached order_relation as l_order_relation and then count > 1 then
				from
					c := cursor
					start
						check not off end
					prev := item
					forth
				until
					after or not Result
				loop
					Result := l_order_relation.ordered_equal (prev, item)
					prev := item
					forth
				end
				go_to (c)
			end
		end

note
	info:	"[
				This class is based on a similar class by Stephan Classen and some ideas of
				the Pylon Foundation Library (http://www.nenie.org/eiffel/pylon/)
			]"

end -- class SORTABLE_TWO_WAY_LIST
