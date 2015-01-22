-- Saga is Licensed under Creative Commons Attribution-NonCommerial-ShareAlike 3.0 License
-- http://creativecommons.org/licenses/by-nc-sa/3.0/
-- Generated By Quest Extractor on 2/8/2008 3:46:14 PM
--Spanner 7/25/08

local QuestID = 29;
local ReqClv = 3;
local ReqJlv = 0;
local NextQuest = 0;
local RewZeny = 26;
local RewCxp = 65;
local RewJxp = 25;
local RewWxp = 0; 
local RewItem1 = 1700113; 
local RewItem2 = 0; 
local RewItemCount1 = 2; 
local RewItemCount2 = 0; 

-- Modify steps below for gameplay

function QUEST_START(cid)
	Saga.AddStep(cid, QuestID, 2901);
	Saga.AddStep(cid, QuestID, 2902);
	Saga.InsertQuest(cid, QuestID, 1);
	return 0;
end
function QUEST_FINISH(cid)
	-- Gives all rewards
	local freeslots = Saga.FreeInventoryCount(cid, 0);
	if freeslots > 0 then
		Saga.GiveZeny(RewZeny);
		Saga.GiveExp( RewCxp, RewJxp, RewWxp);
		Saga.GiveItem(cid, RewItem2, RewItemCount2 );
		return 0;
	else
		Saga.EmptyInventory(cid);
		return -1;
	end
end

function QUEST_CANCEL(cid)
	return 0;
end

fuction QUEST_STEP_1(cid)
--Find Unripe PukuPuku's Leaf;Find Tropical Smell Scale

	Saga.FindQuestItem(cid,QuestID,StepID,10002,2603,8000,3,1);
	Saga.FindQuestItem(cid,QuestID,StepID,10003,2603,8000,3,1);
	Saga.FindQuestItem(cid,QuestID,StepID,10004,2603,8000,3,1);
	Saga.FindQuestItem(cid,QuestID,StepID,10046,2667,8000,2,2);
	Saga.FindQuestItem(cid,QuestID,StepID,10047,2667,8000,2,2);

--check if all substeps are complete
	for i = 1, 2 do
	if Saga.IsSubStepCompleted(cid,QuestID,StepID,i) == false
then
	return -1:
	end

end
	Saga.StepComplete(cid,QuestID,StepID);
	return 0;
end

function QUEST_STEP_2(cid)
-- Hand in to Kafra Board Mailbox

	local ret = Saga.GetNPCIndex(cid)
	local ItemCountA = Saga.CheckUserInventory(cid, 2603)
	local ItemCountB = Saga.CheckUserInventory(cid, 2667)
	if ret == 1123 and ItemCountA > 2 and ItemCountB > 1
then
	Saga.NpcTakeItem(cid, 2603, 3);
	Saga.NpcTakeItem(cid, 2667, 2);
	Saga.SubstepComplete(cid,QuestID,StepID,1);
	end

end
--check if all substeps completed
	for i = 1, 1 do
	if Saga.IsSubStepCompleted(cid,QuestID,StepID,i) == false
then
	return -1;
	end

end
	Saga.StepComplete(cid,QuestID,StepID);
	Saga.QuestComplete(cid, QuestID);
	return -1;
end
 
 
 

function QUEST_CHECK(cid)
	-- Check all steps for progress
	local CurStepID = Saga.GetStepIndex(cid, QuestID );
	local ret = -1;
	StepID = CurStepID;
	
	if CurStepID == 2901 then
		ret = QUEST_STEP_1(cid);
	elseif CurStepID == 2902 then
		ret = QUEST_STEP_2(cid);
	end
	
	if ret == 0 then
		QUEST_CHECK(cid)
	end
	
	return ret;
end
