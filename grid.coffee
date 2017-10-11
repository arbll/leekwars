MAP_SIZE = 17
MAP_CENTER = 305

gridLozenge = (centerCellId, innerRadius, outerRadius, checkObstacles, shouldMark) ->
  cX = getCellX(centerCellId)
  cY = getCellY(centerCellId)
  x = cX - outerRadius
  result = []
  while(x <= cX + outerRadius)
    y = cY - outerRadius
    while(y <= cY + outerRadius)
      cell = getCellFromXY(x, y)
      if(cell != null && getCellDistance(centerCellId, cell) <= outerRadius && getCellDistance(centerCellId, cell) >= innerRadius && (!checkObstacles || !inArray(gObstacles, cell)))
        push(result, cell)
        if (shouldMark != false)
          mark(cell, shouldMark)
      y++
    x++
  result

gridLines = (centerCellId, innerRadius, outerRadius, checkObstacles, shouldMark) ->
  cX = getCellX(centerCellId)
  cY = getCellY(centerCellId)
  result = []

  x = cX - outerRadius
  while(x <= cX + outerRadius)
    cell = getCellFromXY(x, cY)
    if(cell != null && getCellDistance(centerCellId, cell) >= innerRadius && (!checkObstacles || !inArray(gObstacles, cell)))
      push(result, cell)
      if(shouldMark != false)
        mark(cell, shouldMark)
    x++

  y = cY - outerRadius
  while(y <= cY + outerRadius)
    cell = getCellFromXY(cX, y)
    if(cell != null && getCellDistance(centerCellId, cell) >= innerRadius && (!checkObstacles || !inArray(gObstacles, cell)))
      push(result, cell)
      if(shouldMark != false)
        mark(cell, shouldMark)
    y++
  result
