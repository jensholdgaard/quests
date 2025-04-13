local spell_pause = 0

function event_say(e)
	if(e.message:findi("hail")) then
		e.self:Say("Well met, traveler! Are you here to [" .. eq.say_link("join the cause") .. "]?");
	elseif(e.message:findi("join the cause")) then
		e.self:Say("The collective here, has either been banished from the safety of the Empire, or has left willingly. While many of us may love our people, the system of constant fear & tyranny has long ground at our nerves. Our hope is to show the Empire that there is more than one way to live. Hearing that, would you still [" .. eq.say_link("like to join") .. "]?");
	elseif(e.other:GetFactionValue(e.self) >= -100 and e.message:findi("like to join")) then
		e.self:Say("Read this, and if you still want to join, hand it back to me, and we'll get started.");
		e.other:SummonCursorItem(811); -- Scribbled Note (Ranger)
	elseif(e.other:GetFactionValue(e.self) < -100 and e.message:findi("like to join")) then
		e.self:Say("I'm glad you wish to join us, but unfortunately, I can only train those who have shown some dedication to the cause.");
	elseif(e.message:findi("work")) then
		e.self:Say("Let's get you started on some simple targets, and get you acquainted with the local wildli... Creatures. Bring me a scale from a chokidai, the carapace of a scarab, and the burnt bones of our fallen. Return those items to me, along with that bracer I handed you, then we'll see what else you can tackle.");
	elseif(e.message:findi("dangerous targets")) then
		e.self:Say("You appear to be ready for more dangerous prey, so I've got a target for you. I'm sure you've noticed the giant scorpions wandering around. Well, the especially large ones have a habit of always going for a heart strike. Once their stinger sinks deep, they release a toxin that stops the heart, dead. Find one, and bring me the final segment of its tail, still full of venom, along with two pieces of Emerald Palm Root, found in the jungle to the east, and your bracer.");
	end	
end

function event_trade(e)
	local item_lib = require("items");
	local emerald_palm_roots = item_lib.count_handed_item(e.self, e.trade, {12768}, 2);

	if(e.other:GetFactionValue(e.self) >= -100 and item_lib.check_turn_in(e.self, e.trade, {item1 = 811})) then --Scribbled Note (Ranger)
		e.self:Say("Welcome to exile, take this. Once you've settled in, let's get you started on some [" .. eq.say_link("work") .. "]");
		e.other:QuestReward(e.self,{itemid = 855});	-- Hunting Bracer
		e.other:Faction(e.self,20004,15); --Cabilisian Exiles
		e.other:Faction(e.self,446,5); --The Forsaken
	elseif(e.other:GetFactionValue(e.self) >= -100 and item_lib.check_turn_in(e.self, e.trade, {item1 = 11950, item2 = 13849, item3 = 12669, item4 = 855})) then -- A Wolf Scale, Scarab Carapace, Charred Bone Shards, Bracer 1
		e.self:Say("Not bad for a new scout! You may prove to be quite useful in the future. Here, take this back, I've reinforced it to provide some better protection. You've got some  [" .. eq.say_link("dangerous targets") .. "] to take out.");
		e.other:QuestReward(e.self,{itemid = 854,exp = 6500});	-- Padded Hunting Bracer
		e.other:Faction(e.self,20004,20); --Cabilisian Exiles
		e.other:Faction(e.self,446,10); --The Forsaken
	elseif(e.other:GetFactionValue(e.self) >= -100 and emerald_palm_roots > 0 and item_lib.check_turn_in(e.self, e.trade, {item1 = 12846, item2 = 854})) then -- A Scorpion Telson (full), Emerald Palm Root x2, Bracer 2
		e.self:Say("Glad to see you've the scales to take on dangerous creatures, and the patience to wait for what you require. Perhaps soon, I'll have more work for you.");
		e.other:QuestReward(e.self,{items = {853, 852},exp = 10000});	-- Reinforced Hunting Bracer, Hunters Bow
		e.other:Faction(e.self,20004,25); --Cabilisian Exiles
		e.other:Faction(e.self,446,10); --The Forsaken
	else
		item_lib.return_items(e.self, e.other, e.trade)
	end
end