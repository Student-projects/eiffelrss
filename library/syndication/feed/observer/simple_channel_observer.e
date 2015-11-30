indexing
	description: "Simple observer class which implements the interface of CHANNEL_OBSERVER"
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

class
	SIMPLE_CHANNEL_OBSERVER

inherit
	CHANNEL_OBSERVER

feature -- Access

	added_item: ITEM
			-- The newly added item
			
	updated_channel: CHANNEL
			-- The newly updated channel

feature -- Observer

	item_added (new_item: ITEM) is
			-- Is called when a new item is added to this channel
		do
			added_item := new_item
			io.put_string (added_item.to_string)
		ensure then
			added_item_set: added_item = new_item
		end
		
	channel_updated (channel: CHANNEL) is
			-- Is called when a new channel is added
		do
			updated_channel := channel
			io.put_string (updated_channel.to_string)
		ensure then
			updated_channel_set: updated_channel = channel 
		end
		

end -- class SIMPLE_CHANNEL_OBSERVER
