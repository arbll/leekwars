getMovements = (fromCell, MP) ->
  mov = gridLozenge(fromCell, 0, MP, true, false)
  validMov = []
  movementIndex = 0
  while(movementIndex < count(mov))
    if(getPathLength(mov[movementIndex], fromCell) <= MP)
      push(validMov, mov[movementIndex])
    movementIndex++
  return validMov

getAggroMap = (cellId, MP) ->
  targets = []
  movements = getMovements(cellId, MP)
  enemyIndex = 0
  while(enemyIndex < count(enemies))
    movementIndex = 0
    while(movementIndex < count(movements))
      map = getDangerMap(getLeek(), movements[movementIndex], true)
      if(inArray(map, getCell(enemies[enemyIndex])))
        push(targets, movements[movementIndex])
      movementIndex++
    enemyIndex++
  return targets

moveToCell = (cell) ->
  moveTowardCell(cell)
  return

attackAnything = () ->
  bFound = false
  j = 0
  while(!bFound && j < count(enemies))
    continue while(useChip(CHIP_SPARK, enemies[j]) > 0)
    if weaponCanAttack(getWeapon(), getCell(), getCell(enemies[j])) #FIXME: Find best weapon
      bFound = true
      continue while(useWeapon(enemies[j]) > 0)
    j++
  return

moveAndAttackInPath = (path) ->
  i = 0
  while(i < count(path))
    attackAnything()
    moveToCell(path[i])
    attackAnything()
    i++
  return
