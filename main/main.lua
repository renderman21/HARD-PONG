--[[
   TODO: 
   NOTE: We should focus sa gists huwag muna tayo magadd ng mga features na hindi naman 
   talaga sa ating pakay
   Add the following features:
   1. Fast ball
      1.1 For each hit, increase the speed of the ball by either 100 or something less [DONE]
      1.2 This also increases the speed for both the AI and Player [DONE]
      1.3 Pero, kahit isa sa kanila'y nagkaroon ng score, reset the speed back to zero [DONE]
   2. Add a menu
      2.1 Yes, this is important
      2.2 This will also show the difficulties? Tas pwede kung AI yung player o since, may 
      dalawa pa kayo? 
   3. Add some bit of bells and whistles  
      3.1 Hit sounds [DONE]
]]

require "player"
require "ball"
require"ai"
require "midLine"



---Load the entities 
function love.load()

   --DO NOT CHANGE THESE VALUES
   FULL_WINDOW_HEIGHT = love.graphics.getHeight()
   FULL_WINDOW_WIDTH = love.graphics.getWidth() 

   Player:load()
   Ball:load()
   AI:load()
   Line:load()
   
   TitleScreen = true
   Score = {player = 0, ai = 0}
end

---Update the game by each frames
---@param dt integer to adopt to the computer spec
function love.update(dt)

   if not TitleScreen then
      Player:update(dt)
      Ball:update(dt)
      AI:update(dt)
   end

   if love.keyboard.isDown("escape") then
      love.event.quit(0)
   end
end

---Draw stuff on the screen
function love.draw()
   if not TitleScreen then
      Player:draw()
      Ball:draw()
      AI:draw()
      Line:draw()

      local playerScore = "Player: "..Score.player
      local baddieScore = Score.ai.." :Baddie"

      love.graphics.setColor(0,0,255) -- Set color for player
      love.graphics.print(playerScore, 0, 50)

      love.graphics.setColor(255,0,0) --Set color for the enemy
      love.graphics.print(baddieScore, (love.graphics.getWidth() - 50) - #baddieScore, 50)
   else --Show title Screen
      local title = "This is a test, press \'enter\'"
      love.graphics.print(title, FULL_WINDOW_WIDTH / 2 - #title, 
      FULL_WINDOW_HEIGHT /2 )
   end
end

---Gets the position of the mouse
---@param x integer the position of the mouse at its X-Axis
---@param y integer the position of the mouse at its Y-Axis
function love.mousemoved(x, y)
   if x >= FULL_WINDOW_WIDTH / 2 - 50 and x <= FULL_WINDOW_WIDTH /2 + 50
   and love.mouse.isDown(1) then
      TitleScreen = false      
   end
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
