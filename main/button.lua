Button = {x = 0, y = 0, height = 0, width = 0}
Button.__index = Button

---Creates an object 
---@param x integer x-coordinate
---@param y integer y-coordinate
---@param height integer the height of the button
---@param width integer the width of the button
---@param func function the intended function of the button
---@param name string the display name of the button
---@return table object returns the created object
function Button:new( x, y, height, width, func, name)
    local obj = setmetatable({}, Button)
    obj.x = x or 0
    obj.y = y or 0
    obj.height = height or 0
    obj.width = width or 0
    obj.func = func or nil
    obj.name = name or "blank"

    return obj

end

---Draws the button on the screen
---@param obj table
function Button:drawBtn(obj)
    love.graphics.rectangle("fill", obj.x, obj.y, obj.width, obj.height)

    --Print the displayed name of the button
    love.graphics.print({{0,0,0}, obj.name}, (obj.x + (obj.x + obj.width))/2 + #obj.name/2, 
    (obj.y+ (obj.y + obj.height))/2)
end