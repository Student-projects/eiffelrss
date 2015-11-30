note
	description: "Deferred class which defines a channel observer interface."
	author: "Thomas Weibel"
	date: "$Date: 2005-01-31 00:25:27 +0100 (lun., 31 janv. 2005) $"
	revision: "$Rev: 248 $"

deferred class
	CHANNEL_OBSERVER
	
feature -- Observer

	item_added (new_item: ITEM)
			-- Is called when a new item is added to this channel
		require
			non_void_item: new_item /= Void
		deferred
		end
		
	channel_updated (channel: CHANNEL)
			-- Is called when a new channel is added
		deferred
		end

end -- class CHANNEL_OBSERVER
