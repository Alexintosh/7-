local gradientBg = require("ui.gradientBg")
local splash = {}

-- Window dimensions
local windowWidth, windowHeight = love.graphics.getDimensions()

function splash:load()
    gradientBg:load()
    self.counter = 0

    logo = love.graphics.newImage("assets/logo.png")
    scaleX, scaleY = 0.5, 0.5
    imageX = (windowWidth - (logo:getWidth() * scaleX)) / 2
    imageY = (windowHeight - (logo:getHeight() * scaleY)) / 2
end


function splash:goTo()
    self.setScene("playScreen")
end


function splash:update(dt)
    imageX = (windowWidth - (logo:getWidth() * scaleX)) / 2
    imageY = (windowHeight - (logo:getHeight() * scaleY)) / 2

    self.counter = self.counter + dt

    if self.counter > 2 then
        self.setScene("playScreen")
    end
end

function splash:draw()
    gradientBg:draw()
    love.graphics.draw(logo, imageX, imageY, 0, scaleX, scaleY)
end

return splash