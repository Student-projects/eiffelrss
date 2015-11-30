note
	description: "Writer object for RSS 2.0"
	author: "Michael Käser"

class
	RSS_2_0_WRITER

inherit
	WRITER_DEF

feature -- Access

	name: STRING
			-- Return format name
	do
		Result := "RSS 2.0"
	end

	write (a_feed: FEED): XML_DOCUMENT
			-- Export `a_feed' into an xml document
	local
		item: XML_ELEMENT
		channel: XML_ELEMENT
		namespace: XML_NAMESPACE
	do
		create namespace.make_default
		create Result.make_with_root_named ("rss", namespace)
		Result.root_element.add_unqualified_attribute ("version", "2.0")

		create channel.make (Result.root_element, "channel", namespace)
		Result.root_element.put_last (channel)

		add_to_element (channel, "title", a_feed.title, namespace)
		add_to_element (channel, "description", a_feed.description, namespace)
		add_to_element (channel, "link", a_feed.link.location, namespace)

		from
			a_feed.items.start
		until
			a_feed.items.after
		loop
			create item.make (Result.root_element, "item", namespace)
			Result.root_element.put_last (item)

			if attached a_feed.items.item as l_feed_item then
				add_to_element (item, "title", l_feed_item.title, namespace)
				add_to_element (item, "description", l_feed_item.description, namespace)
				if attached l_feed_item.link as l_item_link then
					add_to_element (item, "link", l_item_link.location, namespace)
				end
			else
				check item_attached: False end
			end

			a_feed.items.forth
		end
	end

end -- class RSS_2_0_WRITER
