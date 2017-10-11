main = ->
  curWeapon = weaponBestRange()
  weaponSelect(curWeapon)

  movements = getMovements(getCell(), getMP())
  safeMovements = movements
  pseudoSafeMovements = movements

  enemiesIndex = 0
  enemiesMovements = []
  enemiesDangerMaps = []

  while(enemiesIndex < count(enemies))
    enemiesMovements[enemies[enemiesIndex]] = getMovements(getCell(enemies[enemiesIndex]), getMP(enemies[enemiesIndex]))
    i = 0
    while(i < count(enemiesMovements[enemies[enemiesIndex]]))
      map = getDangerMap(enemies[enemiesIndex], enemiesMovements[enemies[enemiesIndex]][i], true)
      pseudoMap = getDangerMap(enemies[enemiesIndex], enemiesMovements[enemies[enemiesIndex]][i], false)
      debugMarkCells(pseudoMap, COLOR_RED)
      if enemiesDangerMaps[enemies[enemiesIndex]] == null
        enemiesDangerMaps[enemies[enemiesIndex]] = []
      j = 0
      while j < count(pseudoMap)
        if !inArray(enemiesDangerMaps[enemies[enemiesIndex]], pseudoMap[j])
          removeElement(safeMovements, pseudoMap[j])
          removeElement(pseudoSafeMovements, pseudoMap[j]) #FIXME:Caching
          push(enemiesDangerMaps[enemies[enemiesIndex]], pseudoMap[j])
        j++
      j = 0
      while j < count(map)
        if !inArray(enemiesDangerMaps[enemies[enemiesIndex]], map[j])
          removeElement(safeMovements, map[j])
          push(enemiesDangerMaps[enemies[enemiesIndex]], map[j])
        j++

      i++
    enemiesIndex++

  sort(safeMovements)
  sort(pseudoSafeMovements)
  debugMarkCells(movements, COLOR_BLUE)

  bFoundSafePath = false
  bFoundPseudoSafePath = false
  bFoundAttackPath = false

  path = []
  bestPathDistanceToMiddle = MAP_SIZE + 1

  cellIndex = 0
  aggroMap = getAggroMap(getCell(), getMP())
  debugMarkCells(aggroMap, getColor(255, 255, 0))
  debugMarkCells(safeMovements, COLOR_GREEN)
  mapIndex = 0
  while(mapIndex < count(aggroMap))
    if(inArray(safeMovements, aggroMap[mapIndex]))
      distance = getCellDistance(aggroMap[mapIndex], MAP_CENTER)
      if(!bFoundAttackPath || distance < bestPathDistanceToMiddle)
        bestPathDistanceToMiddle = distance
        path = [aggroMap[mapIndex]]
        bFoundSafePath = true
        bFoundAttackPath = true
    else if(!bFoundSafePath && inArray(pseudoSafeMovements, aggroMap[mapIndex]))
      distance = getCellDistance(aggroMap[mapIndex], MAP_CENTER)
      if(!bFoundAttackPath || distance < bestPathDistanceToMiddle)
        bestPathDistanceToMiddle = distance
        path = [aggroMap[mapIndex]]
        bFoundPseudoSafePath = true
        bFoundAttackPath = true
    else
      subMovement = getMovements(aggroMap[mapIndex], getMP() - getPathLength(getCell(), aggroMap[mapIndex]))
      subMovementIndex = 0
      while(subMovementIndex < count(subMovement))
        if(inArray(safeMovements, subMovement[subMovementIndex]))
          distance = getCellDistance(aggroMap[mapIndex], MAP_CENTER)
          if (!bFoundAttackPath || distance < bestPathDistanceToMiddle)
            bestPathDistanceToMiddle = distance
            path = [aggroMap[mapIndex], subMovement[subMovementIndex]]
            bFoundSafePath = true
            bFoundAttackPath = true
        subMovementIndex++
    mapIndex++

  if !(bFoundAttackPath && bFoundSafePath)
    while(cellIndex < count(movements))
      distance = getCellDistance(movements[cellIndex], MAP_CENTER)
      if(inArray(safeMovements, movements[cellIndex]))
        if(!bFoundSafePath || distance < bestPathDistanceToMiddle)
          bFoundSafePath = true
          path = [movements[cellIndex]]
          bestPathDistanceToMiddle = distance
      else if(!bFoundSafePath && inArray(pseudoSafeMovements, aggroMap[mapIndex]))
        if(!bFoundAttackPath || distance < bestPathDistanceToMiddle)
          bFoundPseudoSafePath = true
          path = [movements[cellIndex]]
          bestPathDistanceToMiddle = distance
      else if(!bFoundSafePath && !bFoundPseudoSafePath)
        if(!bFoundAttackPath || distance < bestPathDistanceToMiddle)
          path = [movements[cellIndex]]
          bestPathDistanceToMiddle = distance
      cellIndex++

  debug("bFoundSafePath:")
  debug(bFoundSafePath)
  debug("bFoundPseudoSafePath:")
  debug(bFoundPseudoSafePath)
  debug("bFoundAttackPath")
  debug(bFoundAttackPath)
  debug("path")
  debug(path)

  moveAndAttackInPath(path)
  return
main()
debug("Instructions:")
debug(getOperations())
