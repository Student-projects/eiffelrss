note
	description: "Reader object for rss 2.0"
	author: "Michael Käser"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Revision: 248 $"

class
	RSS_2_0_READER

inherit

	READER_DEF

feature -- Access

	name: STRING
			-- Return format name
		do
			Result := "RSS 2.0"
		end

feature -- Operations

	read (a_document: XML_DOCUMENT): FEED
			-- Parse the document
		local
			channel: detachable XML_ELEMENT
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
				if
					valid_element_text (channel, "lastBuildDate") and then
					attached channel.element_by_name ("lastBuildDate") as l_lastbuilddate and then
					attached l_lastbuilddate.text as l_lastbuilddate_text
				then
					Result.set_last_build_date (read_date (l_lastbuilddate_text))
				end

				if valid_element_text (channel, "language") and then
					attached channel.element_by_name ("language") as l_language and then
					attached l_language.text as l_language_text
				then
					Result.set_language (l_language_text)
				end

				if valid_element_text (channel, "copyright") and then
					attached channel.element_by_name ("copyright") as l_copyright and then
					attached l_copyright.text as l_copyright_text
				then
					Result.set_copyright (l_copyright_text)
				end

				if valid_element_text (channel, "managingEditor") and then
					attached channel.element_by_name ("managingEditor") as l_managingeditor and then
					attached l_managingeditor.text as l_managingeditor_text
				then
					Result.set_managing_editor (l_managingeditor_text)
				end

				if valid_element_text (channel, "webMaster") and then
					attached channel.element_by_name ("webMaster") as l_webmaster and then
					attached l_webmaster.text as l_webmaster_text
				then
					Result.set_web_master (l_webmaster_text)
				end

				if valid_element_text (channel, "pubDate") and then
					attached channel.element_by_name ("pubDate") as l_pubdate and then
					attached l_pubdate.text as l_pubdate_text
				then
					Result.set_pub_date (read_date (l_pubdate_text))
				end

				if valid_element_text (channel, "generator") and then
					attached channel.element_by_name ("generator") as l_generator and then
					attached l_generator.text as l_generator_text
				then
					Result.set_feed_generator (l_generator_text)
				end

				if valid_element_text (channel, "docs") and then
					attached channel.element_by_name ("docs") as l_docs and then
					attached l_docs.text as l_docs_text
				then
					Result.set_docs (create {HTTP_URL}.make (l_docs_text))
				end
				if valid_element_text (channel, "clouds") and then attached channel.element_by_name ("cloud") as l_cloud then
					Result.create_cloud (
								read_or_default_attribute (l_cloud.attribute_by_name ("domain"), "http://"),
								read_or_default_attribute (l_cloud.attribute_by_name ("port"), "80").to_integer,
								read_or_default_attribute (l_cloud.attribute_by_name ("path"), "/"),
								read_or_default_attribute (l_cloud.attribute_by_name ("registerProcedure"), "-"),
								read_or_default_attribute (l_cloud.attribute_by_name ("protocol"), "-")
							)
				end
				if
					valid_element_text (channel, "ttl") and then
					attached channel.element_by_name ("ttl") as l_ttl and then
					attached l_ttl.text as l_ttl_text
				then
					Result.set_ttl (l_ttl_text.to_integer)
				end
				from
					channel.start
				until
					channel.after
				loop
						-- Category
					if attached {XML_ELEMENT} channel.item_for_iteration as l_item_element then
						if attached l_item_element.text as l_item_element_text then
							if l_item_element.name.same_string ("category") then
								if attached l_item_element.attribute_by_name ("category") as l_category then
									Result.add_category (create {CATEGORY}.make_title_domain (l_item_element_text, create {HTTP_URL}.make (l_category.value)))
								else
									Result.add_category (create {CATEGORY}.make_title (l_item_element_text))
								end
							end
						end

						-- Item
						if l_item_element.name.same_string ("item") then
							create new_item.make (Result,
										read_or_default_element (l_item_element.element_by_name ("title"), "Undefined"),
										create {HTTP_URL}.make (read_or_default_element (l_item_element.element_by_name ("link"), "http://")),
										read_or_default_element (l_item_element.element_by_name ("description"), "Undefined")
									)
							if
								valid_element_text (l_item_element, "lastBuildDate") and then
								attached l_item_element.element_by_name ("author") as l_author and then
								attached l_author.text as l_author_text
							then
								new_item.set_author (l_author_text)
							end
							if
								valid_element_text (l_item_element, "pubDate") and then
								attached l_item_element.element_by_name ("pubDate") as l_pubdate and then
								attached l_pubdate.text as l_pubdate_text
							then
								new_item.set_pub_date (read_date (l_pubdate_text))
							end
							Result.add_item (new_item)
						end
					end
					channel.forth
				end
			end
		end

end -- class RSS_2_0_READER
