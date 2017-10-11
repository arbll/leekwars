weaponSelect = (weaponId) ->
  if getWeapon() != weaponId
    setWeapon(weaponId)

weaponBestRange = ->
  max = -1
  i = 0
  while i < count(pWeapons)
    range = getWeaponMaxRange(pWeapons[i])
    if(range > max)
      max = range
      maxWeapon = pWeapons[i]
    i++
  maxWeapon

weaponLeekBestRange = (leekId) ->
  lWeapons = getWeapons(leekId)
  max = -1
  i = 0
  while i < count(lWeapons)
    range = getWeaponMaxRange(lWeapons[i])
    if(range > max)
      max = range
      maxWeapon = lWeapons[i]
    i++
  maxWeapon

weaponBestDamageOnTarget = (targetId) ->


weaponCanAttack = (weaponId, fromCell, toCell) ->
  distance = getCellDistance(fromCell, toCell)
  if(weaponNeedLos(weaponId) && !lineOfSight(fromCell, toCell))
    false
  else if(isInlineWeapon(weaponId) && !isOnSameLine(fromCell, toCell))
    false
  else if (getWeaponMinRange(weaponId) > distance || getWeaponMaxRange(weaponId) < distance)
    false
  else
    true
