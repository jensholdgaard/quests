function eq.ChooseRandom(...)
	local tbl = {...};
	return tbl[math.random(#tbl)];
end

function eq.SelfCast(spell_id)
	local init = eq.get_initiator();
	local sp = Spell(spell_id);
	
	if(init.null or sp.null) then
		return;
	end
	
	init:SpellFinished(spell_id, init, 10, 0, -1, sp:ResistDiff());
end

function eq.ClassType(class)
	if(class == 8 or class == 15 or class == 3 or class == 4 or class == 5) then
		return "hybrid";
	elseif(class == 1 or class == 7 or class == 16 or class == 9) then
		return "melee";
	elseif(class == 11 or class == 12 or class == 13 or class == 14) then
		return "caster"
	elseif(class == 2 or class == 10 or class == 6) then
		return "priest";
	end
	
	return "other";
end

-- random amount of cash in copper, returns totals of copper, silver, gold, platinum
function eq.RandomCash(min, max)
	local total = math.random(min, max)
	local platinum = math.modf(total / 1000)
	total = total - platinum * 1000
	local gold = math.modf(total / 100)
	total = total - gold * 100
	local silver = math.modf(total / 10)
	total = total - silver * 10
	return total, silver, gold, platinum
end

-- Parse a string such as "10 STR 15 STA 10 DEX"
function eq.ParseAttributes(input)

    -- Initialize attributes with default value of 0
    local attributes = { STR = 0, STA = 0, DEX = 0, AGI = 0, INT = 0, WIS = 0, CHA = 0 };
    
    -- Convert the input string to uppercase for case-insensitivity
    input = input:upper();
    
    -- Pattern to match the number followed by the attribute name
    for value, attribute in input:gmatch("(%d+)%s*(%a+)") do
        value = tonumber(value) -- Convert matched value to a number
        if attributes[attribute] ~= nil and value >= 0 and value <= 25 then
            attributes[attribute] = value
        end
    end
	
	-- Attributes will be validated in Lua_Client, clamp them for sanity
	for attribute, value in pairs(attributes) do
		if (value < 0) then
			attributes[attribute] = 0;
		elseif (value > 30) then
			attributes[attribute] = 30;
		end
	end

    return attributes;
end

-- Parses the race name to its ID
function eq.FindRace(input)
	if (input:findi("human")) then
		return 1;
	elseif (input:findi("barbarian")) then
		return 2;
	elseif (input:findi("erudite")) then
		return 3;
	elseif (input:findi("wood elf") or input:findi("wood-elf")) then
		return 4;
	elseif (input:findi("high elf") or input:findi("high-elf")) then
		return 5;
	elseif (input:findi("dark elf") or input:findi("dark-elf")) then
		return 6;
	elseif (input:findi("half elf") or input:findi("half-elf")) then
		return 7;
	elseif (input:findi("dwarf")) then
		return 8;
	elseif (input:findi("troll")) then
		return 9;
	elseif (input:findi("ogre")) then
		return 10;
	elseif (input:findi("halfling")) then
		return 11;
	elseif (input:findi("gnome")) then
		return 12;
	elseif (input:findi("iksar")) then
		return 128;
	elseif (input:findi("vah shir") or input:findi("vahshir")) then
		return 130;
	end
	return -1;
end

function eq.FindGender(input)
	if (input:findi("female")) then
		return 1;
	elseif (input:findi("male")) then
		return 0;
	else
		return -1;
	end
end

-- Parses a diety name to its ID
function eq.FindDeity(input)
	if (input:findi("agnostic")) then
		return 396;
	elseif (input:findi("bertox")) then
		return 201;
	elseif (input:findi("brell")) then
		return 202;
	elseif (input:findi("cazic")) then
		return 203;
	elseif (input:findi("erollisi")) then
		return 204;
	elseif (input:findi("fizzle")) then
		return 205;
	elseif (input:findi("innoruuk")) then
		return 206;
	elseif (input:findi("karana")) then
		return 207;
	elseif (input:findi("mithaniel")) then
		return 208;
	elseif (input:findi("prexus")) then
		return 209;
	elseif (input:findi("quellious")) then
		return 210;
	elseif (input:findi("rallos")) then
		return 211;
	elseif (input:findi("rodect")) then
		return 212;
	elseif (input:findi("solusek")) then
		return 213;
	elseif (input:findi("tribunal")) then
		return 214;
	elseif (input:findi("tunare")) then
		return 215;
	elseif (input:findi("veeshan")) then
		return 216;
	end
	return -1;
end

-- Parses a city name to it's 'player_choice' value in the start_zone db
function eq.FindCityChoice(input)
	if (input:findi("paineel") or input:findi("erudin")) then
		return 0;
	elseif (input:findi("qeynos")) then
		return 1;
	elseif (input:findi("halas")) then
		return 2;
	elseif (input:findi("rivervale")) then
		return 3;
	elseif (input:findi("freeport")) then
		return 4;
	elseif (input:findi("neriak") or input:findi("grobb")) then
		return 5;
	elseif (input:findi("oggok")) then
		return 7;
	elseif (input:findi("kaladim")) then
		return 8;
	elseif (input:findi("kelethin")) then
		return 9;
	elseif (input:findi("felwithe")) then
		return 10;
	elseif (input:findi("akanon")) then
		return 11;
	elseif (input:findi("cabilis")) then
		return 12;
	elseif (input:findi("sharvahl") or input:findi("shar vahl")) then
		return 13;
	end
	return -1;
end