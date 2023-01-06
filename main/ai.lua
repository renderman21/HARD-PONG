
---Initialize the object
AI = {}


function AI:load()
   self.width = 20
   self.height = 100
   self.x = FULL_WINDOW_WIDTH - self.width - 50
   self.y = FULL_WINDOW_HEIGHT / 2
   self.yVel = 0
   self.speed = 500

   self.timer = 0
   self.rate = 0
end

---set the difficulty 
---@param difficultyInt integer the set difficulty
function AI:setDifficulty(difficultyInt)
   self.rate = difficultyInt
end

function AI:update(dt)
   self:move(dt)
   CheckBoundaries(AI)
   self.timer = self.timer + dt
   if self.timer > self.rate then
      self.timer = 0
      self:acquireTarget(dt)
   end

end

function AI:move(dt)
   self.y = self.y + self.yVel * dt
end

---Tracks the ball
---@param dt unknown delta time
function AI:acquireTarget(dt)
   if Ball.y + Ball.height < self.y then
      self.yVel = -self.speed
   elseif Ball.y > self.y + self.height then
      self.yVel = self.speed
   else
      self.yVel = 0
   end
end


function AI:draw()
   love.graphics.setColor(255,0,0)
   love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
   
end
