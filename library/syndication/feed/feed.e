indexing
	description: "Class to represent a feed. Provides an easy to use interface to channel, item and category."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 09:06:57 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 251 $"

class
	FEED
	
inherit
	CHANNEL
	redefine
		to_string
	end
	
create
	make, make_from_channel
	
feature -- Initialization
		
	make_from_channel (a_channel: CHANNEL) is
			-- Create a new feed from an existing channel
		require
			non_void_channel: a_channel /= Void
		do
			set_channel (a_channel)
		end
		
feature -- Access

	last_updated: DATE_TIME
			-- Time the channel was last updated
			
	refresh_period: INTEGER
			-- Refresh period in minutes
			
feature -- Setter

	set_channel (a_channel: CHANNEL) is
			-- Set channel
		require
			non_void_channel: a_channel /= Void
		do
			initialization
			set_title (a_channel.title)
			set_link (a_channel.link)
			set_description (a_channel.description)
			set_items (a_channel.items)
			set_categories (a_channel.categories)
			set_ttl (a_channel.ttl)
			set_skip_hours (a_channel.skip_hours)
			set_skip_days (a_channel.skip_days)
			set_items_toc (a_channel.items_toc)
			
			if a_channel.has_language then
				set_language (a_channel.language)
			end

			if a_channel.has_copyright then
				set_copyright (a_channel.copyright)
			end
			
			if a_channel.has_managing_editor then
				set_managing_editor (a_channel.managing_editor)
			end
			
			if a_channel.has_web_master then
				set_web_master (a_channel.web_master)
			end
			
			if a_channel.has_pub_date then
				set_pub_date (a_channel.pub_date)
			end
			
			if a_channel.has_last_build_date then
				set_last_build_date (a_channel.last_build_date)
			end
			
			if a_channel.has_feed_generator then
				set_feed_generator (a_channel.feed_generator)
			end
			
			if a_channel.has_docs then
				set_docs (a_channel.docs)
			end
			
			if a_channel.has_cloud then
				set_cloud (a_channel.cloud)
			end

			if a_channel.has_image then
				set_image (a_channel.image)
			end
			
			if a_channel.has_text_input then
				set_text_input (a_channel.text_input)
			end
			
			if a_channel.has_rating then
				set_rating (a_channel.rating)
			end			

			if a_channel.has_textinput then
				set_textinput (a_channel.textinput)
			end	
		end
		
	set_refresh_period (a_refresh_period: INTEGER) is
			-- Set refresh periode in minutes
		require
			refresh_period_positive: a_refresh_period >= 0
		do
			refresh_period := a_refresh_period
		ensure
			refresh_period_set: refresh_period = a_refresh_period
		end

	set_last_updated (date: DATE_TIME) is
			-- Set time this channel was last updated
		require
			non_empty_date: date /= Void
		do
			last_updated := date
		ensure
			last_updated_set: last_updated = date
		end
		
feature -- Status

	has_refresh_period: BOOLEAN is
			-- Is `refresh_period' set?
		do
			Result := refresh_period > 0
		end
		
	has_last_updated: BOOLEAN is
			-- Is `last_updated' set?
		do
			Result := last_updated /= Void
		end
		
	is_outdated: BOOLEAN is
			-- Is the feed outdated?
		local
			date_to_update: DATE_TIME
			date_now: DATE_TIME
		do
			Result := False

			-- If neither `refresh_period' nor `ttl' are set, a feed is never outdated
			if not has_refresh_period and not has_ttl then
				Result := False
				
			-- If `last_updated' is set, we have to calculate the time since the last refesh and compare it
			-- either to `refresh_period' (higher precedence) or `ttl'
			elseif has_last_updated then
				create date_to_update.make_by_date_time (last_updated.date, last_updated.time)
				create date_now.make_now
				
				-- `refresh_period' has higher precedence than `ttl'
				if has_refresh_period then
					date_to_update.minute_add (refresh_period)
					Result := date_to_update < date_now
				elseif has_ttl then
					date_to_update.minute_add (ttl)
					Result := date_to_update < date_now
					
				-- If neither `refresh_period' nor `ttl' are set, the feed is outdated
				else
					Result := True
				end
			
			-- Feed is outdated
			else
				Result := True
			end
		end
		
	is_outdated_default (default_refresh_period: INTEGER) : BOOLEAN is
			-- Is the feed outdated? 
			-- Use either `refresh_period' or `default_refresh_period' to determine
			-- whether the feed is outdated.
		require
			default_refresh_period_positive: default_refresh_period >= 0
		local
			original_refresh_period: INTEGER
		do
			Result := False
			
			if not has_refresh_period then
				original_refresh_period := refresh_period
				set_refresh_period (default_refresh_period)
				Result := is_outdated
				set_refresh_period (original_refresh_period)
			else
				Result := is_outdated
			end
		end

feature -- Basic operations

	create_cloud (a_domain: STRING; a_port: INTEGER; a_path: STRING; a_register_procedure: STRING; a_protocol: STRING) is
			-- Create and add a cloud
		require
			non_empty_domain: a_domain /= Void and then not a_domain.is_empty
			port_number_non_negative: a_port >= 0
			non_empty_path: a_path /= Void and then not a_path.is_empty
			non_empty_register_procedure: a_register_procedure /= Void and then not a_register_procedure.is_empty
			non_empty_protocol: a_protocol /= Void and then not a_protocol.is_empty
		do
			set_cloud (create {CHANNEL_CLOUD}.make (a_domain, a_port, a_path, a_register_procedure, a_protocol))
		end
		
	create_image (a_url: URL; a_title: STRING; a_link: URL) is
			-- Create and add an image with URL, title, and link
		require
			non_void_url: a_url /= Void
			non_empty_title: a_title /= Void and then not a_title.is_empty
			non_void_link: a_link /= Void
		do
			set_image (create {CHANNEL_IMAGE}.make (a_url, a_title, a_link))
		end
		
	create_text_input (a_title: STRING; a_description: STRING; a_name: STRING; a_link: URL) is
			-- Create and add a text input with URL, title, and link
		require
			non_empty_title: a_title /= Void and then not a_title.is_empty
			non_empty_description: a_description /= Void and then not a_description.is_empty
			non_empty_name: a_name /= Void and then not a_name.is_empty
			non_void_link: a_link /= Void
		do
			set_text_input (create {CHANNEL_TEXT_INPUT}.make (a_title, a_description, a_name, a_link))
		end
		
	new_item (a_title: STRING; a_link: URL; a_description: STRING) is
			-- Create an item with title, link and description
		require
			non_empty_title: a_title /= Void and then not a_title.is_empty
			non_void_link: a_link /= Void
			non_empty_description: a_description /= Void and then not a_description.is_empty
		do
			add_item (create {ITEM}.make (Current, a_title, a_link, a_description))
		end
		
feature -- Debug

	to_string: STRING is
			-- Returns a string representation of feed
			-- This feature is especially useful for debugging
		do
			Result := "Feed:%N=====%N%N"

			if has_last_updated then
				Result.append ("* Last updated: " + last_updated.out + "%N")
			end
			
			if has_refresh_period then
				Result.append ("* Refresh period (minutes): " + refresh_period.out + "%N")
			end
			
			Result.append ("* Is outdated: " + is_outdated.out + "%N%N%N")
			
			Result.append (Precursor {CHANNEL})
		end

end -- class FEED
