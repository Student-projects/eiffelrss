note
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

	make (a_channel: CHANNEL; a_title: STRING; a_link: URL; a_description: STRING)
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

	make_title (a_channel: CHANNEL; a_title: STRING)
			-- Create an item with title
		require
			non_void_channel: a_channel /= Void
			non_empty_title: a_title /= Void and then not a_title.is_empty
		do
			set_channel (a_channel)
			set_title (a_title)
			initialization
		end

	make_description (a_channel: CHANNEL; a_description: STRING)
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

	title: detachable STRING
			-- Item title

	link: detachable URL
			-- Item link

	description: detachable STRING
			-- Item description

	author: detachable STRING
			-- Item author

	comments: detachable URL
			-- Item comment URL

	enclosure: detachable ITEM_ENCLOSURE
			-- Item enclosure

	guid: detachable ITEM_GUID
			-- Item globally unique identifier (guid)

	pub_date: detachable DATE_TIME
			-- Item publication date

	source: detachable ITEM_SOURCE
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

	set_channel (a_channel: CHANNEL)
			-- Set channel to `a_channel'
		require
			non_void_channel: a_channel /= Void
		do
			channel := a_channel
		ensure
			channel_set: channel = a_channel
		end

	set_title (a_title: STRING)
			-- Set title to `a_title'
		require
			non_empty_title: a_title /= Void and then not a_title.is_empty
		do
			title := a_title
		ensure
			title_set: title = a_title
		end

	set_link (a_link: URL)
			-- Set link to `a_link'
		require
			non_void_link: a_link /= Void
		do
			link := a_link
		ensure
			link_set: link = a_link
		end

	set_description (a_description: STRING)
			-- Set description to `a_description'
		require
			non_empty_description: a_description /= Void and then not a_description.is_empty
		do
			description := a_description
		ensure
			description_set: description = a_description
		end

	set_author (an_author: STRING)
			-- Set author to `an_author'
		require
			non_empty_author: an_author /= Void and then not an_author.is_empty
		do
			author := an_author
		ensure
			author_set: author = an_author
		end

	set_comments (url: URL)
			-- Set comments to `url'
		require
			non_void_comments: url /= Void
		do
			comments := url
		ensure
			comments_set: comments = url
		end

	set_enclosure (an_enclosure: ITEM_ENCLOSURE)
			-- Set enclosure to `an_enclosure'
		require
			enclosure_non_void: an_enclosure /= Void
		do
			enclosure := an_enclosure
		ensure
			enclosure_set: enclosure = an_enclosure
		end

	set_guid (a_guid: ITEM_GUID)
			-- Set guid to `a_guid'
		require
			guid_non_void: a_guid /= Void
		do
			guid := a_guid
		ensure
			guid_set: guid = a_guid
		end

	set_pub_date (date: DATE_TIME)
			-- Set publication date to `date'
		require
			pub_date_non_void: date /= Void
		do
			pub_date := date
		ensure
			pub_date_set: pub_date = date
		end

	set_source (a_source: ITEM_SOURCE)
			-- Set source to `a_source'
		require
			source_non_void: a_source /= Void
		do
			source := a_source
		ensure
			source_set: source = a_source
		end

feature -- Setter (metadata)

	set_date_found (date: DATE_TIME)
			-- Set date_found to `date'
		require
			date_found_non_void: date /= Void
		do
			date_found := date
		ensure
			date_found_set: date_found = date
		end

	set_read (value: BOOLEAN)
			-- Set is_read to `value'
		do
			is_read := value
		ensure
			is_read_set: is_read = value
		end

feature -- Status

	has_title: BOOLEAN
			-- Is `title' set and non-empty?
		do
			Result := attached title as t and then not t.is_empty
		end

	has_link: BOOLEAN
			-- Is `link' set?
		do
			Result := link /= Void
		end

	has_description: BOOLEAN
			-- Is `description' set and non-empty?
		do
			Result := attached description as d and then not d.is_empty
		end

	has_author: BOOLEAN
			-- Is `author' set and non-empty?
		do
			Result := attached author as l_author and then not l_author.is_empty
		end

	has_comments: BOOLEAN
			-- Is `comments' set?
		do
			Result := comments /= Void
		end

	has_enclosure: BOOLEAN
			-- Is `enclosure' set?
		do
			Result := enclosure /= Void
		end

	has_guid: BOOLEAN
			-- Is `guid' set?
		do
			Result := guid /= Void
		end

	has_pub_date: BOOLEAN
			-- Is `pub_date' set?
		do
			Result := pub_date /= Void
		end

	has_source: BOOLEAN
			-- Is `source' set?
		do
			Result := source /= Void
		end

feature -- Debug

	to_string: STRING
			-- Returns a string representation of item
			-- This feature is especially useful for debugging
		do
			Result := "Item:%N=====%N%N"

			if has_title and attached title as l_title then
				Result.append ("* Title: " + l_title + "%N")
			end

			if has_link and attached link as l_link then
				Result.append ("* Link: " + l_link.location + "%N")
			end

			if has_description and attached description as l_description then
				Result.append ("* Description: " + l_description + "%N")
			end

			if has_author and attached author as l_author then
				Result.append ("* Author: " + l_author + "%N")
			end

			if has_comments and attached comments as l_comments then
				Result.append ("* Comments: " + l_comments.location + "%N")
			end

			if has_pub_date and attached pub_date as l_pub_date then
				Result.append ("* Publication date: " + l_pub_date.out + "%N")
			end

			Result.append ("* Date found: " + date_found.out + "%N")
			Result.append ("* Is read: " + is_read.out + "%N")

			if has_source and attached source as l_source then
				Result.append ("%NItem source:%N------------%N" + l_source.to_string)
			end

			if has_enclosure and attached enclosure as l_enclosure then
				Result.append ("%NItem enclosure:%N---------------%N" + l_enclosure.to_string)
			end

			if has_guid and attached guid as l_guid then
				Result.append ("%NItem GUID:%N----------%N" + l_guid.to_string)
			end

			if has_categories and attached categories as l_categories then
				Result.append ("%NItem categories:%N----------------%N")
				from
					l_categories.start
				until
					l_categories.after
				loop
					Result.append ("* " + l_categories.item.to_string)
					l_categories.forth
				end
			end
		end

feature {NONE} -- Implementation

	initialization
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
