function event_say(e)
	if(e.message:findi("hail")) then
		e.self:Emote("Hail, and well met, friend. Have you heard any news of the Truthbringer's return, or are you a [believer in truth and justice]?");
	elseif(e.message:findi("believer")) then
		e.self:Say("Aye, a believer, are ye? Tha' Shamen of Justice have let us stay in their ranks, so long as we hold Justice in addition to Truth. The two are principles myself and [my brother] believe in.");
	elseif(e.message:findi("brother")) then
		e.self:Say("My brother, Jarris, hath been acting a bit strange lately. I set the man out to find wood, and well, he has not returned.");
	end
end

function event_trade(e)
	local item_lib = require("items");
	if(item_lib.check_turn_in(e.self, e.trade, {item1 = 998, item2 = 32620})) then
		e.self:Emote("gasps. 'My brother yet lives! And- ye gods, what is this?! A blade he claims forged in the Halls of Honor?! It must be a sign from Mithaniel!' He then quickly attempts repairs to the blade... but the handle slides right off, the blade falls to the ground, and shatters. 'By Erollisi's bosom! That's some godly steel, indeed. Sorry, friend. Ya can have this back.'");
		e.other:QuestReward(e.self,0,0,0,0,997,0);
		e.other:Message(0, "You notice crumpled up paper within the hilt of the weapon.");
		e.other:QuestReward(e.self,0,0,0,0,503,0);
	elseif(item_lib.check_turn_in(e.self, e.trade, {item1 = 502})) then
		e.self:Say("Welcome to tha' Paladins of Justice, my friend. As Paladins, we are sworn to also defend the virtues of Truth and Justice in tha' city. We're not quite welcome everywhere here due to our devotion. Watch yer back. Oh, and, ah, put some clothes on, will ya?!");
		e.other:QuestReward(e.self,0,0,0,0,501,100);
		e.other:Faction(e.self,327,200); 															--Shamen of Justice
		e.other:Faction(e.self,223,-3); 															--Circle of Unseen Hands
		e.other:Faction(e.self,336,-3); 															--Coalition of Tradefolk Underground
		e.other:Faction(e.self,244,-5); 															--Ebon Mask		
	end
	item_lib.return_items(e.self, e.other, e.trade)
end
