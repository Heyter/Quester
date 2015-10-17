if not util then return end

function util.Announce( msg, ply )
	net.Start( "Announce" );
	net.WriteString( msg );
	
	if IsValid( ply ) then
		net.Send( ply );
	else
		net.Broadcast();
	end
end