include('shared.lua');

function ENT:Draw()
	self:DrawModel();
	AddWorldTip( self:EntIndex(), "Gun Vendor", 0.5, self:GetPos(), self  ) -- Add an example tip.
end
