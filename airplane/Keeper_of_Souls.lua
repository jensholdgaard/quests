-- Epic NPC -- Keeper_of_Souls

function event_death_complete(e)
	local sirranName = "sirran";
	sirranName = sirranName .. eq.get_zone_guild_id();
	sirran= nil;
	eq.set_global(sirranName,"4",3,"M20");
	eq.spawn2(71058,0,0, e.self:GetX(), e.self:GetY(), e.self:GetZ(), e.self:GetHeading()); -- NPC: Sirran_the_Lunatic
end

--Quest by: Solid11
-------------------------------------------------------------------------------------------------
-- Converted to .lua using MATLAB converter written by Stryd
-- Find/replace data for .pl --> .lua conversions provided by Speedz, Stryd, Sorvani and Robregen
-------------------------------------------------------------------------------------------------
