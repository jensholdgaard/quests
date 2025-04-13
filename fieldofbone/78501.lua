function event_spawn(e)
	eq.set_timer("depop",300000);
	e.self:Emote("begins to shudder and shake, the bones fly from the ground, standing bolt upright. The essence flies from Kroq's hands and begins to meld with the skeleton. In a sudden flash of green light, there is a " .. e.self:GetCleanName() .. " staring at you.");
	e.self:Say("How have I returned, and why does... is this home? You've brought me home?! But the mission isn't complete...");
end

function event_say(e)
	if(e.message:findi("hail")) then
		e.self:Say("Well met. Why have I been brought back? What more is [" .. eq.say_link("required") .. "] of me? Was my life not enough?");
	elseif(e.message:findi("required")) then 
		e.self:Say("You mean to tell me that you've brought me back for information?");
		e.self:Emote("turns towards Kroq, fixing him with vacant eye.");
		e.self:Say("Very well. We found our way into the sunken city. The entrance was guarded by some loathsome goblins, inside and out. We fought our way in, before our weapons were shattered, and being overwhelmed. Memories get scattered at that point, but I recall large constructs, and misshapen monstrosities charging at us, drawn by the [" .. eq.say_link("sounds of battle") .. "].");
	elseif(e.message:findi("sounds of battle")) then
		e.self:Say("In the ensuing melee, we were merely a momentary distraction. The goblins are interlopers there, even compared to the monsters and constructs. I guess our remains were dragged off, with our souls controlled by ancient magicks. I can still feel a pull to that damp place, destorying any hope of being [" .. eq.say_link("laid to rest") .. "].");
	elseif(e.message:findi("laid to rest")) then
		e.self:Say("Well, my body and soul have been reunited, but I have no control over it. I.. I suspect that if you were to find what binds my soul, and even a piece of my weapon, the binding could be moved to something of mine. With that done, I think I can rest.");
		e.self:Say("I think I'd like to accompany you, so that I may witness you strike down those who felled me. Take my head, and return it with my weapon, and the bound focus. If my body has wandered off when we return, hand me to Kroq, he'll know what to do.");
		e.other:SummonCursorItem(843); -- Animated Iksar Head
	end
end

function event_trade(e)
	local item_lib = require("items");
	if(item_lib.check_turn_in(e.self, e.trade, {item1 = 897, item2 = 898, item3 = 843})) then -- Boundsoul Pendant and Shattered Skyiron Blade
		e.self:Say("Ahh, I can feel the control of my soul returning... Thank you, " .. e.other:GetCleanName() .. ", for this kindness. And my weapon! A pity that it shattered, it was a fine blade. Here, I want you to have this, perhaps it'll help you in the future.");
		e.other:Message(15, "You can now new game plus into an Iksar Rogue of Field of Bone that worships no one.");		
		e.other:AddCharacterCreateCombinationUnlock(eq.FindClass("rogue"), eq.FindRace("iksar"), eq.FindDeity("agnostic"), eq.FindCityChoice("cabilis"), 78, 3325.0, -557, 4.4, 120);
		e.other:QuestReward(e.self,0,0,0,0,813); -- Soul Fragment of an Iksar Rogue
	elseif(item_lib.check_turn_in(e.self, e.trade, {item1 = 897, item2 = 899, item3 = 843})) then -- Boundsoul Pendant and Emeraldwood Bow Splinter
		e.self:Say("Ahh, I can feel the control of my soul returning... Thank you, " .. e.other:GetCleanName() .. ", for this kindness. And my weapon! A pity that it splintered, it was a well carved bow. Here, I want you to have this, perhaps it'll help you in the future.");
		e.other:Message(15, "You can now new game plus into an Iksar Ranger of Field of Bone that worships no one.");		
		e.other:AddCharacterCreateCombinationUnlock(eq.FindClass("ranger"), eq.FindRace("iksar"), eq.FindDeity("agnostic"), eq.FindCityChoice("cabilis"), 78, 3325.0, -557, 4.4, 120);
		e.other:QuestReward(e.self,0,0,0,0,812); -- Soul Fragment of an Iksar Ranger
	else
		item_lib.return_items(e.self, e.other, e.trade)
	end
end

function event_timer(e)
	if(e.timer == "depop") then
		eq.depop();
	end
end