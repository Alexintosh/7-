local Deck = require "class.Deck"
local Game = require "class.Game"
local inspect = require "lib.inspect"

local deck
local game
local buttons = {}


function love.load()
    -- Run once at game initialization
    deck = Deck.new()
    deck:shuffle()
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
  -- Called at every frame to draw the game
  -- Draw card rectangle
  love.graphics.rectangle("line", card.x, card.y, card.width, card.height)

  -- Draw text inside the card
  -- Adjust the text position as needed
  love.graphics.printf(card.text, card.x, card.y + card.height / 2, card.width, "center")


  -- Bottoni
    for _, button in ipairs(buttons) do
        love.graphics.rectangle("line", button.x, button.y, button.width, button.height)
        love.graphics.printf(button.text, button.x, button.y + button.height / 4, button.width, "center")
    end
end
