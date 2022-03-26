**Current status**: This is a very low priority for me; Iʼll probably get back to this at some point if there isnʼt a better implementation elsewhere by then, but it probably wonʼt be in the next several months at least.  Iʼm not aware of any changes that would have broken it, so it might still work in single-player, but Iʼve heard people say it fails on servers and I have no clue why thereʼd be a difference there.

# Dangerous Anti-Creeper-Grief datapack

This is a datapack which prevents creepers from blowing up your builds, while still keeping them dangerous.  They will damage players and other mobs, just as they would before, but they will not destroy blocks.

This means creepers will:

 * Kill you and your beloved pets
   - Or just injure you, if you have sufficient blast protection
 * Destroy dropped items
 * If charged, cause other mobs to drop heads

But they will not:

 * Set off TNT
 * Destroy blocks
 * Do any of the things on the “will” list if you kill them normally instead of letting them explode

## Other options

There are other things you can do with creepers, but none of them quite did what I wanted:

 * Let them be as coded.  Nice, if you like having a bunch of torches everywhere or rebuilding all the time.  (To be honest, this is how I usually play, but there was a server that didnʼt want that and I was annoyed at the other choices being inadequate)
 * Set `/gamerule mobGriefing off`.  This will get you the same creeper behavior here (the *exact* same behavior, in fact, except for a couple caveats below), but will also affect other mobs:
   - Endermen wonʼt pick up blocks any more, the dragon wonʼt destroy them, and ghast fireballs wonʼt explode things.  If you want this data pack you probably donʼt want those either.
   - Mobs wonʼt pick up items.  In the case of zombies and skeletons, that means theyʼre less dangerous.  In the case of villagers, that means they wonʼt breed; in the case of piglins, that means you canʼt throw gold at them to barter with or distract them.
   - Sheep wonʼt eat grass.  Theyʼll still regrow wool, but you canʼt detect that with an observer.
   - Snow golems wonʼt spawn snow layers, making it harder to farm snowballs/snow layers.
   - A few other things, listed [on the wiki](https://minecraft.gamepedia.com/Commands/gamerule#:~:text=mobGriefing,-When%20false).
 - [Vanilla Tweaks](https://vanillatweaks.net/picker/datapacks) Anti Creeper Grief pack.  This will also prevent creepers from doing damage, making them effectively not dangerous mobs, just a noisy source of gunpowder and music discs.
 - [Some other data packs](https://www.reddit.com/r/Minecraft/comments/c32vhq/datapack_to_prevent_creeper_greefing_without/) work similarly to this one, but if a player is even *near* a creeper they turn off `mobGriefing`, thereby making it easy to accidentally (or purposefully) turn it off everywhere just by AFKing near a creeper farm.

## How it works

Part of this pack works the same way as the Vanilla Tweaks version, by setting all creepersʼ `ExplosionRadius` to 0.  However, that also makes creepers not do damage, so we detect when a creeper explodes, set `gamerule mobGriefing false` for just that tick, and spawn in a new creeper set to explode instantly in the same place.

### Why not just do the `mobGriefing part of that`

It is impossible to detect when a creeper is *about to* explode without mods.  That means that if you want to set `mobGriefing` false when one does, you have to turn it off whenever a player is near a creeper.  This makes it to easy to accidentally (or purposefully, on a server) turn off `mobGriefing` for everybody, even the parts of it that other players benefit from.

### Detecting creeper explosions

If a creeper has any active status effects (like from potions), when it explodes, it will generate an Area Effect Cloud, like from a lingering potion, which gives the relevant effects.  We can then detect that cloud, and use it to spawn a creeper and turn off the game rule.

Considerations for which effects:

 * They should not affect the creeper at all.
 * In theory nothing should get an effect from the cloud, but just in case it would be nice if anybody who *did* didnʼt get anything relevant.
 * They should otherwise not be present in the game, in order to avoid accidentally summoning a creeper
 * Although itʼs impossible to make sure no other data pack could do something overlapping, it should be as distinctive as possible to minimize the chance.
 * Unlike many other aspects, there is no way to make a custom effect; weʼre stuck with the ones in the base game.

It might seem like the last few points are contradictory, but there are in fact effects which are not used anywhere in the game without data packs: [Luck](https://minecraft.gamepedia.com/Luck) and [Unluck](https://minecraft.gamepedia.com/Bad_Luck).  They cancel out at the same level, and there is no way to get them without data packs, so they are perfect here.  Since any legitimate use in another data pack is likely to be relatively low level, like other potions, we give creepers level 18 Luck and Unluck, with a couple other distinguishing bits, and detect the resulting AEC.  We also use one of those distinguishing bits to indicate whether a creeper is charged or not, so we can summon an equivalent one.

## Side effects:

Any known issue with a chance of being fixed is in the issue tracker.  Additionally, there are some minor issues which cannot reasonably be fixed, listed below:

 * You may hear two explosion sounds.  This is because the original creeper still explodes, without any effects, and then a brand-new creeper explodes.
 * There are some black potion swirls from the AEC, before itʼs killed.
 * Thereʼs extra lag from processing all the creepers, but that should be relatively small and I plan to try to reduce it more.

## License

This datapack is licensed under the Apache License 2.0.
