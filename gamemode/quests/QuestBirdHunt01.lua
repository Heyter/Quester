--[[
	Important functions:
	ply:GiveMoney( amount )		-- Quest rewards.
	ply:CompleteQuest( id )		-- Completes the quest cleans up most things automatically.
	ply:AbandonQuest( id )		-- Usually reserved for the Derma panel. Don't call it directly, unless the player "fails the quest", for example.
]]

local ExampleQuest01 = {

	id = 1,										-- Quest's ID.  Required.
	shortName = "QuestBirdHunt01",			-- Quest's internal name.  Required.
	longName = "Bird Hunting",				-- The quest name displayed to the user.  Required.

	repeatable = true,						-- If the quest can be repeated or not.  Required.

	-- Quest progress.  Optional.
	-- Start is the initial progress, when current reaches target,
	-- this is when the quest is complete.

	data = {
		start		= 0,
		target	= 3,
	},

	-- Quest description.  Optional, but will be required in the future.
	desc = "Hello there, $n.  I am having a problem with birds defecating on my car.  Would you help me out?  I have an appropriate tool for the job for you, and you will be compensated monetarily.  I'm needing this done immediately.",

	-- Called when the quest is added to the player.  Most of the fun stuff will happen here.  Required.
	Accept = function( self, ply )

		-- Display to the player that the quest has been accepted.  This line will
		-- likely be moved into the base quest object in the future.

		-- Give the player a weapon to do this quest.
		ply:GiveWeapon( "weapon_crossbow" );
		ply:GiveAmmo( 8, "XBowBolt", true );

		-- One minute to complete the quest.
		timer.Create( "QuestBirdHunt01", 30, 0, function()
			ply:CompleteQuest( self.id, Quest.QUEST_FAILED, "You took too long." );
		end );

		-- Add a hook for our quest.
		hook.Add( "OnNPCKilled", Quest.HookName( self.shortName, ply ), function( npc, attacker, weapon )
			local c = npc:GetClass();

			-- Check that the kill is the player's.
			if attacker:Name() ~= ply:Name() then return false end

			-- Check that the kill is a bird.
			if c ~= "npc_crow" and c ~= "npc_pigeon" and c ~= "npc_seagull" then return false end

			-- Add progress.
			local progress = ply:AddQuestProgress( self.id, 1 );
			if progress >= self.data.target then
				ply:CompleteQuest( self.id, Quest.QUEST_COMPLETE );
			end
		end );
	end,

	-- Reserved for Derma use, or if the player "fails the quest."  Required.
	Abandon = function( self, ply )
		ply:StripWeapon("weapon_crossbow");
		timer.Remove( "QuestBirdHunt01" );
		hook.Remove( "OnNPCKilled", Quest.HookName( self.shortName, ply ) );
	end,

	-- Called when the quest is complete.  Required.
	Complete = function( self, ply )

		-- Sweet rewards!
		ply:AddMoney( 25 );
		ply:StripWeapon("weapon_crossbow");
		
		-- IMPORTANT: Always be sure to clean up your quest when it's completed!
		-- Most things are taken care of by ply:CompleteQuest(), but anything that is optional, such as quest progress,
		-- timers, and any hooks you have created should be cleaned up.

		timer.Remove( "QuestBirdHunt01" );
		hook.Remove( "OnNPCKilled", Quest.HookName( self.shortName, ply ) );
	end
}

-- When the quest is created, register it with the quest handler.  Required.
Quest:RegisterQuest( ExampleQuest01 );