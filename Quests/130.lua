-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:15 PM

local QuestID = 130;
local ReqClv = 10;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 237;
local RewCxp = 480;
local RewJxp = 0;
local RewWxp = 0; 
local RewItem1 = 1700113; 
local RewItem2 = 0; 
local RewItemCount1 = 4; 
local RewItemCount2 = 0; 

-- Modify steps below for gameplay

function QUEST_VERIFY(cid)
	Saga.GeneralDialog(cid, 3957);
	return 0;
end

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 13001);
	Saga.AddStep(cid, QuestID, 13002);
	Saga.AddStep(cid, QuestID, 13003);
	Saga.InsertQuest(cid, QuestID, 2);
	return 0;
end
function QUEST_FINISH(cid)
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 1 then
	Saga.GiveZeny(cid, RewZeny);
	Saga.GiveExp(cid, RewCxp, RewJxp, RewWxp);
	Saga.GiveItem(cid, RewItem1, RewItemCount1 );
	Saga.GiveItem(cid, RewItem2, RewItemCount2 );
	return 0;
else
	return -1;
	end

end
function QUEST_CANCEL(cid)
	return 0;
end

function QUEST_STEP_1(cid)
	Saga.StepComplete(cid, QuestID, 13001);
	return 0;
end

function QUEST_STEP_2(cid)
--Talk with Adria
	
	Saga.AddWaypoint(cid, QuestID, 13002, 1, 1143);
--check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1143
then
	Saga.GeneralDialog(cid, 3936);
	Saga.SubstepComplete(cid, QuestID, 13002, 1);
	end

--check if all substeps are complete
	for i = 1, 1 do
	if Saga.IsSubStepCompleted(cid, QuestID, 13002, i) == false
then
	return -1;
	end
end
	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 13002);
	return 0;
end

function QUEST_STEP_3(cid)
--Talk with Scacciano Morrigan

	Saga.AddWaypoint(cid, QuestID, 13003, 1, 1003);
--check for completion
	local ret = Saga.GetNPCIndex(cid);
	if ret == 1003
then
	Saga.GeneralDialog(cid, 3936);
	Saga.SubstepComplete(cid, QuestID, 13003, 1);
	end
--check if all substeps are complete
	for i = 1, 1 do
	if Saga.IsSubStepCompleted(cid, QuestID, 13003, i) == false
then
	return -1;
	end
end

	Saga.ClearWaypoints(cid, QuestID);
	Saga.StepComplete(cid, QuestID, 13003);
	Saga.QuestComplete(cid, QuestID);
end	
	
function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;

	if CurStepID == 13001 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 13002 then
		ret = QUEST_STEP_2(cid);
	elseif CurStepID == 13003 then
		ret = QUEST_STEP_3(cid);
	end

	if ret == 0 then
		QUEST_CHECK(cid)
	end

	return ret;
end