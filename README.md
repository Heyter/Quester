# Quester
Concept Garry's Mod Gamemode

## Functions
`Boolean ply:AddQuest( questID )` Adds a quest to the player by ID.

`Void ply:CompleteQuest( questID, status, message )` Completes a quest by ID with a status and message to be shown to the user.

`Void ply:RemoveQuest( id )` Removes a quest from the player. Don’t use this, use CompleteQuest() instead.

`Integer ply:AddQuestProgress( questID, num )` Add quest progress to the player.

`Table ply:GetQuests()` Get the active quests from the player.

`Table ply:GetCompletedQuests()` Get the quests a player has completed.

`Boolean ply:HasCompletedQuest( questID )` Get if the player has completed the specified quest.

`Boolean ply:IsOnQuest( questID )` Check if the player is currently on the specified quest.

`Integer ply:AddMoney( amount )` Adds the specified amount of money to the player.

`Integer ply:RemoveMoney( amount )` Removes the specified amount of money from the player.

`Integer ply:GetMoney()` Gets the amount of money the player has.

`Void ply:GiveMoney( target, amount )` Removes money from the player and gives it to another.

`Void ply:GiveWeapon( item )` Function to give items to the player with sound effects.

`Table Quest:FindByID( id )` Find a quest by ID, returns a table.

`Void Quest:RegisterQuest( table )` Registers a new quest with the quest handler.

`String Quest.HookName( player )` Helper function to make hook names. Note that this one is . not :

`Void util.Announce( message, [player] )` Helper function to send a message to a player via hint.
If player isn't specified, it will go to everyone in the server.

## Quest Flags:
`Quest.QUEST_COMPLETE`
`Quest.QUEST_ABANDONED`
`Quest.QUEST_FAILED`
