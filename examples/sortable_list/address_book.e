indexing
	description: "Example class for sortable two way lists."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	ADDRESS_BOOK

create
	make

feature -- Initialization

	make is
			-- Creation procedure.
		do
			create address_list.make
			
			create address.make ("Zaphod", "Betelgeuse", 12)
			address_list.extend (address)
			
			create address.make ("Marvin", "Sirius", 96)
			address_list.extend (address)
			
			create address.make ("Ford", "Betelgeuse", 25)
			address_list.extend (address)
			
			create address.make ("Trillian", "Earth", 23)
			address_list.extend (address)
			
			create address.make ("Arthur", "Earth", 42)
			address_list.extend (address)
			
			create address.make ("Slartibartfast", "Magrathea", 43)
			address_list.extend (address)
			
			io.put_string ("No particular sorting:%N")
			io.put_string ("======================%N")
			address_list.do_all (agent print_address)
			
			io.put_string ("By name:%N")
			io.put_string ("========%N")
			address_list.set_order (create {SORT_BY_NAME[ADDRESS]})
			address_list.sort
			address_list.do_all (agent print_address)
			
			io.put_string ("By planet:%N")
			io.put_string ("==========%N")
			address_list.set_order (create {SORT_BY_PLANET[ADDRESS]})
			address_list.sort
			address_list.do_all (agent print_address)
			
			address_list.prune (address)
			
			io.put_string ("By phone number:%N")
			io.put_string ("================%N")
			address_list.set_order (create {SORT_BY_PHONE_NUMBER[ADDRESS]})
			address_list.sort
			address_list.do_all (agent print_address)
		end
		
feature -- Arguments

	address_list: SORTABLE_TWO_WAY_LIST[ADDRESS]
	address: ADDRESS

feature -- Output

	print_address (an_address: ADDRESS) is
			-- Prints address
		require
			address_non_void: address /= Void
		do
			io.put_string (an_address.out + "%N")
		end

end -- class ADDRESS_BOOK

