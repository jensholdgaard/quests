function event_spawn(e)
    if (eq.get_zone_guild_id() ~= -1) then
		eq.debug("We are in an instance (" .. eq.get_zone_guild_id() .. "), ignoring event_spawn for " .. e.self:GetName());
		eq.depop();
	else
		local zone_time = eq.get_zone_time();
		local hour = zone_time["zone_hour"];
		local minute = zone_time["zone_minute"];
		eq.debug("Shuttle spawned! Name is: " .. e.self:GetName() .. " Time is: " .. hour ..":" .. minute .. "", 1);
	end
end

function event_waypoint_arrive(e)
	local zone_time = eq.get_zone_time();
	local hour = zone_time["zone_hour"];
	local minute = zone_time["zone_minute"];
	if(e.wp == 22) then
		eq.debug("Shuttle to oasis (5) has reached the island.  Name is: " .. e.self:GetName() .. " Time is: " .. hour ..":" .. minute .. "", 1);
	elseif(e.wp == 49) then
		eq.debug("Shuttle to oasis (5) has reached its destination! Name is: " .. e.self:GetName() .. " Time is: " .. hour ..":" .. minute .. "", 1);
		eq.get_entity_list():ForeachClient(
			function(ent)
				ent:MovePC(37,-1185,1568,-4,0);
			end,
			function(ent)
				if(ent:GetBoatID() == 841) then
					return true;
				end
				return false;
			end
		);
	end
end