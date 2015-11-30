note
	description: "Class to represent a logical line of a properties file."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	LOGICAL_LINE

inherit

	ANY
		redefine
			out
		end

create
	make

feature -- Initialization

	make (s: STRING; strip_leading_ws: BOOLEAN)
			-- Creates a new logical line and strips whitespace is `strip_leading_ws' is
			-- set to `True'
		require
			string_not_void: s /= Void
		do
			line := parse_line_to_add (s, strip_leading_ws)
		ensure
			line_not_void: line /= Void
		end

feature -- Status report

	is_continuation_line: BOOLEAN
			-- Does the line end with a backslash?

	is_comment: BOOLEAN
			-- Is the line a comment?

	is_parsable: BOOLEAN
			-- Is the line parsable into key and value?
		do
			Result := not line.is_equal ("") and not is_comment and not line.is_empty and then not (line.item (1) = '=')
		end

feature -- Element change

	append (s: STRING; strip_leading_ws: BOOLEAN)
			-- Adds `s' to `line' if `line' is a continuation line
		require
			is_continuation_line: is_continuation_line
			is_not_a_comment: not is_comment
			string_not_void: s /= Void
		do
			line := line + parse_line_to_add (s, strip_leading_ws)
		end

	append_line (l: LOGICAL_LINE; strip_leading_ws: BOOLEAN)
			-- Add `l' to `line' if `line' is a continuation line
		require
			is_continuation_line: is_continuation_line
			is_not_a_comment: not is_comment
			line_not_void: l /= Void
		do
			append (l.out, strip_leading_ws)
		end

	parse
			-- Parses `line' into key and value
		require
			line_is_parsable: is_parsable
		local
			char: CHARACTER
			i: INTEGER
			break: BOOLEAN
		do
			create key.make_empty
			create value.make_empty

				-- Extract key
			from
				i := 1
				break := False
			until
				i > line.count or break
			loop
				char := line.item (i)
				if (char = '=' or char = ':') and then line.item (i - 1) /= '\' then
					break := True
				else
					key.append (char.out)
				end
				i := i + 1
			end

				-- Remove trailing whitespace
			key.prune_all_trailing (' ')
			key.prune_all_trailing ('%T')
			key.prune_all_trailing ('%F')

				-- Extract value
			value := line.substring (i, line.count)

				-- Remove leading whitespace
			value.prune_all_leading (' ')
			value.prune_all_leading ('%T')
			value.prune_all_leading ('%F')

				-- Remove trailing whitespace
			value.prune_all_trailing (' ')
			value.prune_all_trailing ('%T')
			value.prune_all_trailing ('%F')
		ensure
			key_not_void: key /= Void
		end

feature -- Access

	key: STRING
			-- Saves the key of a logical line

	value: STRING
			-- Saves the value of a logical line

feature -- Output

	out: STRING
			-- Returns the logical line
		do
			Result := line
		end

feature {NONE} -- Implementation

	line: STRING
			-- Saves a logical line

	parse_line_to_add (s: STRING; strip_leading_ws: BOOLEAN): STRING
			-- Parses a newly added line
			-- This feature sets `is_continuation_line' and strips leading and ending
			-- whitespace
		require
			string_not_void: s /= Void
		do
			create Result.make_from_string (s)

				-- Remove leading whitespace if needed
			if strip_leading_ws then
				Result.prune_all_leading (' ')
				Result.prune_all_leading ('%T')
				Result.prune_all_leading ('%F')
			end

				-- Remove trailing whitespace
			Result.prune_all_trailing (' ')
			Result.prune_all_trailing ('%T')
			Result.prune_all_trailing ('%F')
			Result.prune_all_trailing ('%N')
			Result.prune_all_trailing ('%R')

				-- Is it a comment?
			if not Result.is_empty and then (Result.item (1) = '#' or Result.item (1) = '!') then
				is_comment := True
			else
				is_comment := False
			end

				-- Is it a continuation line?
			if not is_comment and not Result.is_empty and then Result.item (Result.count) = '\' then
				is_continuation_line := True
				Result := Result.substring (1, Result.count - 1)
			else
				is_continuation_line := False
			end
		end

end -- class LOGICAL_LINE
