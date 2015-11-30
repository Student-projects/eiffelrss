note
	description: "Factory class for the different classes of the syndiction cluster."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	SYNDICATION_FACTORY

feature -- READER factory

	new_reader_from_url (a_url: STRING): FEED_FETCHER
			-- Create with `a_url' as source of feed
		require
			valid_url: a_url /= Void
		do
			create Result.make_from_url (a_url)
		ensure
			non_void_result: Result /= Void
		end

feature -- WRITER factory

	new_writer_from_feed (a_feed: FEED): FEED_WRITER
			-- Create a writer object for the feed `a_feed'
		require
			valid_feed: a_feed /= Void
		do
			create Result.make_feed (a_feed)
		ensure
			non_void_result: Result /= Void
		end

feature -- FEED_MANAGER factory

	new_feed_manager: FEED_MANAGER
			-- Create a new feed manager with default refresh period `30'
		do
			create Result.make
		ensure
			non_void_result: Result /= Void
		end

	new_feed_manager_custom (a_refresh_period: INTEGER): FEED_MANAGER
			-- Create a new feed manager with default refresh period `a_refresh_period'
		require
			default_refresh_period_positive: a_refresh_period >= 0
		do
			create Result.make_custom (a_refresh_period)
		ensure
			non_void_result: Result /= Void
		end

feature -- FEED factory

	new_feed (a_title: STRING; a_link: URL; a_description: STRING): FEED
			--  Create a feed with title, link and description
		require
			non_empty_title: a_title /= Void and then not a_title.is_empty
			non_void_link: a_link /= Void
			non_empty_description: a_description /= Void and then not a_description.is_empty
		do
			create Result.make (a_title, a_link, a_description)
		ensure
			non_void_result: Result /= Void
		end

	new_feed_from_channel (a_channel: CHANNEL): FEED
			-- Create a new feed from an existing channel
		require
			non_void_channel: a_channel /= Void
		do
			create Result.make_from_channel (a_channel)
		ensure
			non_void_result: Result /= Void
		end

feature -- CHANNEL factory

	new_channel (a_title: STRING; a_link: URL; a_description: STRING): CHANNEL
			--  Create a channel with title, link and description
		require
			non_empty_title: a_title /= Void and then not a_title.is_empty
			non_void_link: a_link /= Void
			non_empty_description: a_description /= Void and then not a_description.is_empty
		do
			create Result.make (a_title, a_link, a_description)
		ensure
			non_void_result: Result /= Void
		end

	new_channel_cloud (a_domain: STRING; a_port: INTEGER; a_path: STRING; a_register_procedure: STRING; a_protocol: STRING): CHANNEL_CLOUD
			-- Create a channel cloud with domain, port, path, register procedure and protocol
		require
			non_empty_domain: a_domain /= Void and then not a_domain.is_empty
			port_number_non_negative: a_port >= 0
			non_empty_path: a_path /= Void and then not a_path.is_empty
			non_empty_register_procedure: a_register_procedure /= Void and then not a_register_procedure.is_empty
			non_empty_protocol: a_protocol /= Void and then not a_protocol.is_empty
		do
			create Result.make (a_domain, a_port, a_path, a_register_procedure, a_protocol)
		ensure
			non_void_result: Result /= Void
		end

	new_channel_image (a_url: URL; a_title: STRING; a_link: URL): CHANNEL_IMAGE
			-- Create a channel image with URL, title, and link
		require
			non_void_url: a_url /= Void
			non_empty_title: a_title /= Void and then not a_title.is_empty
			non_void_link: a_link /= Void
		do
			create Result.make (a_url, a_title, a_link)
		ensure
			non_void_result: Result /= Void
		end

	new_channel_text_input (a_title: STRING; a_description: STRING; a_name: STRING; a_link: URL): CHANNEL_TEXT_INPUT
			-- Create a channel text input with title, description, name and link
		require
			non_empty_title: a_title /= Void and then not a_title.is_empty
			non_empty_description: a_description /= Void and then not a_description.is_empty
			non_empty_name: a_name /= Void and then not a_name.is_empty
			non_void_link: a_link /= Void
		do
			create Result.make (a_title, a_description, a_name, a_link)
		ensure
			non_void_result: Result /= Void
		end

feature -- ITEM factory

	new_item (a_channel: CHANNEL; a_title: STRING; a_link: URL; a_description: STRING): ITEM
			-- Create an item with title, link and description
		require
			non_void_channel: a_channel /= Void
			non_empty_title: a_title /= Void and then not a_title.is_empty
			non_void_link: a_link /= Void
			non_empty_description: a_description /= Void and then not a_description.is_empty
		do
			create Result.make (a_channel, a_title, a_link, a_description)
		ensure
			non_void_result: Result /= Void
		end

	new_item_with_title (a_channel: CHANNEL; a_title: STRING): ITEM
			-- Create an item with title
		require
			non_void_channel: a_channel /= Void
			non_empty_title: a_title /= Void and then not a_title.is_empty
		do
			create Result.make_title (a_channel, a_title)
		ensure
			non_void_result: Result /= Void
		end

	new_item_with_description (a_channel: CHANNEL; a_description: STRING): ITEM
			-- Create an item with description
		require
			non_void_channel: a_channel /= Void
			non_empty_description: a_description /= Void and then not a_description.is_empty
		do
			create Result.make_description (a_channel, a_description)
		ensure
			non_void_result: Result /= Void
		end

	new_item_enclosure (a_url: URL; a_length: INTEGER; a_type: STRING): ITEM_ENCLOSURE
			-- Create an item enclosure
		require
			non_void_url: a_url /= Void
			positive_length: a_length >= 0
			non_empty_type: a_type /= Void and then not a_type.is_empty
		do
			create Result.make (a_url, a_length, a_type)
		ensure
			non_void_result: Result /= Void
		end

	new_item_guid (a_guid: STRING): ITEM_GUID
			-- Create an item guid with `is_perma_link' set to False
		require
			non_empty_guid: a_guid /= Void and then not a_guid.is_empty
		do
			create Result.make (a_guid)
		ensure
			non_void_result: Result /= Void
		end

	new_item_guid_perma_link (a_guid: STRING): ITEM_GUID
			-- Create an item guid with `is_perma_link' set to True
		require
			non_empty_guid: a_guid /= Void and then not a_guid.is_empty
		do
			create Result.make_perma_link (a_guid)
		ensure
			non_void_result: Result /= Void
		end

	new_item_source (a_name: STRING; a_url: URL): ITEM_SOURCE
			-- Create an item source
		require
			non_empty_name: a_name /= Void and then not a_name.is_empty
			non_void_url: a_url /= Void
		do
			create Result.make (a_name, a_url)
		ensure
			non_void_result: Result /= Void
		end

feature -- CATEGORY factory

	new_category: CATEGORY
			-- Create a category with title `[unnamed category]')
		do
			create Result.make
		ensure
			non_void_result: Result /= Void
		end

	new_category_with_title (a_title: STRING): CATEGORY
			-- Create a category with title `a_title'
		require
			non_empty_title: a_title /= Void and then not a_title.is_empty
		do
			create Result.make_title (a_title)
		ensure
			non_void_result: Result /= Void
		end

	new_category_with_title_domain (a_title: STRING; a_domain: URL): CATEGORY
			-- Create a category with title `a_title' and domain `a_domain'
		require
			non_empty_title: a_title /= Void and then not a_title.is_empty
			non_void_domain: a_domain /= Void
		do
			create Result.make_title_domain (a_title, a_domain)
		ensure
			non_void_result: Result /= Void
		end

end -- class SYNDICATION_FACTORY
