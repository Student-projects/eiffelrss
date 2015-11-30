indexing
	description: "Class to represent a feed item."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 09:06:57 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 251 $"

class
	ITEM
	
inherit
	CATEGORIES
	
create
	make, make_title, make_description
	
feature -- Initialization

	make (a_channel: CHANNEL; a_title: STRING; a_link: URL; a_description: STRING) is
			-- Create an item with title, link and description
		require
			non_void_channel: a_channel /= Void
			non_empty_title: a_title /= Void and then not a_title.is_empty
			non_void_link: a_link /= Void
			non_empty_description: a_description /= Void and then not a_description.is_empty
		do
			set_channel (a_channel)
			set_title (a_title)
			set_link (a_link)
			set_description (a_description)
			initialization
		end
		
	make_title (a_channel: CHANNEL; a_title: STRING) is
			-- Create an item with title
		require
			non_void_channel: a_channel /= Void
			non_empty_title: a_title /= Void and then not a_title.is_empty
		do
			set_channel (a_channel)
			set_title (a_title)
			initialization
		end
		
	make_description (a_channel: CHANNEL; a_description: STRING) is
			-- Create an item with description
		require
			non_void_channel: a_channel /= Void
			non_empty_description: a_description /= Void and then not a_description.is_empty
		do
			set_channel (a_channel)
			set_description (a_description)
			initialization
		end

feature -- Access

	channel: CHANNEL
			-- Backlink to the corresponding channel

	title: STRING
			-- Item title
	
	link: URL
			-- Item link
			
	description: STRING
			-- Item description
			
	author: STRING
			-- Item author
			
	comments: URL
			-- Item comment URL
			
	enclosure: ITEM_ENCLOSURE
			-- Item enclosure
			
	guid: ITEM_GUID
			-- Item globally unique identifier (guid)
			
	pub_date: DATE_TIME
			-- Item publication date
	
	source: ITEM_SOURCE
			-- Item source

feature -- Access (metadata)

	date_found: DATE_TIME
			-- Item date found
	
	is_read: BOOLEAN
			-- Is the item read?

-- [TODO]
-- feature -- Access (modules)
-- The possiblity to add and remove modules to an item would be very nice to 
-- have, but doesn't have a very high priority at the moment
--
--	modules: HASH_TABLE[MODULE_DEF, STRING]
--			-- Hashtable containing various optional modules

feature -- Setter

	set_channel (a_channel: CHANNEL) is
			-- Set channel to `a_channel'
		require
			non_void_channel: a_channel /= Void
		do
			channel := a_channel
		ensure
			channel_set: channel = a_channel
		end

	set_title (a_title: STRING) is
			-- Set title to `a_title'
		require
			non_empty_title: a_title /= Void and then not a_title.is_empty
		do
			title := a_title
		ensure
			title_set: title = a_title
		end
		
	set_link (a_link: URL) is
			-- Set link to `a_link'
		require
			non_void_link: a_link /= Void
		do
			link := a_link
		ensure
			link_set: link = a_link
		end
		
	set_description (a_description: STRING) is
			-- Set description to `a_description'
		require
			non_empty_description: a_description /= Void and then not a_description.is_empty
		do
			description := a_description
		ensure
			description_set: description = a_description
		end
		
	set_author (an_author: STRING) is
			-- Set author to `an_author'
		require
			non_empty_author: an_author /= Void and then not an_author.is_empty
		do
			author := an_author
		ensure
			author_set: author = an_author
		end
		
	set_comments (url: URL) is
			-- Set comments to `url'
		require
			non_void_comments: url /= Void
		do
			comments := url
		ensure
			comments_set: comments = url
		end
		
	set_enclosure (an_enclosure: ITEM_ENCLOSURE) is
			-- Set enclosure to `an_enclosure'
		require
			enclosure_non_void: an_enclosure /= Void
		do
			enclosure := an_enclosure
		ensure
			enclosure_set: enclosure = an_enclosure
		end
		
	set_guid (a_guid: ITEM_GUID) is
			-- Set guid to `a_guid'
		require
			guid_non_void: a_guid /= Void
		do
			guid := a_guid
		ensure
			guid_set: guid = a_guid
		end
		
	set_pub_date (date: DATE_TIME) is
			-- Set publication date to `date'
		require
			pub_date_non_void: date /= Void
		do
			pub_date := date
		ensure
			pub_date_set: pub_date = date
		end
		
	set_source (a_source: ITEM_SOURCE) is
			-- Set source to `a_source'
		require
			source_non_void: a_source /= Void
		do
			source := a_source
		ensure
			source_set: source = a_source
		end
		
feature -- Setter (metadata)

	set_date_found (date: DATE_TIME) is
			-- Set date_found to `date'
		require
			date_found_non_void: date /= Void
		do
			date_found := date
		ensure
			date_found_set: date_found = date
		end
		
	set_read (value: BOOLEAN) is
			-- Set is_read to `value'
		do
			is_read := value
		ensure
			is_read_set: is_read = value
		end
		
feature -- Status

	has_title: BOOLEAN is
			-- Is `title' set and non-empty?
		do
			Result := title /= Void and then not title.is_empty
		end
		
	has_link: BOOLEAN is
			-- Is `link' set?
		do
			Result := link /= Void
		end
		
	has_description: BOOLEAN is
			-- Is `description' set and non-empty?
		do
			Result := description /= Void and then not description.is_empty
		end
		
	has_author: BOOLEAN is
			-- Is `author' set and non-empty?
		do
			Result := author /= Void and then not author.is_empty
		end
		
	has_comments: BOOLEAN is
			-- Is `comments' set?
		do
			Result := comments /= Void
		end
		
	has_enclosure: BOOLEAN is
			-- Is `enclosure' set?
		do
			Result := enclosure /= Void
		end
		
	has_guid: BOOLEAN is
			-- Is `guid' set?
		do
			Result := guid /= Void
		end
		
	has_pub_date: BOOLEAN is
			-- Is `pub_date' set?
		do
			Result := pub_date /= Void
		end
		
	has_source: BOOLEAN is
			-- Is `source' set?
		do
			Result := source /= Void
		end

feature -- Debug

	to_string: STRING is
			-- Returns a string representation of item
			-- This feature is especially useful for debugging
		do
			Result := "Item:%N=====%N%N"		
		
			if has_title then
				Result.append ("* Title: " + title + "%N")
			end
			
			if has_link then
				Result.append ("* Link: " + link.location + "%N")
			end
			
			if has_description then
				Result.append ("* Description: " + description + "%N")
			end
			
			if has_author then
				Result.append ("* Author: " + author + "%N")
			end
			
			if has_comments then
				Result.append ("* Comments: " + comments.location + "%N")
			end
			
			if has_pub_date then
				Result.append ("* Publication date: " + pub_date.out + "%N")
			end
			
			Result.append ("* Date found: " + date_found.out + "%N")
			Result.append ("* Is read: " + is_read.out + "%N")
			
			if has_source then
				Result.append ("%NItem source:%N------------%N" + source.to_string)
			end

			if has_enclosure then
				Result.append ("%NItem enclosure:%N---------------%N" + enclosure.to_string)
			end
			
			if has_guid then
				Result.append ("%NItem GUID:%N----------%N" + guid.to_string)
			end
			
			if has_categories then
				Result.append ("%NItem categories:%N----------------%N")
				from
					categories.start
				until
					categories.after
				loop
					Result.append ("* " + categories.item.to_string)
					categories.forth
				end
			end
		end
		
feature {NONE} -- Implementation

	initialization is
			-- Common initialization tasks
		do
			initialize_categories
			create date_found.make_now
			set_read (False)
		end

invariant
	non_void_channel: channel /= Void
	date_found_non_void: date_found /= Void

end -- class ITEM
