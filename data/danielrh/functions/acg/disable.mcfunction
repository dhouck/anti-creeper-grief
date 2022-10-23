# Most of tick will still run; no need to reset mobGriefing etc.

# Remove tags
execute as @e[type=minecraft:creeper, tag=acg_defused] run function danielrh:acg/re-fuse

data modify storage danielrh:acg enabled set value false

# TODO: Print message (once mobGriefing is stable)
