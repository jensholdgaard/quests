function event_say(e)
	if(e.message:findi("hail")) then
		e.self:Say("A little loud, aren't you? What business do you have with the [" .. eq.say_link("exiles") .. "]? Perhaps you've brought some [" .. eq.say_link("relics") .. "] to us?");
	elseif(e.message:findi("exiles")) then
		e.self:Say("Yes, the Exiles. Many of us have been exiled from Cabilis, and the Empire at large. If you you too have been exiled, or just don't agree with the outright tyranny of the Empire, you're welcome to [" .. eq.say_link("join up") .. "].");
		elseif(e.other:GetFactionValue(e.self) >= -100 and e.message:findi("join up")) then
		e.self:Say("Read this, make your mark, and hand it back to me. Then we'll assign your first job.");
		e.other:SummonCursorItem(810); -- Scribbled Note (Rogue)
	elseif(e.other:GetFactionValue(e.self) < -100 and e.message:findi("join up")) then
		e.self:Say("I'm glad you wish to join us, but unfortunately for you, I only train those I can trust.");
	elseif(e.message:findi("job")) then
		e.self:Say("So, ready for a job? Good! We've been trying to figure out how to remain undetected, and also find the undetectable. Spiders, with their numerous eyes, seem to be very perceptive. Bring me four eyes from the local spiderlings, and I'll explain the remaining steps to you.");
	elseif(e.message:findi("shipment")) then
		e.self:Say("We have some contacts at the beach that require the venom of one of the largest scorpions that live out near the blasted pit. Find some, and take it to Kerosh, or his lieutenant, they'll give you the next steps. When you're done, bring back the package, and your ring. Oh! And bring me a giant carrot while you're at it! I hear they grow in the forest to the west.");
	elseif(e.message:findi("relics")) then
		e.self:Say("Yes, while on missions, we're always on the lookout for artifacts that may have been pilfered from our lost cities. If you should find any, please, bring them to me, and I'll see make sure that you find some measure of fame.");
	end	
end

function event_trade(e)
	local item_lib = require("items");
	local spiderling_eyes = item_lib.count_handed_item(e.self, e.trade, {13253}, 4);
	local shattered_relics = item_lib.count_handed_item(e.self, e.trade, {842}, 1);
	local relics_crates = item_lib.count_handed_item(e.self, e.trade, {841}, 1);

	if(spiderling_eyes > 0) then
		repeat
			e.self:Emote("shoves the eyes into a contraption that squeezes the fluids from the eyes, then pours the fluid into a prepared mold, that he slams shut.");
			e.self:Say("Here, take this. Bring me three of these, and your signet ring.")
			
			e.other:QuestReward(e.self,math.random(10),0,0,0,850,100); -- Mark of Sight
			spiderling_eyes = spiderling_eyes - 1
		until spiderling_eyes == 0
	end
	if(shattered_relics > 0) then
		repeat
			e.self:Emote("carefully looks through the fragments, piecing them together, before turning his attention back to you.");
			e.self:Say("Thank you for this, " .. e.other:GetCleanName() .. ". With a bit of work, our people will surely learn more of ourselves because of your work here!");
			e.other:Faction(e.self,441,5); --Legion of Cabilis
			e.other:Faction(e.self,442,5); --Crusaders of Greenmist
			e.other:Faction(e.self,443,5); --Brood of Kotiz
			e.other:Faction(e.self,20004,2); --Cabilisian Exiles
			e.other:Faction(e.self,446,1); --The Forsaken
			shattered_relics = shattered_relics - 1
		until shattered_relics == 0
	end
	if(relics_crates > 0) then
		repeat
			e.self:Emote("looks through the crate, soaking in each artifact, before turning his attention back to you.");
			e.self:Say("Thank you for this, " .. e.other:GetCleanName() .. ". This will help us not just better understand our past, but our place in the future.");
			e.other:Faction(e.self,441,25); --Legion of Cabilis
			e.other:Faction(e.self,442,25); --Crusaders of Greenmist
			e.other:Faction(e.self,443,25); --Brood of Kotiz
			e.other:Faction(e.self,20004,5); --Cabilisian Exiles
			e.other:Faction(e.self,446,1); --The Forsaken
			relics_crates = relics_crates - 1
		until relics_crates == 0
	end

	if(e.other:GetFactionValue(e.self) >= -100 and item_lib.check_turn_in(e.self, e.trade, {item1 = 810})) then --Scribbled Note (Rogue)
		e.self:Say("Welcome to exile, take this. When you're ready, I've got a [" .. eq.say_link("job") .. "] for you");
		e.other:QuestReward(e.self,{itemid = 847});	-- Initiate Signet Ring	
		e.other:Faction(e.self,20004,15); --Cabilisian Exiles
		e.other:Faction(e.self,446,5); --The Forsaken
	elseif(e.other:GetFactionValue(e.self) >= -100 and item_lib.check_turn_in(e.self, e.trade, {item1 = 850, item2 = 850, item3 = 850, item4 = 847})) then -- Mark of Sight x3, Initiate Signet Ring
		e.self:Say("Good work, these should aid in our research nicely. In the meantime, we have a [" .. eq.say_link("shipment") .. "] that we could use some help with.");
		e.other:QuestReward(e.self,{itemid = 846,exp = 6500});	-- Apprentice Signet Ring
		e.other:Faction(e.self,20004,20); --Cabilisian Exiles
		e.other:Faction(e.self,446,10); --The Forsaken
	elseif(e.other:GetFactionValue(e.self) >= -100 and item_lib.check_turn_in(e.self, e.trade, {item1 = 849, item2 = 12459, item3 = 846})) then -- Smuggled Shipment, Kromdul Carrot, Apprentice Signet Ring
		e.self:Emote("sticks the carrot in his maw, and proceeds to rifle through the contents of the crate.");
		e.self:Say("Good, it looks like everything is here. Take these, you've earned it. Oh! The carrot? I was just hungry. Check with me later, I'll have more work for you.");
		e.other:QuestReward(e.self,{items = {845, 844},exp = 8000});	-- Journeyman Signet Ring, Smuggled Spear
		e.other:Faction(e.self,20004,25); --Cabilisian Exiles
		e.other:Faction(e.self,446,10); --The Forsaken
	end

	item_lib.return_items(e.self, e.other, e.trade)
end