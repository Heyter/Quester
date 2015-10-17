--[[--------------------------------------------------
	Quest Library
-----------------------------------------------------]]

Quest = {
	
	-- Quest completion flags.
	QUEST_COMPLETE = 0x01,
	QUEST_ABANDONED = 0x02,
	QUEST_FAILED = 0x04,

	quests = {},
	
	-- Find a specific quest by it's ID.
	FindByID = function( self, id )
		for k, v in pairs( self.quests) do
			if tonumber( id ) == v.id then
				return( self.quests[k] );
			end
		end
	end,

	-- Register a quest for use.
	RegisterQuest = function( self, quest )
		local t = self.quests;
		if type(quest) ~= nil then
			table.insert( t, quest );
		end
	end,	
	
	-- Testing:  Show registered quests.
	ShowQuests = function( self )
		for k, v in pairs( self.quests ) do
			print( k, v.shortName );
		end
	end,
	
	-- Helper function to generate a hook name.
	HookName = function( name, ply )
		return name .. " " .. ply:UniqueID();
	end
};