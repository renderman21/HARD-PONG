
Player = {}

function Player:load()
   self.x = 50
   self.y = FULL_WINDOW_HEIGHT / 2
   self.width = 20
   self.height = 100
   self.speed = 500
end


function Player:update(dt)
   self:move(dt)
   CheckBoundaries(Player)
end

---Move according to the buttons being pressed
---@param dt unknown delta time
function Player:move(dt)
   if love.keyboard.isDown("w") then
      self.y = self.y - self.speed * dt
   elseif love.keyboard.isDown("s") then
      self.y = self.y + self.speed * dt
   end
end


function Player:draw()
   love.graphics.setColor(0,0,255)
   love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
