getCombosOnCell = (leekId, cellId) ->
  equipedWeapon = getWeapon(leekId)
  turnPoints = getTP(leekId)


getToolBaseDamages = (toolId) ->
  damages = []
  if isChip(toolId)
    effects = getChipEffects(toolId)
  else
    effects = getWeaponEffects(toolId)

  i = 0
  while(i < count(effects))
    if effects[i][0] == EFFECT_DAMAGE
      push(damages, [effects[i][1], effects[i][2]])
    i++
  return damages

toolTargets = (toolId, cellId) ->
  isW = isWeapon(toolId)
  maxRange = if isW then getWeaponMaxRange(toolId) else getChipMaxRange(toolId)
  minRange = if isW then getWeaponMinRange(toolId) else getChipMinRange(toolId)

  if((isW && !isInlineWeapon(toolId)) || (!isW && !isInlineChip(toolId)))
    targets = gridLozenge(cellId, minRange, maxRange, true, false)
  else
    targets = gridLines(cellId, minRange, maxRange, true, false)
  if (isW && !weaponNeedLos(toolId)) || (!isW && !chipNeedLos(toolId))
    return targets
  i = 0
  targetsLos = []
  while(i < count(targets))
    if lineOfSight(cellId, targets[i])
      push(targetsLos, targets[i])
    i++
  return targetsLos
