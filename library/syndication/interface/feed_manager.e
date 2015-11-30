indexing
	description: "Class to represent a collection of feeds."
	author: "Thomas Weibel, Martin Luder"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	FEED_MANAGER

inherit
	HASH_TABLE[FEED,STRING]
	rename
		make as make_with_size
	export {NONE}
		make_with_size
	end
	
create
	make, make_custom
	
feature -- Initialization

	make is
			-- Create a new feed manager with default refresh period `30'
		do
			make_with_size (10)
			set_default_refresh_period (30)
			compare_objects
			create urls.make
		end
		
	make_custom (a_refresh_period: INTEGER) is
			-- Create a new feed manager with default refresh period `a_refresh_period'
		require
			default_refresh_period_positive: a_refresh_period >= 0
		do
			make_with_size (10)
			set_default_refresh_period (default_refresh_period)
			compare_objects
			create urls.make
		end
		
feature -- Access

	default_refresh_period: INTEGER
			-- Default refresh period in minutes
	
	last_added_feed: FEED
			-- feed that was last added

	feed_addresses: LINKED_LIST[STRING] is
			-- Returns a sortable list representation of the feeds saved in FEED_MANAGER
		local
			url: STRING
		do
			from
				create Result.make
				urls.start
			until
				urls.off
			loop
				url ?= urls.item.item (1)
				if url /= void then
					Result.extend (url)
				end
				urls.forth
			end
			
		ensure then
			Result_exists: Result /= Void
			good_count: Result.count = count
		end

	feed_links: LINKED_LIST[STRING] is
			-- Returns a sortable list representation of the feeds saved in FEED_MANAGER
		local
			link: STRING
		do
			from
				create Result.make
				urls.start
			until
				urls.off
			loop
				link ?= urls.item.item (2)
				if link /= void then
					Result.extend (link)
				end
				urls.forth
			end
			
		ensure then
			Result_exists: Result /= Void
			good_count: Result.count = count
		end


feature -- Setter

	set_default_refresh_period (a_refresh_period: INTEGER) is
			-- Set refresh periode in minutes
		require
			default_refresh_period_positive: a_refresh_period >= 0
		do
			default_refresh_period := a_refresh_period
		ensure
			default_refresh_period_set: default_refresh_period = a_refresh_period
		end
		
feature -- Element change

	add (feed: FEED; url: STRING) is
			-- Add `feed'
		require
			non_void_feed: feed /= Void
		do
			put (feed, url)
			urls.extend ([url,feed.link.location])
			last_added_feed := feed
		ensure
			feed_added: item (url) = feed
		end
		
	add_from_url (url: STRING) is
			-- Add feed with URL `url'
		require
			non_empty_url: url /= Void and then not url.is_empty
		local
			feed: FEED
		do
			feed := (create {FEED_READER}.make_url (url)).read
			put (feed, feed.link.location)
			urls.extend ([url, feed.link.location])
			last_added_feed := feed
		end

feature -- Refresh

	refresh (url: STRING) is
			-- Refresh feed with URL `url', if the feed is outdated
		require
			non_empty_url: url /= Void and then not url.is_empty
		local
			feed: FEED
		do
			feed := item (url)
			if feed /= Void and then feed.is_outdated_default (default_refresh_period) then
				put ((create {FEED_READER}.make_url (url)).read, url)
				item (url).set_last_updated (create {DATE_TIME}.make_now)
			end
		end
		
	refresh_force (url: STRING) is
			-- Refresh feed with URL `url', even if the feed is not outdated
		require
			non_empty_url: url /= Void and then not url.is_empty
		local
			feed: FEED
		do
			feed := item (url)
			if feed /= Void then
				put ((create {FEED_READER}.make_url (url)).read, url)
				item (url).set_last_updated (create {DATE_TIME}.make_now)
			end
		end
		
	refresh_all is
			-- Refresh all feeds, if they are outdated
		local
			url: STRING
			feed: FEED
			old_iteration_position: INTEGER
		do
			old_iteration_position := iteration_position
			
			from
				start
			until
				after
			loop
				url := key_for_iteration
				feed := item_for_iteration
				
				if feed.is_outdated_default (default_refresh_period) then
					put ((create {FEED_READER}.make_url (url)).read, url)
					item (url).set_last_updated (create {DATE_TIME}.make_now)
				end
				
				forth
			end

			iteration_position := old_iteration_position
		end
		
	refresh_all_force is
			-- Refresh all feeds, even if they are not outdated
		local
			url: STRING
			feed: FEED
			old_iteration_position: INTEGER
		do
			old_iteration_position := iteration_position
			
			from
				start
			until
				after
			loop
				url := key_for_iteration
				feed := item_for_iteration
				
				put ((create {FEED_READER}.make_url (url)).read, url)
				item (url).set_last_updated (create {DATE_TIME}.make_now)
				
				forth
			end

			iteration_position := old_iteration_position
		end

feature -- Conversion

	list_representation: SORTABLE_TWO_WAY_LIST[FEED] is
			-- Returns a sortable list representation of the feeds saved in FEED_MANAGER
		local
			old_iteration_position: INTEGER
		do
			old_iteration_position := iteration_position
			
			from
				create Result.make
				start
			until
				off
			loop
				Result.extend (item_for_iteration)
				forth
			end
			
			iteration_position := old_iteration_position
		ensure then
			Result_exists: Result /= Void
			good_count: Result.count = count
		end

feature -- Conversion (sort)
		
	sorted_by_last_updated: SORTABLE_TWO_WAY_LIST[FEED] is
			-- Returns a sorted list representation of the feeds, sorted by `last_updated'
		do
			Result := list_representation
			Result.set_order (create {FEED_SORT_BY_LAST_UPDATED[FEED]})
			Result.sort
		end
		
	sorted_by_title: SORTABLE_TWO_WAY_LIST[FEED] is
			-- Returns a sorted list representation of the feeds, sorted by `title'
		do
			Result := list_representation
			Result.set_order (create {FEED_SORT_BY_TITLE[FEED]})
			Result.sort
		end
		
	sorted_by_link: SORTABLE_TWO_WAY_LIST[FEED] is
			-- Returns a sorted list representation of the feeds, sorted by `link'
		do
			Result := list_representation
			Result.set_order (create {FEED_SORT_BY_LINK[FEED]})
			Result.sort
		end
		
	sorted_by_description: SORTABLE_TWO_WAY_LIST[FEED] is
			-- Returns a sorted list representation of the feeds, sorted by `description'
		do
			Result := list_representation
			Result.set_order (create {FEED_SORT_BY_DESCRIPTION[FEED]})
			Result.sort
		end
		
	reverse_sorted_by_last_updated: SORTABLE_TWO_WAY_LIST[FEED] is
			-- Returns a sorted list representation of the feeds, reverse sorted by `last_updated'
		do
			Result := list_representation
			Result.set_order (create {FEED_REVERSE_SORT_BY_LAST_UPDATED[FEED]})
			Result.sort
		end
		
	reverse_sorted_by_title: SORTABLE_TWO_WAY_LIST[FEED] is
			-- Returns a sorted list representation of the feeds, reverse sorted by `title'
		do
			Result := list_representation
			Result.set_order (create {FEED_REVERSE_SORT_BY_TITLE[FEED]})
			Result.sort
		end
		
	reverse_sorted_by_link: SORTABLE_TWO_WAY_LIST[FEED] is
			-- Returns a sorted list representation of the feeds, reverse sorted by `link'
		do
			Result := list_representation
			Result.set_order (create {FEED_REVERSE_SORT_BY_LINK[FEED]})
			Result.sort
		end
		
	reverse_sorted_by_description: SORTABLE_TWO_WAY_LIST[FEED] is
			-- Returns a sorted list representation of the feeds, reverse sorted by `description'
		do
			Result := list_representation
			Result.set_order (create {FEED_REVERSE_SORT_BY_DESCRIPTION[FEED]})
			Result.sort
		end

feature {NONE} -- Implementation

	urls: LINKED_LIST[TUPLE[STRING,STRING]]
		
invariant
	default_refresh_period_positive: default_refresh_period >= 0
	non_void_urls: urls /= Void

end -- class FEED_MANAGER
