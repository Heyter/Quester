AddCSLuaFile( "shared.lua" );
AddCSLuaFile( "cl_init.lua" );

include( "util.lua" );
include( "shared.lua" );
include( "player.lua" );
include( "quest.lua" );

util.AddNetworkString( "Announce" );

function GM:LoadQuests( )
	local quests = { "QuestBirdHunt01", "QuestGunTraining01" };

	for k, v in pairs( quests ) do
		include( "quests/" .. v .. ".lua" );
	end
end

GM:LoadQuests();

function GM:PlayerLoadout( ply )
	local equipment = { "weapon_physcannon", "weapon_physgun", "gmod_tool", "gmod_camera", "weapon_fists" };
	ply:StripWeapons();
	for i = 1, table.getn( equipment ) do
		ply:Give( equipment[i] );
	end
end

--[[--------------------------------------------------
    Hooks.
-----------------------------------------------------]]

hook.Add( "PlayerInitialSpawn", "load", function( ply )
	ply:SetNWString( "quests", '[]' );
	ply:SetNWString( "complete", '[]' );
end );

hook.Add( "PlayerDisconnected", "Save", function( ply )

end );

hook.Add( "PlayerSpawn", "spawn", function( ply )

end );

hook.Add( "OnNPCKilled", "NPCKilled", function( npc, ply, weap )
	if ply:IsPlayer() then
		ply:AddMoney( math.floor( math.random( 1, 6 )));
	end
end );

--[[--------------------------------------------------
    Console Commands.
-----------------------------------------------------]]

concommand.Add( "AddQuest", function( ply, cmd, args )
	ply:AddQuest( tonumber(args[1]) );
end );

concommand.Add( "List", function( ply )
	local q = ply:GetQuests();
	for k, v in pairs( q ) do
		print( k, v.progress );
	end
end );

concommand.Add( "Reset", function( ply )
	ply:SetNWString( "quests", '[]' );
	ply:SetNWString( "complete", '[]' );
end );