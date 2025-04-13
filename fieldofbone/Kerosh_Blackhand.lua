function event_say(e)
	if(e.message:findi("hail")) then
		e.self:Say("How the hell did you get back here?! Get lost, while that's still an option!");
	elseif(e.other:GetFactionValue(e.self) >= -500 and e.message:findi("Heartsting")) then
		e.self:Say("Oh, you have the heartsting venom? Quickly, give it here while it's still viable.");
	end	
end

function event_trade(e)
	local item_lib = require("items");

	if(e.other:GetFactionValue(e.self) >= -500 and item_lib.check_turn_in(e.self, e.trade, {item1 = 16838})) then --Heartsting Venom Sack
		e.self:Emote("deftly milks the venom sack into a vial, and quickly stoppers it before handing it over.");
		e.self:Say("Take this, and finish the delivery. Some shady character is waiting on the beach in the giant infested woods to the west.")
		e.other:QuestReward(e.self,{itemid = 851, exp = 1000});	-- Heartsting Extraction
		e.other:Faction(e.self,20004,5); --Cabilisian Exiles
		e.other:Faction(e.self,446,10); --The Forsaken
	else
		item_lib.return_items(e.self, e.other, e.trade)
	end
end