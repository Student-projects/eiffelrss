indexing
	description: "Reader object for rss 2.0"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	RSS_2_0_READER

inherit
	READER_DEF
	
feature -- Access

	get_name: STRING is
			-- Return format name
	do
		Result := "RSS 2.0"
	end

feature -- Operations

	read (a_document: XM_DOCUMENT): FEED is
			-- Parse the document
	local
		channel: XM_ELEMENT
		item_element: XM_ELEMENT
		new_item: ITEM
	do
		-- Create feed with default settings
		create Result.make ("Undefined", create {HTTP_URL}.make ("http://"), "Undefined")

		channel := a_document.root_element.element_by_name ("channel")
		
		if channel /= Void then
			-- Required fields
			Result.set_title (read_or_default_element (channel.element_by_name ("title"), "Undefined"))
			Result.set_link (create {HTTP_URL}.make (read_or_default_element (channel.element_by_name ("link"), "http://")))
			Result.set_description (read_or_default_element (channel.element_by_name ("description"), "Undefined"))

			-- Optional fields
			if (valid_element_text(channel, "lastBuildDate")) then
				Result.set_last_build_date (read_date(channel.element_by_name ("lastBuildDate").text))				
			end
			if (valid_element_text(channel, "language")) then
				Result.set_language (channel.element_by_name ("language").text)
			end
			if (valid_element_text(channel, "copyright")) then
				Result.set_copyright (channel.element_by_name ("copyright").text)
			end
			if (valid_element_text(channel, "managingEditor")) then
				Result.set_managing_editor (channel.element_by_name ("managingEditor").text)
			end
			if (valid_element_text(channel, "webMaster")) then
				Result.set_web_master (channel.element_by_name ("webMaster").text)
			end
			if (valid_element_text(channel, "pubDate")) then
				Result.set_pub_date (read_date(channel.element_by_name ("pubDate").text))
			end
			if (valid_element_text(channel, "generator")) then
				Result.set_feed_generator (channel.element_by_name ("generator").text)
			end
			if (valid_element_text(channel, "docs")) then
				Result.set_docs (create {HTTP_URL}.make (channel.element_by_name ("docs").text))			
			end
			if (valid_element_text(channel, "clouds")) then
				Result.create_cloud (read_or_default_attribute (channel.element_by_name ("cloud").attribute_by_name ("domain"), "http://"), read_or_default_attribute (channel.element_by_name ("cloud").attribute_by_name ("port"), "80").to_integer, read_or_default_attribute (channel.element_by_name ("cloud").attribute_by_name ("path"), "/"), read_or_default_attribute (channel.element_by_name ("cloud").attribute_by_name ("registerProcedure"), "-"), read_or_default_attribute (channel.element_by_name ("cloud").attribute_by_name ("protocol"), "-"))
			end		
			if (valid_element_text(channel, "ttl")) then
				Result.set_ttl (channel.element_by_name ("ttl").text.to_integer)
			end
			
			from
				channel.start
			until
				channel.after
			loop
				item_element ?= channel.item_for_iteration

				-- Category
				if item_element /= Void and then item_element.name.is_equal("category") then
					if item_element.attribute_by_name ("category") = Void then
						Result.add_category (create {CATEGORY}.make_title (item_element.text))	
					else
						Result.add_category (create {CATEGORY}.make_title_domain (item_element.text, create {HTTP_URL}.make (item_element.attribute_by_name ("category").value)))
					end
				end

			
				-- Item
				if item_element /= Void and then item_element.name.is_equal("item") then
					create new_item.make (Result, read_or_default_element (item_element.element_by_name ("title"), "Undefined"), create {HTTP_URL}.make (read_or_default_element (item_element.element_by_name ("link"), "http://")), read_or_default_element (item_element.element_by_name ("description"), "Undefined"))
					
					if (valid_element_text(item_element, "lastBuildDate")) then
						new_item.set_author (item_element.element_by_name ("author").text)
					end
					
					if (valid_element_text(item_element, "pubDate")) then
						new_item.set_pub_date (read_date (item_element.element_by_name ("pubDate").text))
					end

					Result.add_item (new_item)
				end
				channel.forth
			end
		end
	end
		

end -- class RSS_2_0_READER
