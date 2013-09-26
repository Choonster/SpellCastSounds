local SPELLS = {
	-- spellIDs to play sounds for
	-- Format: [spellID] = true, -- Spell Name
	[115310] = true, -- Revival
}

local SOUNDS = {
	-- Paths of sound files to play when one of the spells in the SPELLS table is cast
	"Sound\\Creature\\Peon\\Peonbuildingcomplete1.ogg",
	"Sound\\Creature\\Thorim\\UR_Thorim_Start02.ogg",
}

-- The sound channel to play sounds on.
-- This can be "Master", "SFX", "Music" or "Ambience"
local SOUND_CHANNEL = "Master"

-------------------
-- END OF CONFIG --
-------------------

-- Store the length of the SOUNDS table (i.e. how many sounds we have).
-- If this length wasn't constant, we'd probably just calculate in the UNIT_SPELLCAST_SUCCEEDED method instead of storing it here.
local NUM_SOUNDS = #SOUNDS

local f = CreateFrame("Frame")
f:SetScript("OnEvent", function(self, event, ...) -- Called when one of the events we're watching fires
	self[event](self, ...) -- Calls the event name as a method of f, i.e. `f:EVENT_NAME(arg1, arg2, arg3)`
end)

f:RegisterUnitEvent("UNIT_SPELLCAST_SUCCEEDED", "player") -- Register the UNIT_SPELLCAST_SUCCEEDED event only for the "player" unit
function f:UNIT_SPELLCAST_SUCCEEDED(unit, spellName, spellRank, lineID, spellID)
	if SPELLS[spellID] then	-- If this is one of the spells we care about
		local soundPath = SOUNDS[random(NUM_SOUNDS)] -- Pick a random sound
		PlaySoundFile(soundPath, SOUND_CHANNEL) -- Play the sound
	end
end