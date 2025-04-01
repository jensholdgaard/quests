function event_say(e)
	if(e.message:findi("hail")) then
			   e.self:Say(player, "It seems like the boats here are malfunctioning. Must be those gnomes, I tell you! I can take you to [Iceclad] if you would like.")
	elseif(e.message:findi("Iceclad")) then
			   e.self:Say(player, "Teleporting you to Iceclad - safe travels!")
			   e.other:MovePC(110, 340, 5330, -16.90, 130)
	end
end