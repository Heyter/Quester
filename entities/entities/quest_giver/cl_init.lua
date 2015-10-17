include('shared.lua');

function ENT:Draw()
	self:DrawModel();
	AddWorldTip( self:EntIndex(), "Quest Giver", 0.5, self:GetPos(), self  ) -- Add an example tip.
end

function createQuestPanel(data)

local questName = data.name
local questText = data.text

	local panel = vgui.Create( "DFrame" ) -- Creates the frame itself
	panel:SetPos( 50,50 ) -- Position on the players screen
	panel:SetSize( 425, 500 ) -- Size of the frame
	panel:SetTitle( questName ) -- Title of the frame
	panel:SetVisible( true )
	panel:SetDraggable( true ) -- Draggable by mouse?
	panel:ShowCloseButton( true ) -- Show the close button?
	panel:MakePopup() -- Show the frame

		local backpanel = vgui.Create( "DPanel", panel )
		backpanel:SetPos( 15, 35 )
		backpanel:SetSize( 395, 400 )
		
			local quest_text = vgui.Create("DLabel", backpanel)
			quest_text:SetPos(5,5) // Position
			quest_text:SetColor(Color(0,0,0,255)) // Color
			quest_text:SetFont("default")
			quest_text:SetAutoStretchVertical( true )
			quest_text:SetWide(400)
			quest_text:SetText(questText) // Text
			quest_text:SetWrap(true)

				local acceptButton = vgui.Create( "DButton", panel )
				acceptButton:SetText( "Accept" )
				acceptButton:SetPos( 40, 440 )
				acceptButton:SetSize( 100, 50 )
				acceptButton.DoClick = function ()
					RunConsoleCommand( "kill" )
				end

					local denyButton = vgui.Create( "DButton", panel )
					denyButton:SetText( "Deny" )
					denyButton:SetPos( 290, 440 )
					denyButton:SetSize( 100, 50 )
					denyButton.DoClick = function ()
						RunConsoleCommand( "kill" )
					end
end

concommand.Add( "greet", createQuestPanel )