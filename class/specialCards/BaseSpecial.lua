-- Load the classes helper file
local classes = require "class.classes"
local Card = require "class.Card"
local BaseSpecial = classes.class(Card)

function BaseSpecial:init(_type, _seed, _value)
    self.super:init(_type, _seed, _value)

    -- self.seed = {
    --     label = "Special",
    --     bg = {240, 141, 179},
    --     textColor = {0, 0, 0},
    -- }

    -- self.ui.dragging = { active = false, diffX = 0, diffY = 0 }
    -- screenWidth, screenHeight = love.graphics.getDimensions()
    -- self.ui.x = screenWidth - (self.ui.width + 20)
end

function BaseSpecial:play()
    print("play")
end

function BaseSpecial:mousePressed(x, y, button)
    if tonumber(button) == 1
    and x > self.ui.x and x < self.ui.x + self.ui.width
    and y > self.ui.y and y < self.ui.y + self.ui.height
    then
        self.ui.dragging.active = true
        self.ui.dragging.diffX = x - self.ui.x
        self.ui.dragging.diffY = y - self.ui.y
    end
end

function BaseSpecial:update(dt)
    if self.ui.dragging.active then
        self.ui.x = love.mouse.getX() - self.ui.dragging.diffX
        self.ui.y = love.mouse.getY() - self.ui.dragging.diffY
    end
end

function BaseSpecial:draw(prevX, prevY)

    self.ui.x = prevX + 50
    self.ui.y = prevY

    love.graphics.setColor(self.ui.color)
    love.graphics.rectangle("fill", self.ui.x, self.ui.y, self.ui.width, self.ui.height, self.ui.cornerRadius)

    -- Draw card border
    love.graphics.setColor(self.ui.borderColor)
    love.graphics.setLineWidth(self.ui.borderWidth)
    love.graphics.rectangle("line", self.ui.x, self.ui.y, self.ui.width, self.ui.height, self.ui.cornerRadius)

    -- Draw suit and rank
    love.graphics.setColor(self.ui.textColor)
    local fontSize = 24
    love.graphics.setNewFont(fontSize)
    love.graphics.print(self.ui.rank, self.ui.x + 5, self.ui.y + 5)
    love.graphics.print(self.ui.suit, self.ui.x + 5 , self.ui.y + self.ui.height - fontSize - 5)
end

return BaseSpecial