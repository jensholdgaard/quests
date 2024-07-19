function event_signal(e) 	

	local zoneGuildID = eq.get_zone_guild_id();

	if(zoneGuildID == 4294967295) then
		return false;
	end

	if(e.signal == 1) then 		
 		eq.start(3); 		
 	elseif(e.signal == 2) then 		
 		eq.stop();
 	end
 end