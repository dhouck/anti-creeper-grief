# Create creeper
summon minecraft:creeper ~ ~ ~ {ignited: true, Fuse: 0b, Tags: ["acg_bomb", "acg_uc"]}

# A powered creeper is represented by effect 26 (luck) being ambient
data modify entity @e[type=minecraft:creeper,tag=acg_uc,limit=1,sort=nearest] powered set from entity @s Effects[{Id: 26b}].Ambient

# Cleanup
tag @e[type=minecraft:creeper,tag=acg_uc,limit=1,sort=nearest] remove acg_ug
kill @s