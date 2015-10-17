local Barebones = {

	id = 9999,
	shortName = "",
	longName = "",
	repeatable = false,
	
	desc = "",

	Accept = function( self, ply )
	end,

	Abandon = function( self, ply )
	end,

	Complete = function( self, ply )
	end
}

Quest:RegisterQuest( Barebones );