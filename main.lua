require("player")
require("ball")
require("ai")

---Load the entities 
function love.load()
   Player:load()
   Ball:load()
   AI:load()

   Score = {player = 0, ai = 0}
end

---Update the game by each frames
---@param dt integer to adopt to the computer spec
function love.update(dt)
   Player:update(dt)
   Ball:update(dt)
   AI:update(dt)
end

---Draw stuff on the screen
function love.draw()
   Player:draw()
   Ball:draw()
   AI:draw()

   love.graphics.print("Player: "..Score.player, 50, 50)
   love.graphics.print("Baddie: "..Score.ai, 1000, 50)
end

---Checks if there's collision between two entities
---@param a table the first entity
---@param b table the second entity
---@return boolean
function checkCollision(a, b)
   if a.x + a.width > b.x and a.x < b.x + b.width and a.y + a.height > b.y and a.y < b.y + b.height then
      return true
   else
      return false
   end
end

---Checks if within the boundary of the screen
---@param entity table the entity
function CheckBoundaries(entity)
   if entity.y < 0 then
      entity.y = 0
   elseif entity.y + entity.height > love.graphics.getHeight() then
      entity.y = love.graphics.getHeight() - entity.height
   end
end
