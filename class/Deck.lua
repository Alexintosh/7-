-- Load the classes helper file
local classes = require "class.classes"
local Card = require "class.Card"
local inspect = require "lib.inspect"

local Deck = classes.class() -- Create a class without any parent

Deck.maxCards = 40
Deck.maxPerType = 10
Deck.debug = false

function Deck:init()
    self:reset()
end

function Deck:reset()
    self.db = {}
    self.dealtCards = {}

    for _, suit in pairs(Card.Suits) do
        for rank = 1, 10 do
            local c = Card.new("Base", suit, rank)
            table.insert(self.db, c)
        end
    end
end

function Deck:shuffle()
    self:reset()
    for i = #self.db, 2, -1 do
        local j = math.random(i)
        self.db[i], self.db[j] = self.db[j], self.db[i]
    end
end

function Deck:deal(numberOfCards)
    if #self.db == 0 then
        print("no more cards")
        return nil
    end

    for i = 1, numberOfCards do
        if #self.db == 0 then
            error("no more cards")
            break -- Break the loop if the deck is empty
        end
        table.insert(self.dealtCards, table.remove(self.db)) -- Removes the last card and adds it to dealtCards
    end

    if Deck.debug then
        print("dc: ", #self.dealtCards)
        print("mazzo: ", #self.db)
    end

    return self.dealtCards[#self.dealtCards]
end

return Deck