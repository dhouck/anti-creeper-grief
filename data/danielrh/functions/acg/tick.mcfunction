# Reset game rule
execute if data storage danielrh:acg mobGriefing_old run function danielrh:acg/reset_griefing
# TODO: Find a way to run at *end* of tick, so player manually changing mobGriefing
# works even if they do it at the wrong time

# Set up creepers
execute as @e[type=minecraft:creeper, tag=!acg_defused, tag=!acg_bomb] run function danielrh:acg/defuse
execute as @e[type=minecraft:creeper, tag=acg_defused, nbt={ActiveEffects:[{Duration: 20}]}] run function danielrh:acg/renew
execute as @e[type=minecraft:creeper, tag=acg_defused, tag=!acg_powered, nbt={powered: true}] run function danielrh:acg/power
# TODO: Allow de-powering creepers (not relevant w/o other datapacks)

# Detect AoE clouds
# TODO: Refactor so this only needs one predicate and one function, to reduce copy code?
execute as @e[type=minecraft:area_effect_cloud, predicate=danielrh:acg/aec] at @s run function danielrh:acg/summon_creeper
execute as @e[type=minecraft:area_effect_cloud, predicate=danielrh:acg/aec_powered] at @s run function danielrh:acg/summon_powered_creeper

# Set game rule as appropriate
execute if entity @e[type=minecraft:creeper, tag=acg_bomb] run function danielrh:acg/save_griefing