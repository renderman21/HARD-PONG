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
      2.3 Add an about page tho lol
   3. Add some bit of bells and whistles  
      3.1 Hit sounds [DONE]   
   4. Print velocity in the corner of the screen
   5. Screen shakes (for another time)
]]

require "player"
require "ball"
require"ai"
require "midLine"
require "button"

---Load the entities 
function love.load()
   TitleScreen = true
   SelectDifScreen = false

   DifficultyRate = 0
   
   --DO NOT CHANGE THESE VALUES
   FULL_WINDOW_HEIGHT = love.graphics.getHeight()
   FULL_WINDOW_WIDTH = love.graphics.getWidth()

   StartBtn = Button:new((FULL_WINDOW_WIDTH - 50)/ 2, FULL_WINDOW_HEIGHT / 2
   , 50, 100, function ()
      TitleScreen = false
   end, "Start")

   SelectDifBtn = Button:new((FULL_WINDOW_WIDTH - 50)/2, (FULL_WINDOW_HEIGHT/2) + 100,
   50, 100, function()
      SelectDifScreen = true
   end, "Select Dificulty")

   --Buttons for each Dificulty--
   EasyBtn = Button:new((FULL_WINDOW_WIDTH - 50)/ 2,  FULL_WINDOW_HEIGHT / 2,
   50, 100, function()
      AI:setDifficulty(0.50)
      Ball:setDifficulty(200, 10)
      SelectDifScreen = false
   end, "Easy")

   MediumBtn = Button:new((FULL_WINDOW_WIDTH - 50)/ 2,  (FULL_WINDOW_HEIGHT / 2) + 100,
   50, 100, function()
      AI:setDifficulty(0.25)
      Ball:setDifficulty(350, 20)
      SelectDifScreen = false
   end, "Medium")

   HardBtn = Button:new((FULL_WINDOW_WIDTH - 50)/ 2, (FULL_WINDOW_HEIGHT / 2) + 200, 
   50, 100, function()
      AI:setDifficulty(-0.01)
      Ball:setDifficulty(500, 40)
      SelectDifScreen = false
   end, "Hard")

   Player:load()
   Ball:load()
   AI:load()
   Line:load()

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

---This takes care on drawing the mainMenu
local function mainMenuDraw()
   if TitleScreen and not SelectDifScreen then
      Button:drawBtn(StartBtn)
      Button:drawBtn(SelectDifBtn)
   elseif TitleScreen and SelectDifScreen then -- Draw difficulty Buttons
      Button:drawBtn(EasyBtn)
      Button:drawBtn(MediumBtn)
      Button:drawBtn(HardBtn)
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
   else 
      mainMenuDraw()
   end
end

---Checks the position of the mouse
---@param obj table the button that is being referenced
---@param x integer the x position
---@param y integer the y position
---@param button integer the pressed button 
---@return boolean 
local function checkMousePosition(obj, x, y, button) 
   if x >= obj.x and obj.width + obj.x >= x and y >= obj.y and obj.height + obj.y >= y and 
   button == 1 then
      return true
   else
      return false
   end
end

---This is takes care the titleScreen section
---@param x integer the x-position
---@param y integer the y-position
---@param button integer the button that is being pressed
local function titleSection(x,y,button) 
   if checkMousePosition(StartBtn, x, y, button) then
      StartBtn.func()

   elseif checkMousePosition(SelectDifBtn, x, y, button)then
      SelectDifBtn.func()
   end
end

---This takes care during the select difficulty segment
---@param x integer the x-position
---@param y integer the y-position
---@param button integer the button that is being pressed
local function difSelectSection(x,y,button)
   
   if checkMousePosition(EasyBtn,x,y,button)then
      EasyBtn.func()
   elseif checkMousePosition(MediumBtn, x,y,button) then
      MediumBtn.func()
   elseif checkMousePosition(HardBtn, x,y,button) then
      HardBtn.func()
   end
   
   
end

---Gets the position of the mouse and checks if there is a mouse press on the buttons
---@param x integer the position of the mouse at its X-Axis
---@param y integer the position of the mouse at its Y-Axis
function love.mousepressed(x, y, button)
   if TitleScreen and not SelectDifScreen then
      titleSection(x,y,button)
   elseif SelectDifScreen then
      difSelectSection(x,y,button)
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
