indexing
	description: "Very simple address class."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	ADDRESS
	
inherit
	ANY
		redefine
			out
		end
	
create
	make
	
feature -- Initialization

	make (a_name: STRING; a_planet: STRING; a_phone_number: INTEGER) is
			-- Create a new address with name, street, city and phone number
		require
			non_empty_name: a_name /= Void and then not a_name.is_empty
			non_empty_planet: a_planet /= Void and then not a_planet.is_empty
		do
			name := a_name
			planet := a_planet
			phone_number := a_phone_number
		ensure
			name_set: name = a_name 
			planet_set: planet = a_planet
			phone_number_set: phone_number = a_phone_number
		end
		
feature -- Arguments

	name, planet: STRING
	
	phone_number: INTEGER
		
feature -- Output

	out: STRING is
			-- Returns a string representation of an address object
		do
			Result := "- Name: " + name + "%N- Planet: " + planet + "%N- Phone number: " + phone_number.out + "%N"
		end

end -- class ADDRESS
