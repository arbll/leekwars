getDangerMap = (enemyId, cellId, allWeapons) ->
  if allWeapons && dangerMap[enemyId] != null && dangerMap[enemyId][cellId] != null
    return dangerMap[enemyId][cellId]

  if dangerMap[enemyId] == null
    dangerMap[enemyId] = []
  if dangerMap[enemyId][cellId] == null
    dangerMap[enemyId][cellId] = []

  weapons = getWeapons(enemyId)
  chips   = getChips(enemyId)
  targets = []
  if allWeapons
    checkWeapons = weapons
  else
    weapon = getWeapon(enemyId)
    if weapon != null then checkWeapons = [weapon] else checkWeapons = []
  i = 0
  while i < count(checkWeapons)
    wTargets = toolTargets(checkWeapons[i], cellId)
    z = 0
    while z < count(wTargets)
      if !inArray(targets, wTargets[z])
        push(targets, wTargets[z])
      z++
    i++
  i = 0
  while i < count(chips)
    cTargets = toolTargets(chips[i], cellId)
    z = 0
    while z < count(cTargets)
      if !inArray(targets, cTargets[z])
        push(targets, cTargets[z])
      z++
    i++
  if allWeapons
    dangerMap[enemyId][cellId] = targets
  return targets
