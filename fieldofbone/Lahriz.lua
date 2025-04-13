function event_say(e)
	if(e.message:findi("hail")) then
		e.self:Say("Well met, " .. e.other:GetCleanName() .. ". How can I help you? Are you in search of reagents?");
	elseif(e.message:findi("reagents")) then
		e.self:Say("Some of our spells require some exotic focii, that aren't naturally obtainable here. I hear that there's a smuggler in the woods to the west, that may have some.");
	end	
end