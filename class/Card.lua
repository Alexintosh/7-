-- Load the classes helper file
local classes = require "class.classes"
flux = require "lib.flux"
local Card = classes.class() -- Create a class without any parent

Card.Types = {
    Base = 1,
    Special = 2,
}

Card.Suits = {
    Oro = 1,
    Mazze = 2,
    Spade = 3, 
    Coppe = 4,
    Special = 5
}

Card.Seeds = {
    {
        label = "Oro",
        bg = {255, 233, 166},
        textColor = {0, 0, 0},
    },
    {
        label = "Mazze",
        bg = {14, 235, 172},
        textColor = {0, 0, 0},
    },
    {
        label = "Spade",
        bg = {125, 136, 219},
        textColor = {0, 0, 0},
    },
    {
        label = "Coppe",
        bg = {240, 141, 179},
        textColor = {0, 0, 0},
    },
    {
        label = "Special",
        bg = {240, 141, 179},
        textColor = {0, 0, 0},
    },
}

cardBack = {
    x = 100,
    y = 100,
    width = 80,
    height = 120,
    color = {0.1, 0.4, 0.8}, -- Dark blue
    patternColor = {0.7, 0.7, 0.7}, -- Light color for pattern
    patternSpacing = 20 -- Space between pattern elements
}

function Card:init(_type, _seed, _value)
    if Card.Types[_type] == nil then error("!type") end
    -- if Card.Suits[_seed] == nil then error("!seed") end
    if _value < 0 or _value > 10 then error("!value") end
    
    self.type = _type
    self.seed = Card.Seeds[_seed]
    self.value = _value
    self.ui = {
        x = 100,
        y = 100,
        width = 80,
        height = 120,
        cornerRadius = 10,
        borderWidth = 5,
        suit = self.seed.label,
        rank = (self.value > 7) and "/" or self.value,
        color = {self.seed.bg[1] / 255, self.seed.bg[2] / 255, self.seed.bg[3] / 255},
        borderColor = {0, 0, 0}, -- Black
        textColor = {self.seed.textColor[1] / 255, self.seed.textColor[2] / 255, self.seed.textColor[3] / 255},
    }
end

function Card:getVal()
    if self.value > 7 then 
        return 0.5 
    else 
        return self.value
    end
end

function Card:draw(prevX, prevY)

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

function Card:drawBack(prevX, prevY)

    cardBack.x = prevX + 50
    cardBack.y = prevY

    self.ui.x = prevX + 50
    self.ui.y = prevY
    -- Draw card back
    love.graphics.setColor(cardBack.color)
    love.graphics.rectangle("fill", cardBack.x, cardBack.y, cardBack.width, cardBack.height)

    -- Draw pattern on card back
    love.graphics.setColor(cardBack.patternColor)
    for i = cardBack.x, cardBack.x + cardBack.width, cardBack.patternSpacing do
        for j = cardBack.y, cardBack.y + cardBack.height, cardBack.patternSpacing do
            love.graphics.circle("fill", i, j, 5) -- Draw small circles as the pattern
        end
    end
end

return Card