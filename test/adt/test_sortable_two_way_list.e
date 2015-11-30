indexing
	description: "Tester class for SORTABLE_TWO_WAY_LIST."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class TEST_SORTABLE_TWO_WAY_LIST

inherit
	TS_TEST_CASE

feature -- Test

	test_make is
			-- Test feature `make'.
		local
			list: SORTABLE_TWO_WAY_LIST[STRING]
		do
			create list.make
			assert ("make [1]", list /= Void)
		end
		
	test_integer is
			-- Test SORTABLE_TWO_WAY_LIST[INTEGER]
		local
			list1: SORTABLE_TWO_WAY_LIST[INTEGER]
			list2: SORTABLE_TWO_WAY_LIST[INTEGER]
		do
			create list1.make
			
			-- Ascending list
			list1.extend (-10)
			list1.extend (-42)
			list1.extend (3145)
			list1.extend (4711)
			list1.extend (23)
			list1.extend (666)
			list1.set_order (create {INTEGER_ASCENDING[INTEGER]})
			list1.sort
			
			assert ("integer [1]", list1.sorted)
			
			create list2.make
			list2.extend (-42)
			list2.extend (-10)
			list2.extend (23)
			list2.extend (666)
			list2.extend (3145)
			list2.extend (4711)
			
			assert ("integer [2]", list1.is_equal (list2))

			-- Descending list
			list1.set_order (create {INTEGER_DESCENDING[INTEGER]})
			list1.sort
			
			assert ("integer [3]", list1.sorted)
			
			create list2.make
			list2.extend (4711)
			list2.extend (3145)
			list2.extend (666)
			list2.extend (23)
			list2.extend (-10)
			list2.extend (-42)
			list2.set_order (create {INTEGER_DESCENDING[INTEGER]})
			
			assert ("integer [4]", list2.sorted)
		end
		
	test_string is
			-- Test SORTABLE_TWO_WAY_LIST[STRING]
		local
			list1: SORTABLE_TWO_WAY_LIST[STRING]
			list2: SORTABLE_TWO_WAY_LIST[STRING]
		do
			create list1.make
			
			-- Ascending list
			list1.extend ("b")
			list1.extend ("ab")
			list1.extend ("za")
			list1.extend ("haha")
			list1.extend ("ef")
			list1.extend ("asdf")
			list1.set_order (create {STRING_ASCENDING[STRING]})
			list1.sort
			
			assert ("string [1]", list1.sorted)
			
			create list2.make
			list2.extend ("ab")
			list2.extend ("asdf")
			list2.extend ("b")
			list2.extend ("ef")
			list2.extend ("haha")
			list2.extend ("za")
			list2.set_order (create {STRING_ASCENDING[STRING]})
			
			assert ("string [2]", list2.sorted)

			-- Descending list
			list1.set_order (create {STRING_DESCENDING[STRING]})
			list1.sort
			
			assert ("string [3]", list1.sorted)
			
			create list2.make
			list2.extend ("za")
			list2.extend ("haha")
			list2.extend ("ef")
			list2.extend ("b")
			list2.extend ("asdf")
			list2.extend ("ab")
			list2.set_order (create {STRING_DESCENDING[STRING]})
			
			assert ("string [4]", list2.sorted)
		end		
	
	test_address is
			-- Test SORTABLE_TWO_WAY_LIST[ADDRESS]
		local
			list1: SORTABLE_TWO_WAY_LIST[ADDRESS]
			list2: SORTABLE_TWO_WAY_LIST[ADDRESS]
			add1: ADDRESS
			add2: ADDRESS
			add3: ADDRESS
		do
			create add1.make ("Zaphod", "Betelgeuse", 12)
			create add2.make ("Ford", "Betelgeuse", 25)
			create add3.make ("Trillian", "Earth", 23)
			
			create list1.make
			
			-- Ascending list
			list1.extend (add1)
			list1.extend (add2)
			list1.extend (add3)
			list1.set_order (create {ADDRESS_BY_NAME_ASCENDING[ADDRESS]})
			list1.sort
			
			assert ("address [1]", list1.sorted)
			
			create list2.make
			list2.extend (add2)
			list2.extend (add3)
			list2.extend (add1)
			list2.set_order (create {ADDRESS_BY_NAME_ASCENDING[ADDRESS]})
			
			assert ("address [2]", list2.sorted)

			-- Descending list
			list1.set_order (create {ADDRESS_BY_NAME_DESCENDING[ADDRESS]})
			list1.sort
			
			assert ("address [3]", list1.sorted)
			
			create list2.make
			list2.extend (add1)
			list2.extend (add3)
			list2.extend (add2)
			list2.set_order (create {ADDRESS_BY_NAME_DESCENDING[ADDRESS]})
			assert ("address [4]", list2.sorted)
		end

end -- class TEST_SORTABLE_TWO_WAY_LIST
