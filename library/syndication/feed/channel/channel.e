note
	description: "Class to represent a feed channel."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 09:06:57 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 251 $"

class
	CHANNEL

inherit
	CATEGORIES
	OBSERVABLE_CHANNEL

create
	make

feature -- Initialization

	make (a_title: STRING; a_link: URL; a_description: STRING)
			--  Create a channel with title, link and description
		require
			non_empty_title: a_title /= Void and then not a_title.is_empty
			non_void_link: a_link /= Void
			non_empty_description: a_description /= Void and then not a_description.is_empty
		do
			set_title (a_title)
			set_link (a_link)
			set_description (a_description)
			initialization
		end

feature -- Access

	title: STRING
			-- Channel title

	link: URL
			-- Channel link

	description: STRING
			-- Channel description

	language: detachable STRING
			-- Channel language

	copyright: detachable STRING
			-- Channel copyright

	managing_editor: detachable STRING
			-- Channel managing editor

	web_master: detachable STRING
			-- Channel web master

	pub_date: detachable DATE_TIME
			-- Channel pulication date

	last_build_date: detachable DATE_TIME
			-- Channel last build date

	feed_generator: detachable STRING
			-- Channel feed generator

	docs: detachable URL
			-- Channel docs

	cloud: detachable CHANNEL_CLOUD
			-- Channel cloud

	ttl: INTEGER
			-- Channel time to live in minutes

	image: detachable CHANNEL_IMAGE
			-- Channel image

	text_input: detachable CHANNEL_TEXT_INPUT
			-- Channel text input

	skip_hours: CHANNEL_SKIP_HOURS
			-- Channel skip hours

	skip_days: CHANNEL_SKIP_DAYS
			-- Channel skip days

	items: SORTABLE_TWO_WAY_LIST [ITEM]
			-- Channel items

feature -- Access (RSS 0.91)

	rating: detachable STRING
			-- Channel rating

feature -- Access (RSS 1.0)

	items_toc: TWO_WAY_LIST[URL]
			-- Channel items table of content

	textinput: detachable URL
			-- Channel textinput URL

feature -- Access (metadata)

	last_added_item: detachable ITEM
			-- The last added channel item

-- [TODO]
-- feature -- Access (modules)
-- The possiblity to add and remove modules to a channel would be very nice to
-- have, but doesn't have a very high priority at the moment
--
--	modules: HASH_TABLE[MODULE_DEF, STRING]
--			-- Hashtable containing various optional modules

feature -- Setter

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

	set_language (a_language: STRING)
			-- Channel language
		require
			non_empty_language: a_language /= Void and then not a_language.is_empty
		do
			language := a_language
		ensure
			language_set: language = a_language
		end

	set_copyright (a_copyright: STRING)
			-- Channel copyright
		require
			non_empty_copyright: a_copyright /= Void and then not a_copyright.is_empty
		do
			copyright := a_copyright
		ensure
			copyright_set: copyright = a_copyright
		end

	set_managing_editor (a_managing_editor: STRING)
			-- Channel managing editor
		require
			non_empty_managing_editor: a_managing_editor /= Void and then not a_managing_editor.is_empty
		do
			managing_editor := a_managing_editor
		ensure
			managing_editor_set: managing_editor = a_managing_editor
		end

	set_web_master (a_web_master: STRING)
			-- Channel web master
		require
			non_empty_web_master: a_web_master /= Void and then not a_web_master.is_empty
		do
			web_master := a_web_master
		ensure
			web_master_set: web_master = a_web_master
		end

	set_pub_date (date: DATE_TIME)
			-- Channel pulication date
		require
			non_void_date: date /= Void
		do
			pub_date := date
		ensure
			pub_date_set: pub_date = date
		end

	set_last_build_date (date: DATE_TIME)
			-- Channel last build date
		require
			non_void_last_build_date: date /= Void
		do
			last_build_date := date
		ensure
			last_build_date_set: last_build_date = date
		end

	set_feed_generator (a_feed_generator: STRING)
			-- Channel feed generator
		require
			non_empty_feed_generator: a_feed_generator /= Void and then not a_feed_generator.is_empty
		do
			feed_generator := a_feed_generator
		ensure
			feed_generator_set: feed_generator = a_feed_generator
		end

	set_docs (url: URL)
			-- Channel docs
		require
			non_void_docs: url /= Void
		do
			docs := url
		ensure
			docs_set: docs = url
		end

	set_cloud (a_cloud: CHANNEL_CLOUD)
			-- Channel cloud
		require
			non_void_cloud: a_cloud /= Void
		do
			cloud := a_cloud
		ensure
			cloud_set: cloud = a_cloud
		end

	set_ttl (a_ttl: INTEGER)
			-- Channel time to live in minutes
		require
			ttl_period_positive: a_ttl >= 0
		do
			ttl := a_ttl
		ensure
			ttl_set: ttl = a_ttl
		end

	set_image (an_image: CHANNEL_IMAGE)
			-- Channel image
		require
			non_void_image: an_image /= Void
		do
			image := an_image
		ensure
			image_set: image = an_image
		end

	set_text_input (a_text_input: CHANNEL_TEXT_INPUT)
			-- Channel text input
		require
			non_void_text_input: a_text_input /= Void
		do
			text_input := a_text_input
			set_textinput (a_text_input.link)
		ensure
			text_input_set: text_input = a_text_input
		end

	set_skip_hours (some_skip_hours: CHANNEL_SKIP_HOURS)
			-- Channel skip hours
		require
			non_void_skip_hours: some_skip_hours /= Void
		do
			skip_hours := some_skip_hours
		ensure
			skip_hours_set: skip_hours = some_skip_hours
		end

	set_skip_days (some_skip_days: CHANNEL_SKIP_DAYS)
			-- Channel skip days		
		require
			non_void_skip_days: some_skip_days /= Void
		do
			skip_days := some_skip_days
		ensure
			skip_days_set: skip_days = some_skip_days
		end

	set_items (item_list: like items)
			-- Channel items
		require
			non_void_items: item_list /= Void
		do
			items := item_list
		ensure
			items_set: items = item_list
		end

feature -- Setter (RSS 0.91)

	set_rating (rating_value: STRING)
			-- Channel rating
		require
			non_empty_rating: rating_value /= Void and then not rating_value.is_empty
		do
			rating := rating_value
		ensure
			rating_set: rating = rating_value
		end

feature -- Setter (RSS 1.0)

	set_items_toc (item_toc_list: like items_toc)
			-- Channel items table of content	
		require
			non_void_items_toc: item_toc_list /= Void
		do
			items_toc := item_toc_list
		ensure
			items_toc_set: items_toc = item_toc_list
		end

	set_textinput (url: URL)
			-- Channel textinput URL
		require
			non_void_url: url /= Void
		do
			textinput := url
		ensure
			textinput_set: textinput = url
		end

feature -- Status

	has_language: BOOLEAN
			-- Is `language' set and non-empty?
		do
			Result := attached language as l_language and then not l_language.is_empty
		end

	has_copyright: BOOLEAN
			-- Is `copyright' set and non-empty?
		do
			Result := attached copyright as l_copyright and then not l_copyright.is_empty
		end

	has_managing_editor: BOOLEAN
			-- Is `managing_editor' set and non-empty?
		do
			Result := attached managing_editor as l_managing_editor and then not l_managing_editor.is_empty
		end

	has_web_master: BOOLEAN
			-- Is `web_master' set and non-empty?
		do
			Result := attached web_master as l_web_master and then not l_web_master.is_empty
		end

	has_pub_date: BOOLEAN
			-- Is `pub_date' set?
		do
			Result := pub_date /= Void
		end

	has_last_build_date: BOOLEAN
			-- Is `last_build_date' set?
		do
			Result := last_build_date /= Void
		end

	has_feed_generator: BOOLEAN
			-- Is `feed_generator' set and non-empty?
		do
			Result := attached feed_generator as l_feed_generator and then not l_feed_generator.is_empty
		end

	has_docs: BOOLEAN
			-- Is `docs' set?
		do
			Result := docs /= Void
		end

	has_cloud: BOOLEAN
			-- Is `cloud' set?
		do
			Result := cloud /= Void
		end

	has_ttl: BOOLEAN
			-- Is `ttl' set?
		do
			Result := ttl > 0
		end

	has_image: BOOLEAN
			-- Is `image' set?
		do
			Result := image /= Void
		end

	has_text_input: BOOLEAN
			-- Is `text_input' set?
		do
			Result := text_input /= Void
		end


	has_skip_hours: BOOLEAN
			-- Is `skip_hours' set?
		do
			Result := skip_hours.count > 0
		end

	has_skip_days: BOOLEAN
			-- Is `skip_days' set?
		do
			Result := skip_days.count > 0
		end

	has_items: BOOLEAN
			-- Is `items' set?
		do
			Result := items.count > 0
		end

feature -- Status (RSS 0.91)

	has_rating: BOOLEAN
			-- Is `rating' set and non-empty?
		do
			Result := attached rating as l_rating and then not l_rating.is_empty
		end

feature -- Status (RSS 1.0)

	has_items_toc: BOOLEAN
			-- Is `items_toc' set?
		do
			Result := items_toc.count > 0
		end

	has_textinput: BOOLEAN
			-- Is `textinput' set?
		do
			Result := textinput /= Void
		end

feature -- Status (metadata)

	has_last_added_item: BOOLEAN
			-- Is `last_added_item' set?
		do
			Result := last_added_item /= Void
		end

feature -- Basic operations

	add_skip_hour (skip_hour: INTEGER)
			-- Add a skip hour.
			-- Only 0 <= `skip_hour' <= 23 is valid
		require
			skip_hour_beetween_0_and_23: skip_hour >= 0 and skip_hour <= 23
		do
			skip_hours.extend (skip_hour)
		end

	remove_skip_hour (skip_hour: INTEGER)
			-- Remove a skip hour
		do
			skip_hours.start
			skip_hours.prune (skip_hour)
		end

	add_skip_day (skip_day: STRING)
			-- Add a skip day.
			-- `skip_day' will be added to `skip_days' with the first letter to upper
			-- and the rest to lower. For example: `mOnDaY' is added as `Monday'
		require
			valid_day: valid_day (skip_day)
		do
			skip_days.extend (skip_day)
		end

	remove_skip_day (skip_day: STRING)
			-- Remove a skip day
		do
			skip_days.start
			skip_days.prune (skip_day)
		end

	add_item (item: ITEM)
			-- Add an item.
		require
			non_void_item: item /= Void
		do
			last_added_item := item
			items.extend (item)
			notify_item_added (item)
		end

	remove_item (item: ITEM)
			-- Remove an item
		require
			non_void_item: item /= Void
		do
			items.start
			items.prune (item)
		end

feature -- Basic operations (RSS 1.0)

	add_item_toc (item_toc: URL)
			-- Add an item to the TOC	
		require
			non_void_item_toc: item_toc /= Void
		do
			items_toc.extend (item_toc)
		end

	remove_item_toc (item_toc: URL)
			-- Remove an item from the TOC
		require
			non_void_item_toc: item_toc /= Void
		do
			items_toc.start
			items_toc.prune (item_toc)
		end

feature -- Sort

	sort_items_by_title
			-- Sort items by title
		do
			items.set_order (create {ITEM_SORT_BY_TITLE[ITEM]})
			items.sort
		end

	sort_items_by_pub_date
			-- Sort items by publication date
		do
			items.set_order (create {ITEM_SORT_BY_PUB_DATE[ITEM]})
			items.sort
		end

	sort_items_by_link
			-- Sort items by link
		do
			items.set_order (create {ITEM_SORT_BY_LINK[ITEM]})
			items.sort
		end

	reverse_sort_items_by_title
			-- Reverse sort items by title
		do
			items.set_order (create {ITEM_REVERSE_SORT_BY_TITLE[ITEM]})
			items.sort
		end

	reverse_sort_items_by_pub_date
			-- Reverse sort items by publication date
		do
			items.set_order (create {ITEM_REVERSE_SORT_BY_PUB_DATE[ITEM]})
			items.sort
		end

	reverse_sort_items_by_link
			-- Reverse sort items by link
		do
			items.set_order (create {ITEM_REVERSE_SORT_BY_LINK[ITEM]})
			items.sort
		end

feature -- Debug

	to_string: STRING
			-- Returns a string representation of channel
			-- This feature is especially useful for debugging
		do
			Result := "Channel:%N========%N%N"

			Result.append ("* Title: " + title + "%N" + "* Link: " + link.location + "%N" + "* Description: " + description + "%N")

			if has_language and then attached language as l_language then
				Result.append ("* Language: " + l_language + "%N")
			end

			if has_copyright and then attached copyright as l_copyright then
				Result.append ("* Copyright: " + l_copyright + "%N")
			end

			if has_managing_editor and then attached managing_editor as l_managing_editor then
				Result.append ("* Managing Editor: " + l_managing_editor + "%N")
			end

			if has_web_master and then attached web_master as l_web_master then
				Result.append ("* Webmaster: " + l_web_master + "%N")
			end

			if has_pub_date and then attached pub_date as l_pub_date then
				Result.append ("* Publication date: " + l_pub_date.out + "%N")
			end

			if has_last_build_date and then attached last_build_date as l_last_build_date then
				Result.append ("* Last build date: " + l_last_build_date.out + "%N")
			end

			if has_feed_generator and then attached feed_generator as l_feed_generator then
				Result.append ("* Feed generator: " + l_feed_generator + "%N")
			end

			if has_docs and then attached docs as l_docs then
				Result.append ("* Documentation: " + l_docs.location + "%N")
			end

			if has_ttl and then attached ttl as l_ttl then
				Result.append ("* TTL: " + l_ttl.out + "%N")
			end

			if has_rating and then attached rating as l_rating then
				Result.append ("* Rating: " + l_rating + "%N")
			end

			if has_textinput and then attached textinput as l_textinput then
				Result.append ("* Textinput: " + l_textinput.location + "%N")
			end

			if has_cloud and then attached cloud as l_cloud then
				Result.append ("%NChannel cloud:%N--------------%N" + l_cloud.to_string)
			end

			if has_image and then attached image as l_image then
				Result.append ("%NChannel image:%N--------------%N" + l_image.to_string)
			end

			if has_text_input and then attached text_input as l_text_input then
				Result.append ("%NChannel text input:%N-------------------%N" + l_text_input.to_string)
			end

			if has_categories and then attached categories as l_categories then
				Result.append ("%NChannel categories:%N-------------------%N")
				from
					l_categories.start
				until
					l_categories.after
				loop
					Result.append ("* " + l_categories.item.to_string)
					l_categories.forth
				end
			end

			if has_items then
				Result.append ("%N")
				from
					items.start
				until
					items.after
				loop
					Result.append ("%N" + items.item.to_string + "%N")
					items.forth
				end
			end
		end

feature -- Implementation

	valid_day (day: STRING): BOOLEAN
			-- Is `day' a valid day?
		require
			non_empty_day: day /= Void and then not day.is_empty
		do
			day.to_lower

			Result := day.same_string ("monday") or
				day.same_string ("tuesday") or
				day.same_string ("wednesday") or
				day.same_string ("thursday") or
				day.same_string ("friday") or
				day.same_string ("saturday") or
				day.same_string ("sunday")
		end

feature {NONE} -- Implementation

	initialization
			-- Common initialization tasks
		do
			initialize_observers
			initialize_categories

			create items.make
			items.compare_objects

			create items_toc.make
			items_toc.compare_objects

			create skip_hours.make
			create skip_days.make
		end

invariant
	non_empty_title: title /= Void and then not title.is_empty
	non_void_link: link /= Void
	non_empty_description: description /= Void and then not description.is_empty
	non_void_items_toc: items_toc /= Void
	non_void_items: items /= Void
	non_void_skip_days: skip_days /= Void
	non_void_skip_hours: skip_hours /= Void

end -- class CHANNEL
