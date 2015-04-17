-- from: https://love2d.org/forums/viewtopic.php?p=179044#p179044
for a = 1, #boxSizeList do
   local bw, bh = boxSizeList[a][1], boxSizeList[a][2]
   local count = bw * bh
   for x = 0, #tempColMap-bw+1 do
      for y = 0, #tempColMap[1]-bh+1 do
         local _count = 0
         for bx = x, x + (bw-1) do
            for by = y, y + (bh-1) do
               if not markedGrid[bx][by] then
                  if tempColMap[bx][by] == currentTileType then
                     _count = _count + 1
                  end
               end
            end
         end
         if _count == count then
            local n = "solidWall_" .. x+1 .. "_" .. y+1
            local wallType = currentTileType

            -- Add the newly created collision box to a table that will later be used to generate the Bump collision blocks
            self.level.boxList[n] = { x = x * TILESIZE, y = y * TILESIZE, w = bw * TILESIZE, h = bh * TILESIZE, id = n, solid = true }

            for bx = x, x + (bw-1) do
               for by = y, y + (bh-1) do
                  markedGrid[bx][by] = true
               end
            end
         end
      end
   end
end