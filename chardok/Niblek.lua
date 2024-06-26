-- Part of quest for Veeshan's Peak key
-- Quarm edit for flavor text. Gotta get the drops from any named now!
function event_say(e)
	if(e.message:findi("hail")) then
		e.self:Say("I Niblek. You want something from Niblek? Too bad! Niblik like treasures.");
	elseif(e.message:findi("treasure")) then
		e.self:Say("Niblek find piece of old jewelry! It very old, probably has much power!");
	elseif(e.message:findi("jewelry")) then
		e.self:Say("Niblek likes shiny tings very much!");
	end
end

-- Quest by mystic414
-------------------------------------------------------------------------------------------------
-- Converted to .lua using MATLAB converter written by Stryd and manual edits by Speedz
-- Find/replace data for .pl --> .lua conversions provided by Speedz, Stryd, Sorvani and Robregen
-------------------------------------------------------------------------------------------------
