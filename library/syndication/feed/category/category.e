indexing
	description: "Class to represent a channel or item category."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 09:06:57 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 251 $"

class
	CATEGORY

create
	make, make_title, make_title_domain
	
feature -- Initialization

	make is
			-- Create a category with title `[unnamed category]')
		do
			make_title ("[unnamed category]")
		end
		
	make_title (a_title: STRING) is
			-- Create a category with title `a_title'
		require
			non_empty_title: a_title /= Void and then not a_title.is_empty
		do
			title := a_title
			domain := Void
		end
		
	make_title_domain (a_title: STRING; a_domain: URL) is
			-- Create a category with title `a_title' and domain `a_domain'
		require
			non_empty_title: a_title /= Void and then not a_title.is_empty
			non_void_domain: a_domain /= Void
		do
			make_title (a_title)
			set_domain (a_domain)
		end

feature -- Access

	title: STRING
			-- Category title
			
	domain: URL
			-- Category domain
			
feature -- Setter

	set_title (a_title: STRING) is
			-- Set title to to `a_title'
		require
			non_empty_title: a_title /= Void and then not a_title.is_empty
		do
			title := a_title
		ensure
			title_set: title = a_title
		end
		
	set_domain (url: URL) is
			-- Set domain to to `url'
		require
			non_void_domain: url /= Void
		do
			domain := url
		ensure
			domain_set: domain = url
		end
		
feature -- Status

	has_domain: BOOLEAN is
			-- Is `domain' set?
		do
			Result := domain /= Void
		end
		
feature -- Debug

	to_string: STRING is
			-- Returns a string representation of category
			-- This feature is especially useful for debugging
		do
			Result := title
			
			if has_domain then
				Result.append (" (" + domain.location + ")")
			end
			
			Result.append ("%N")
		end

invariant
	non_empty_title: title /= Void and then not title.is_empty

end -- class CATEGORY
