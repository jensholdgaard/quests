--Zone: Overthere  NPC: Ixpacan

local proof_list = {};

local CHILD_OF_CHARASIS = 93189;

function event_say(e)
        local clientName = e.other:GetCleanName();

        if(e.message:findi("hail")) then
                e.self:Say("Hmm. . .is there something I can help you with? I am far too [busy] to listen to your problems though so I take that back.");
        elseif(e.message:findi("busy")) then
                e.self:Say("It is none of your concern unless you are truly gifted in the dark art of necromancy. If so, you will have some form of proof to show me.");
        elseif(e.message:findi("wish to hear")) then
                if(proof_list[clientName]) then
                        e.self:Say("I have recently found a volume on summoning a great minion from the Great Library of Charasis but I can't find all of the needed items. Being as I am one of the [sages of Cabilis], I request you go and [collect these items] for me.");
                else
                        e.self:Emote("awaits some form of proof.");
                end
        elseif(e.message:findi("sages of cabilis")) then
                if(proof_list[clientName]) then
                        e.self:Say("Ah, they are all but a memory now. We used to be welcome within the city of Cabilis but our quest for greater power led to our exile. No matter now, go retrieve the items and you will be one of the chosen to walk beside greatness.");
                else
                        e.self:Emote("awaits some form of proof.");
                end
        elseif(e.message:findi("collect these items")) then
                if(proof_list[clientName]) then
                        e.self:Say("As you should broodling. The the first is a brittle bone, which was once used for reincarnations. The second item is a poisoned soul, this is from an iksar that died a cruel and twisted death. The death was so awful, it's spirit still roams around angry. The third you will find in the burning heat. The final item is a gem of reflection. I have yet to find someone that knows how to create one. Even those fools in Cabilis probably wouldn't know. Maybe you can locate that one yourself. Bring all of these items back to me and I shall do the rest.");
                        e.other:SummonCursorItem(32628);
                else
                        e.self:Emote("awaits some form of proof.");
                end
        end
end

function event_trade(e)
        local item_lib = require("items");
        local text     = "You must show me everything to prove your worth.";

        if(item_lib.check_turn_in(e.self, e.trade, {item1 = 32631, item2 = 4267},0,text)) then  --Items: Child of Charasis Remains, Necromancer Skullcap
                e.self:Say("I see now that I lack the skill necessary to control the Dark Arts. Maybe it would be wiser to allow another such as yourself to continue forward. Please accept this token as a reward in your mastering of the Dark Arts.");
                e.other:QuestReward(e.self,0,0,0,0,32630,20000); --Item: Demi Lich Skullcap
        elseif(item_lib.check_turn_in(e.self, e.trade, {item1 = 32629, item2 = 4267},0)) then  --Item: Ixpacan's Tome-Full, Necromancer Skullcap
                e.self:Say("Wonderful! You have brought all of the items I have asked for. Your future seems very bright with the rest of the Sages. Step back now as I conjure the child of Charasis.");
                e.other:QuestReward(e.self,0,0,0,0,4267); --Item: Necromancer Skullcap
                e.self:DoAnim(43);
                eq.set_timer("start_conjure", 2000)
        elseif(item_lib.check_turn_in(e.self, e.trade, {item1 = 32629})) then  --Item: Ixpacan's Tome-Full
                e.self:Say("Wonderful! You have brought all of the items I have asked for. Your future seems very bright with the rest of the Sages. Step back now as I conjure the child of Charasis.");
                e.self:DoAnim(43);
                eq.set_timer("start_conjure", 2000)
        elseif(item_lib.check_turn_in(e.self, e.trade, {item1 = 4267})) then  --Item: Necromancer Skullcap
                local clientName = e.other:GetCleanName();

                e.self:Say("Oh, I see you are truly gifted in the dark arts. Well I will explain my dilemma to you now if you [wish to hear].");
                e.other:QuestReward(e.self,0,0,0,0,4267); --Item: Necromancer Skullcap
                proof_list[clientName] = true;
        else
                item_lib.return_items(e.self, e.other, e.trade)
        end
end


function event_timer(e)
        if (e.timer == "start_conjure") then
                eq.get_entity_list():MessageClose(e.self, true, 75, 15, "As Ixpacan starts his incantations, you can see an image begin to appear from the shadows.");
                e.self:DoAnim(44);

                eq.stop_timer("start_conjure");
                eq.set_timer("finish_conjure", 2000);
        elseif (e.timer == "finish_conjure") then
                eq.unique_spawn(CHILD_OF_CHARASIS,0,0,e.self:GetX(),e.self:GetY()+5,e.self:GetZ(),e.self:GetHeading());
                eq.get_entity_list():MessageClose(e.self, true, 75, 13, "Ixpacan shouts 'It's out of my control! Defeat it before it destroys us both!'");
                eq.stop_timer("finish_conjure");
        end
end
