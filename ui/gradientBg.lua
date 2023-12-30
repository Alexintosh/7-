local Color = require "lib.hex2color.hex2color"


local gradientBg = {}
-- Window dimensions

function gradientBg:load()
    windowWidth, windowHeight = love.graphics.getDimensions()
    -- Gradient colors
    local startColor = Color("#fffae5") -- Blue
    local endColor = Color("#ffead3") -- Red

    -- Calculate color steps
    local colorStep = {
        (endColor[1] - startColor[1]) / windowHeight,
        (endColor[2] - startColor[2]) / windowHeight,
        (endColor[3] - startColor[3]) / windowHeight
    }

    -- Create gradient data
    gradientData = {}
    for i = 0, windowHeight do
        table.insert(gradientData, {
            startColor[1] + colorStep[1] * i,
            startColor[2] + colorStep[2] * i,
            startColor[3] + colorStep[3] * i
        })
    end
end


function gradientBg:draw()
    for i, color in ipairs(gradientData) do
        love.graphics.setColor(color)
        love.graphics.rectangle("fill", 0, i - 1, love.graphics.getWidth(), 1)
    end
end

return gradientBg