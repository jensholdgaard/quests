local SpawnX = 0;
local SpawnY = 0;
local SpawnZ = 0;
local SpawnH = 0;

function event_spawn(e)
	SpawnX = e.self:GetX();
	SpawnY = e.self:GetY();
	SpawnZ = e.self:GetZ();
	SpawnH = e.self:GetHeading();
end

function event_combat(e)
	if(e.joined) then
		eq.set_timer("1",1000); --a 1 second leash timer.
	else
		eq.stop_timer("1");
		e.self:GMMove(SpawnX,SpawnY,SpawnZ,SpawnH);
	end
end

function event_timer(e)
	if(e.timer == "1") then
		if(e.self:GetX() < -431 or e.self:GetX() > -85 or e.self:GetY() < 770 or e.self:GetY() > 1090 or e.self:GetZ()  < -50) then
			e.self:GMMove(SpawnX,SpawnY,SpawnZ,SpawnH);
		end
	end
end

function event_signal(e)
	if ( e.signal == 1 ) then
		e.self:Shout("The Sleeper stirs!  A glorious new age for Norrath is about to begin, and my exile is about to end!");
	end
end
