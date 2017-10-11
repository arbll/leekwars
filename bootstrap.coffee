DEBUG = true

`global startTurn = getEntityTurnOrder()`

`global pPlaysFirst = startTurn == 1`
`global pWeapons  = getWeapons()`
`global pWeaponsEffects = []`

`global enemies = getAliveEnemies()`
`enemies = getAliveEnemies();`

`global gObstacles = getObstacles()`
`global dangerMap = []`

if(!booted)
  indexBoot = 0
  while indexBoot < count(pWeapons)
    pWeaponsEffects[indexBoot] = getWeaponEffects(pWeapons)
    indexBoot++

if(DEBUG && !booted)
  debug("bootstrap:")
  debug("startTurn:")
  debug(startTurn)
  debug("pPlaysFirst:")
  debug(pPlaysFirst)
  debug("pWeapons:")
  debug(pWeapons)
  debug("pWeaponsEffects:")
  debug(pWeaponsEffects)
  debug("enemies:")
  debug(enemies)
  debug("----------------")

`global booted = true`
