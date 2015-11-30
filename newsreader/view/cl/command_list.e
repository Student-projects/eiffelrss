indexing
	description: "Objects that contain several commands in a hash table"
	author: "Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	COMMAND_LIST

inherit
	HASH_TABLE[PROCEDURE [ANY, TUPLE],STRING]
	
create
	make

end -- class COMMAND_LIST
