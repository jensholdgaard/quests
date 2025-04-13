local spell_pause = 0

function event_say(e)
	if(e.message:findi("hail")) then
		e.self:Say("Hail! I suggest you stay away from the ruins to the north. A group of [" .. eq.say_link("untrusted") .. "] have taken up residence there, and I've been sent as a liason from Cabilis.");
	elseif(e.message:findi("untrusted")) then
		e.self:Say("Yes, untrusted. Outcasts, exiles, and far wanderers, the lot of them. We like to keep tabs on them, as they are still our kin, but we don't trust most of them enough to let them into the city anymore. We do, on occasion, use them for scouting [" .. eq.say_link("missions") .. "] that are too risky for our troopers and crusaders to carry out.");
	elseif(e.message:findi("missions")) then
		e.self:Say("We've actually just sent them on one, under the cursed lake. There's a reason we refuse to cede that land to the Sarnak, or to the Goblins. Once, the city of Veksar was suspended above the lake, and it was built atop a spring, that bubbled up into it. That spring is sought after by the Emerald Circle. However, we've lost contact with the scouts we sent, perhaps you could take a look for us?");
	elseif(e.message:findi("relics")) then
		e.self:Say("We're always checking for artifacts so that we may better understand our past. We regularly send the exiles out when we hear of one. If you bring me any you find, even broken ones, I'll be sure to put in a good word with the exiles for you.")
	end
end

function event_trade(e)
	local item_lib = require("items");
	local shattered_relics = item_lib.count_handed_item(e.self, e.trade, {842}, 1);
	local relics_crates = item_lib.count_handed_item(e.self, e.trade, {841}, 1);

	if(shattered_relics > 0) then
		repeat
			e.self:Emote("runs a back of a claw across some of the fragments, then turns back towards you.");
			e.self:Say("Thank you for returning these, " .. e.other:GetCleanName() .. ". It will be good to have these treasures back, even broken as they are. I'll ensure that the exiles hear of your work.");
			e.other:Faction(e.self,20004,5); --Cabilisian Exiles
			e.other:Faction(e.self,446,3); --The Forsaken
			e.other:Faction(e.self,441,1); --Legion of Cabilis
			e.other:Faction(e.self,442,1); --Crusaders of Greenmist
			e.other:Faction(e.self,443,1); --Brood of Kotiz
			shattered_relics = shattered_relics - 1
		until shattered_relics == 0
	end
	if(relics_crates > 0) then
		repeat
			e.self:Emote("carefully looks through the crate, then sets it aside.");
			e.self:Say("Thank you returning these, " .. e.other:GetCleanName() .. ". These pieces of history shouldn't have been lost to us. I'll ensure that the exiles hear of your work.");
			e.other:Faction(e.self,20004,25); --Cabilisian Exiles
			e.other:Faction(e.self,446,15); --The Forsaken
			e.other:Faction(e.self,441,5); --Legion of Cabilis
			e.other:Faction(e.self,442,5); --Crusaders of Greenmist
			e.other:Faction(e.self,443,5); --Brood of Kotiz
			relics_crates = relics_crates - 1
		until relics_crates == 0
	end

	if(e.other:GetFactionValue(e.self) >= -500 and item_lib.check_turn_in(e.self, e.trade, {item1 = 894})) then --Lost Scouts Note
		e.self:Say("Ahh, I see you've found their instructions... Unfortunately, that means that they are likely lost to us. Go, finish their mission, and find out if the spring still flows within that ruined city. Or at least retrieve their bodies, and something of their essence. We have ways of getting answers from the dead.");
		e.other:Faction(e.self,441,1); --Legion of Cabilis
		e.other:Faction(e.self,440,1); --Cabilis Residents
		e.other:Faction(e.self,445,1); --Scaled Mystics
		e.other:Faction(e.self,442,1); --Crusaders of Greenmist
		e.other:Faction(e.self,444,1); --Swift Tails
	end
	
	if(e.other:GetFactionValue(e.self) >= -500 and item_lib.check_turn_in(e.self, e.trade, {item1 = 895, item2 = 896})) then -- Hateful Bones and Scaled Essence
		if(not eq.get_entity_list():IsMobSpawnedByNpcTypeID(78501) and spell_pause == 0) then
			e.self:Say("I can work with this... Give me a minute, I'm still not used to using scrolls from the dread tower.");
			eq.set_timer("Fallen_Scout", 6000);
			spell_pause = 1;
		end
	elseif(e.other:GetFactionValue(e.self) >= -500 and not eq.get_entity_list():IsMobSpawnedByNpcTypeID(78501) and item_lib.check_turn_in(e.self, e.trade, {item1 = 843}) and spell_pause == 0) then
		e.self:Say("This is still strange, but give me a moment, and I'll re-complete the ritual.");
		eq.set_timer("Fallen_Scout", 3000);
		spell_pause = 1;
	elseif(e.other:GetFactionValue(e.self) >= -500 and eq.get_entity_list():IsMobSpawnedByNpcTypeID(78501)) then
		e.self:Say("Perhaps, while the dead are still willing to grant us an audience, you should direct your questions towards them?");
		item_lib.return_items(e.self, e.other, e.trade)
	else
		item_lib.return_items(e.self, e.other, e.trade)
	end
end

function event_timer(e)
	if(e.timer == "Fallen_Scout") then
		eq.stop_timer("Fallen_Scout");
		eq.spawn2(78501, 0, 0, 3291, -1819, 34, 196); -- Fallen Scout
		spell_pause = 0;
	end
end

