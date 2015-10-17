AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );

include('shared.lua');

function ENT:Initialize()
	self:SetModel( "models/props_combine/breenbust.mdl" );
	self:PhysicsInit( SOLID_VPHYSICS );
	self:SetMoveType( MOVETYPE_VPHYSICS );
	self:SetSolid(  SOLID_VPHYSICS );
	self:SetUseType( SIMPLE_USE );

    local phys = self:GetPhysicsObject()
	if ( phys:IsValid() ) then
		phys:Wake();
	end
end

function ENT:Use( ply, caller )
	local quests = { 1, 2  };
	for i = 1, table.getn( quests ) do
		if not ply:HasCompletedQuest( i ) then
			ply:AddQuest( i );
			return;
		end
	end
	util.Announce( "There are no available quests.", ply );
end
