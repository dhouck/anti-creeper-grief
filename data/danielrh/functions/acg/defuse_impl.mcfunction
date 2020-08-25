# Make 17x lucky and 17x unlucky, and nonexplosive
# TODO: Shorten fuse by 1 tick, since we delay the actual explosion
data merge entity @s {ExplosionRadius: 0b}
data modify entity @s ActiveEffects append value {Duration: 2147483637, Id: 26b, Amplifier: 17b, Ambient: false, ShowParticles: false, ShowIcon: true}
data modify entity @s ActiveEffects append value {Duration: 2147483637, Id: 27b, Amplifier: 17b, Ambient: true, ShowParticles: false, ShowIcon: true}
tag @s add acg_defused
