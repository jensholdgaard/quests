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
		if(e.self:GetX() < -1000 or e.self:GetX() > -650 or e.self:GetY() < -1500 or e.self:GetY() > -1170) then
			e.self:GMMove(SpawnX,SpawnY,SpawnZ,SpawnH);
		end
	end
end

function event_signal(e)
	if ( e.signal == 1 ) then
		e.self:Shout("Ha!  The Ring and Claws are doomed!  The Sleeper has been awakened, what a glorious day!  Lady Vox, I will see you soon, our long delayed nuptials can now proceed!");
	end
end
