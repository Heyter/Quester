local QuestGunTraining01 = {

	id = 2,
	shortName = "QuestGunTraining01",
	longName = "Gun Training",

	repeatable = true,

	data = {
		start		= 0,
		target	= 8
	},

	desc = "Quick, $n!  There are rebels here, and they want to kill me!  I need you to help fight!  Take this.",

	Accept = function( self, ply )

		ply:GiveWeapon( "weapon_pistol" );
		ply:GiveAmmo( 36, "pistol", true );

		timer.Create( "QuestGunTraining01", 30, 0, function()
			ply:CompleteQuest( self.id, Quest.QUEST_FAILED, "You took too long!");
		end );

		hook.Add( "OnNPCKilled", Quest.HookName( self.shortName, ply ), function( npc, attacker, weapon )
			local c = npc:GetClass();

			if attacker:Name() ~= ply:Name() then return false end
			if c ~= "npc_citizen" then return false end

			local progress = ply:AddQuestProgress( self.id, 1 );
			if progress >= self.data.target then
				ply:CompleteQuest( self.id, Quest.QUEST_COMPLETE );
			end
		end );
	end,

	Abandon = function( self, ply )
		hook.Remove( "OnNPCKilled", Quest.HookName( self.shortName, ply ));
		timer.Remove( "QuestGunTraining01" );
	end,

	Complete = function( self, ply )
		ply:AddMoney( 75 );
		hook.Remove( "OnNPCKilled", Quest.HookName( self.shortName, ply ));
		timer.Remove( "QuestGunTraining01" );
	end
}

Quest:RegisterQuest( QuestGunTraining01 );