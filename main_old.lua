require("lib.lovedebug")
local Deck = require "class.Deck"
local Game = require "class.Game"
local Modal = require "class.UI"
local inspect = require "lib.inspect"
local Color = require "lib.hex2color.hex2color"
local lue = require "lib.lue.lue"


local deck
local game
local ui
local buttons = {}


function love.load()
    -- Set Background Color to #1b8724 (27, 135, 36)
    -- Note: Remember that Love uses 0-1 and not 0-255
    lue:setColor("my-color", {255, 255, 255})

    color = Color("#ea306d")
    love.graphics.setBackgroundColor( color)

    -- Run once at game initialization
    deck = Deck.new()
    ui = Modal.new()
    game = Game.new(deck, ui)

    ui:show("Sette e mezz'", 2)


    buttons = {
        {
            text = "Mi sto",
            x = 100,
            y = 500,
            cornerRadius = 10,
            borderWidth = 5,
            width = 200,
            height = 50,
            onClick = function()
                game:playerStay()
            end
        },
        {
            text = "Carta",
            x = 450,
            y = 500,
            width = 200,
            height = 50,
            cornerRadius = 10,
            borderWidth = 5,
            onClick = function()
                game:handleRound()
                print("--- \n")
            end
        }
    }
end

function love.keypressed(key, scancode, isrepeat)
    -- Run each time a key on the keyboard is pressed
    print("key", key)
    if key == "up" then
        if game.round.nextState == Game.StateOptions.End then
            game:newRound()
            game:handleRound()
        end
    elseif key == "left" then
        game:playerStay()
    elseif key == "right" then
        game:handleRound()
    else
    end

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
    require("lib.lovebird").update()

    lue:update(dt)

    -- Run at each frame before drawing it
    -- This is where you handle most of your game logic
    ui:update(dt)
end

function love.draw()
    love.graphics.setColor( lue:getColor("my-color") )

    ui:draw()
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
        love.graphics.rectangle("line", button.x, button.y, button.width, button.height, button.cornerRadius)
        love.graphics.printf(button.text, button.x, button.y + button.height / 4, button.width, "center")
    end
end
