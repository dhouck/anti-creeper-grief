# Make 17x lucky and 17x unlucky, and nonexplosive
data merge entity @s {ExplosionRadius: 0b}
data modify entity @s ActiveEffects append value {Duration: 2147483637, Id: 26b, Amplifier: 17b, Ambient: false, ShowParticles: false, ShowIcon: true}
data modify entity @s ActiveEffects append value {Duration: 2147483637, Id: 27b, Amplifier: 17b, Ambient: true, ShowParticles: false, ShowIcon: true}

# Shorten fuse by 1 tick, since we delay the actual explosion
execute store result score @s drh_acg_fuse run data get entity @s Fuse
scoreboard players remove @s drh_acg_fuse 1

# The if clause is because on the first tick of the datapack being loaded, the
# scoreboard wonʼt exist yet.  Old creepers wonʼt have shortened fuses.
execute if score @s drh_acg_fuse matches 1.. store result entity @s Fuse byte 1 run scoreboard players get @s drh_acg_fuse
scoreboard players reset @s drh_acg_fuse

tag @s add acg_defused
