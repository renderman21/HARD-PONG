---This is the line that is shown in the center of the screen

Line = {}

function Line:load()
    self.x = FULL_WINDOW_WIDTH/ 2
    self.y = 0
    self.width = 20
    self.height = FULL_WINDOW_HEIGHT
end

function Line:draw()
    love.graphics.setColor(255,255,0)
    love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
end
