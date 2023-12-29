local Deck = require "class.Deck"
local Game = require "class.Game"
local inspect = require "lib.inspect"

local deck
local game
local buttons = {}


function love.load()
    -- Set Background Color to #1b8724 (27, 135, 36)
    -- Note: Remember that Love uses 0-1 and not 0-255
    red = 27/255
    green = 135/255
    blue = 36/255
    color = { red, green, blue}
    love.graphics.setBackgroundColor( color)

    -- Run once at game initialization
    deck = Deck.new()
    game = Game.new(deck)
    print(inspect(game.round))


    -- Set up card properties
    card = {
        x = 100,   -- X position
        y = 100,   -- Y position
        width = 70,
        height = 100,
        text = "Ace of Spades"
    }

    buttons = {
        {
            text = "Mi sto",
            x = 100,
            y = 500,
            width = 200,
            height = 50,
            onClick = function()
                game:playerStay()
            end
        },
        {
            text = "Carta",
            x = 400,
            y = 500,
            width = 200,
            height = 50,
            onClick = function()
                game:handleRound()
                print("--- \n")
            end
        }
    }
end

function love.keypressed(key, scancode, isrepeat)
    -- Run each time a key on the keyboard is pressed
    game:newRound()
end

function love.mousepressed(x, y, button, istouch, presses)
    -- Run each time a mouse button is pressed, supports multi-touch too

    if button == 1 then -- left mouse button
        for _, b in ipairs(buttons) do
            if x > b.x and x < b.x + b.width and y > b.y and y < b.y + b.height then
                b.onClick()
            end
        end
    end
    
end

function love.update(dt)
    -- Run at each frame before drawing it
    -- This is where you handle most of your game logic
end

function love.draw()

    -- Drawing player cards to the left
    for i, card in ipairs(game.round.playerCards) do
        if i == 1 then 
            card:draw(20, 20)
        else
            card:draw(game.round.playerCards[i-1].ui.x, game.round.playerCards[i-1].ui.y)
        end
    end

    -- Drawing ai cards to the right
    for i, card in ipairs(game.round.aiCards) do
        if i == 1 then
            if game.round.nextState == Game.StateOptions.End then
                card:draw(20, 250)
            else
                card:drawBack(20, 250)
            end
        else
            card:draw(game.round.aiCards[i-1].ui.x, game.round.aiCards[i-1].ui.y)
        end
    end


    -- Bottoni
    for _, button in ipairs(buttons) do
        love.graphics.rectangle("line", button.x, button.y, button.width, button.height)
        love.graphics.printf(button.text, button.x, button.y + button.height / 4, button.width, "center")
    end
end
