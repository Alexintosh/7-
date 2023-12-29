-- Load the classes helper file
local classes = require "class.classes"

local Card = classes.class() -- Create a class without any parent

Card.Types = {
    Base = 1,
    Special = 2,
}

Card.Suits = {
    Oro = 1,
    Mazze = 2,
    Spade = 3, 
    Coppe = 4
}

Card.Seeds = {
    "Oro",
    "Mazze",
    "Spade",
    "Coppe"
}

function Card:init(_type, _seed, _value)
    if Card.Types[_type] == nil then error("!type") end
    -- if Card.Suits[_seed] == nil then error("!seed") end
    if _value < 0 or _value > 10 then error("!value") end
    
    self.type = _type
    self.seed = Card.Seeds[_seed]
    self.value = _value
end

return Card