

Ball = {}


function Ball:load()
   self.x = FULL_WINDOW_WIDTH/ 2
   self.y = FULL_WINDOW_HEIGHT / 2
   self.width = 20
   self.height = 20
   self.speed = 500
   self.xVel = -self.speed
   self.yVel = 0
   
   self.sound = love.audio.newSource("assets/sfx/hit.ogg","stream")
end


function Ball:update(dt)
   self:move(dt)
   self:collide()
end


function Ball:collide()

   --Checks if bounce
   if checkCollision(self, Player) then
      self:ballEntityHit(Player, 1)
   end

   if checkCollision(self, AI) then
      self:ballEntityHit(AI, -1)
   end

   --Checks if at the edge of the screen
   self:wallBounce()

   --Checks the score
   self:score()
end

---Bounces the ball depending on which entity hit
---@param entity any
---@param mod any
function Ball:ballEntityHit(entity, mod)

   Player.speed = Player.speed + 50
   AI.speed = AI.speed + 50



   self.speed = self.speed + 100
   self.xVel = self.speed * mod
   local middleBall = self.y + self.height / 2
   local middleEntity = entity.y + entity.height / 2
   local collisionPosition = middleBall - middleEntity
   self.yVel = collisionPosition * 5

   self:playSound()

end

function Ball:playSound()
   if not self.sound:isPlaying() then
      love.audio.play(self.sound)
   end 
end

---Manage the score
function Ball:score()
   --If passed on player
   if self.x < 0 then
      self:ballReset(1)
      Score.ai = Score.ai + 1
   end
   --If passed on enemy
   if self.x + self.width > FULL_WINDOW_WIDTH then
      self:ballReset(-1)
      Score.player = Score.player + 1
   end
end

---Resets according to which side had pass
---@param mod integer changes the direction of the velocity
function Ball:ballReset(mod)
   --Reset speed
   self.speed = 500 
   Player.speed = 500
   AI.speed = 500


   self.x = FULL_WINDOW_WIDTH/ 2 - self.width / 2
   self.y = FULL_WINDOW_HEIGHT / 2 - self.height / 2
   self.yVel = 0
   self.xVel = mod * self.speed
end

---Bounce off the wall
function Ball:wallBounce()
   if self.y < 0 then
      self.y = 0
      self.yVel = -self.yVel
   elseif self.y + self.height > FULL_WINDOW_HEIGHT then
      self.y = FULL_WINDOW_HEIGHT - self.height
      self.yVel = -self.yVel
   end
end

---Move the ball
---@param dt unknown
function Ball:move(dt)
   self.x = self.x + self.xVel * dt
   self.y = self.y + self.yVel * dt
end


function Ball:draw()
   love.graphics.setColor(255,255,255)
   love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
