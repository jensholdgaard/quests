function event_spawn(e)
    if (eq.get_zone_guild_id() ~= -1) then
		eq.debug("We are in an instance (" .. eq.get_zone_guild_id() .. "), ignoring event_spawn for " .. e.self:GetName());
		eq.depop();
	end
end

function event_signal(e) 
	if(e.signal == 1) then 		
 		eq.start(3); 		
 	elseif(e.signal == 2) then 		
 		eq.stop();
 	end
 end