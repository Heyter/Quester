local ply = FindMetaTable( "Player" );

--[[--------------------------------------------------
    Questing Functions
-----------------------------------------------------]]

-- Add a quest to the player.
function ply:AddQuest( id )
	local quest = Quest:FindByID( id );
	local quests = util.JSONToTable( self:GetNWString( "quests" ));
	local complete = self:GetCompletedQuests();

	-- Check that we aren't on the quest already or have already completed it.
	-- Do we even have or have completed any quests?  Save us some time.
	if next( quests ) ~= nil then
		for k, v in pairs( quests ) do
			if v.id == id  then
				util.Announce( "You are already on this quest.", self );
				return false;
			end
		end
	end
	if next( complete ) ~= nil then
		for k, v in pairs( complete ) do
			if v == id and quest.repeatable == false then
				util.Announce( "You have already completed this quests", self );
				return false;
			end
		end
	end

	-- Add the quest to the player.
	table.insert( quests, { id = quest.id, progress = 0 });

	quest:Accept( self );
	util.Announce( string.format( "Quest accepted: %s.", quest.longName ));

	self:SetNWString( "quests", util.TableToJSON( quests ));
	return true;
end

-- End a quest.
function ply:CompleteQuest( id, status, msg )
	local quest = Quest:FindByID( id );

	-- The quest was sent as completed.
	if status == Quest.QUEST_COMPLETE then
		util.Announce( string.format( "You have completed %s!", quest.longName), self );
		quest:Complete( self );

		local quests = util.JSONToTable(self:GetNWString( "complete" ));
		table.insert( quests, id );

		self:SetNWString( "complete", util.TableToJSON( quests ));

	-- The quest was sent as failed.
	elseif status == Quest.QUEST_FAILED then
		util.Announce( string.format( "You have failed %s!  %s", quest.longName, msg ), self );
		quest:Abandon( self );

	-- The quest was sent as abandoned.
	elseif status == Quest.QUEST_ABANDONED then
		util.Announce( string.format( "%s has been removed from your quest log.", quest.longName), self );
		quest:Abandon( self );
	end

	-- Cleanup
	self:RemoveQuest( id );
end

-- Remove a quest from the player.  Internal use only.
function ply:RemoveQuest( id )
	local quests = util.JSONToTable( self:GetNWString( "quests" ));

	for i = 1, table.getn( quests ) do
		if quests[i].id == id then
			local quest = Quest:FindByID( quests[i].id );

			table.remove( quests, i );
			self:SetNWString( "quests", util.TableToJSON( quests ));
		end
	end
end

-- Add quest progress.
function ply:AddQuestProgress( qid, num )

	local quest = Quest:FindByID( qid );
	local quests = util.JSONToTable( self:GetNWString( "quests" ));

	for i = 1, table.getn( quests ) do
		if quests[i].id == qid then
			local q = quests[i];
			q.progress = q.progress + num;

			util.Announce( string.format("Quest Progress: %d / %d", q.progress, quest.data.target), self );
			self:SetNWString( "quests", util.TableToJSON( quests ));

			return( q.progress );
		end
	end
end

-- Return a table of quest IDs that the player is on.
function ply:GetQuests()
	return util.JSONToTable( self:GetNWString( "quests" ));
end

-- Returns a table of quest IDs that the player has completed.
function ply:GetCompletedQuests()
	return util.JSONToTable( self:GetNWString( "complete" ));
end

-- Get if the player has completed the specified quest.
function ply:HasCompletedQuest( id )
	local quests = self:GetCompletedQuests();
	for i = 1, table.getn( quests ) do
		if quests[i] == id then
			return true;
		end
	end
	return false;
end

function ply:IsOnQuest( id )
	local quests = self:GetQuests();
	for i = 1, table.getn( quests ) do
		if quests[i] == id then
			return true;
		end
	end
	return false;
end

--[[--------------------------------------------------
    Money Functions
-----------------------------------------------------]]

-- Give the player some money.
function ply:AddMoney( amt )
	local money = self:GetNWInt( "money" );
	local newMoney = money + amt;

	util.Announce( string.format( "Gained $%d. Wallet: $%d", amt, newMoney ), self );
	self:SetNWInt( "money", newMoney );

	return newMoney;
end

-- Remove some money from the player.
function ply:RemoveMoney( amt )
	local money = self:GetNWInt( "money" );
	local newMoney = money - amt;

	util.Announce( string.format( "Lost $%d. Wallet: $%d", amt, newMoney ), self );
	self:SetNWInt( "money", newMoney );

	return newMoney;
end

-- Return how much money the player has.
function ply:GetMoney()
	return self:GetNWInt( "money" );
end

-- Remove specified amount of money from the player
-- and give it to the target.
function ply:GiveMoney( ply, amt )
	ply:AddMoney( amt );
	self:RemoveMoney( amt );
end

--[[--------------------------------------------------
    Misc Functions
-----------------------------------------------------]]

function ply:GiveWeapon( item )
	local w = self:Give( item );
	self:SetActiveWeapon( w );
	sound.Play( "items/ammo_pickup.wav", self:GetPos() );
end

function ply:Save( )
	-- MySQL code.
end