-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:14 PM

local QuestID = 13;
local ReqClv = 5;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 70;
local RewCxp = 161;
local RewJxp = 63;
local RewWxp = 0; 
local RewItem1 = 1700113; 
local RewItem2 = 2664; 
local RewItemCount1 = 3; 
local RewItemCount2 = 1; 
local StepID = 0;

-- Modify steps below for gameplay

function QUEST_START(cid)
	-- Initialize all quest steps
	-- Initialize all starting navigation points
    Saga.AddStep(cid, QuestID, 1301);
    Saga.AddStep(cid, QuestID, 1302);
    Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end

function QUEST_FINISH(cid)
	-- Gives all rewards
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
		Saga.GiveZeny(cid, RewZeny);
		Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem1, RewItemCount1 );
		Saga.GiveItem(cid, RewItem2, RewItemCount2 );
		return 0;
	else
		Saga.EmptyInventory(cid);
		return -1;
	end
end

function QUEST_CANCEL(cid)
    -- Missing cid
	return 0;
end

function QUEST_STEP_1(cid)
	--Pickup loot from some Vadons;and Cornutus
	Saga.FindQuestItem(cid,QuestID,1301,10017,2610,8000,2,1);
	Saga.FindQuestItem(cid,QuestID,1301,10018,2610,8000,2,1);
	Saga.FindQuestItem(cid,QuestID,1301,10019,2610,8000,2,1);
	Saga.FindQuestItem(cid,QuestID,1301,10020,2610,8000,2,1);
	Saga.FindQuestItem(cid,QuestID,1301,10021,2638,8000,3,2);
	Saga.FindQuestItem(cid,QuestID,1301,10022,2638,8000,3,2);


    -- Check if all substeps are completed
    -- There are 2 substeps so check all 2
    for i = 1, 2 do
         if Saga.IsSubStepCompleted(cid,QuestID,1301,i) == false then
			return -1;
		 end
    end
	Saga.StepComplete(cid,QuestID,1301);
	
	return 0;
	-- return is important
    -- end is very important not to forget
end

function QUEST_STEP_2(cid)
	--Deliver Material Averro Reinhold
	Saga.AddWaypoint(cid, QuestID, 1302, 1, 1004);

	--check for completion
	local ItemCountA = Saga.CheckUserInventory(cid, 2610);
	local ItemCountB = Saga.CheckUserInventory(cid, 2638);
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1004 then
	    Saga.GeneralDialog(cid, 3936);
	    if ItemCountA > 1 and ItemCountB > 2 then
	        Saga.NpcTakeItem(cid, 2610, 2);
	        Saga.NpcTakeItem(cid, 2638, 3);	    	    
	        Saga.SubstepComplete(cid,QuestID,1302,1);
	    end
    end	        
	
	-- Prefer using substeps instead of nested if's for consitance with
	-- other quests (easier for other people if all the quests are similair made)
    for i = 1, 1 do
         if Saga.IsSubStepCompleted(cid,QuestID,1302,i) == false then
			return -1;
		 end
    end	

	Saga.ClearWaypoints(cid, QuestID);
    Saga.StepComplete(cid,QuestID,1302);	
	Saga.QuestComplete(cid, QuestID);	
	return -1;
end

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;
	StepID = CurStepID;
	
	if CurStepID == 1301 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 1302 then
		ret = QUEST_STEP_2(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid);
	end
	
	return ret;
end