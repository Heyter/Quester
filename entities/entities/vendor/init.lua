AddCSLuaFile( "cl_init.lua" );
AddCSLuaFile( "shared.lua" );

include('shared.lua');

function ENT:Initialize()
	self:SetModel( "models/Items/ammocrate_ar2.mdl" );
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
	if not ply:HasCompletedQuest( 2 ) then
		util.Announce( "You haven't completed the required quest to use this.", ply );
		return false;
	end
	
	if ply:GetMoney() >= 100 then
		util.Announce( "Buying pistol ammo for $100.", ply );
		ply:GiveAmmo( 36, "Pistol" );
		ply:RemoveMoney( 100 );
	else
		util.Announce( "You can't afford that." );
	end
end
