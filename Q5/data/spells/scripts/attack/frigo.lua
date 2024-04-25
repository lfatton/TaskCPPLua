-- Call the combat callback function on a 4x4 area around the caster,
-- where we call an ice tornado on each onTargetTile of the area with a random delay

local MAX_SPELL_DELAY = 1500

function onTargetTile(cid, pos)
	addEvent(function(pos)
		doAreaCombat(cid, COMBAT_ICEDAMAGE, pos, 0, -100, -100, CONST_ME_ICETORNADO)
	end, math.random(0, MAX_SPELL_DELAY), pos)
end

local combat = Combat()
combat:setArea(createCombatArea(AREA_CIRCLE3X3))
combat:setCallback(CALLBACK_PARAM_TARGETTILE, "onTargetTile")

function onCastSpell(creature, variant)
	return combat:execute(creature, variant)
end
