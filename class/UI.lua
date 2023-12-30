local classes = require "class.classes"

local Modal = classes.class() -- Create a class without any parent

Modal.displayTime = 0

function Modal:init()
    love.window.setMode(800, 600) -- Set window size (adjust as needed)
    self.text = "Player win!"
    self.font = love.graphics.newFont(20)

    -- Cloud properties
    self.cloudRadius = 50
    self.cloudColor = {0.8, 0.8, 0.8} -- Light gray
end

function Modal:show(text, dt)
    self.text = text
    self.displayTime = dt or 5
    self.textWidth = self.font:getWidth(self.text)
    self.textHeight = self.font:getHeight(self.text)
    screenWidth, screenHeight = love.graphics.getDimensions()

    -- Text position
    self.textX = (screenWidth - self.textWidth) / 2
    self.textY = (screenHeight - self.textHeight) / 2
end

function Modal:update(dt)
    if self.displayTime > 0 then
        self.displayTime = self.displayTime - dt
    end
end

function Modal:draw()
    if self.displayTime > 0 then
        -- Draw cloud background
        love.graphics.setColor(self.cloudColor)
        local cloudCenterX = screenWidth / 2
        local cloudCenterY = screenHeight / 2
        -- Drawing overlapping circles to create a cloud effect
        love.graphics.circle("fill", cloudCenterX, cloudCenterY, self.cloudRadius)
        love.graphics.circle("fill", cloudCenterX - self.cloudRadius, cloudCenterY, self.cloudRadius)
        love.graphics.circle("fill", cloudCenterX + self.cloudRadius, cloudCenterY, self.cloudRadius)
        love.graphics.circle("fill", cloudCenterX, cloudCenterY - self.cloudRadius / 2, self.cloudRadius)

        -- Draw centered text
        love.graphics.setColor(0, 0, 0) -- Black text
        love.graphics.setFont(self.font)
        love.graphics.print(self.text, self.textX, self.textY)
    end
end

return Modal
