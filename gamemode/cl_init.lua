include( "shared.lua" );

net.Receive( "Announce", function( length, client)     
    GAMEMODE:AddNotify( net.ReadString(), NOTIFY_GENERIC, 6 );
end )