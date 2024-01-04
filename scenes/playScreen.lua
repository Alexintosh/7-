require("gameconf")
if GAMECONF.inGameDebug then
    require("lib.lovedebug")
end

local playScreen = {}

---------------------------
-- Imports
---------------------------
local gradientBg = require("ui.gradientBg")
local Buttons = require("ui.buttons")
local Deck = require "class.Deck"
local Game = require "class.Game"
local Modal = require "class.UI"

---------------------------
-- Game variables
---------------------------
local deck
local game
local ui
local btn


function playScreen:load()
    gradientBg:load()

    -- Run once at game initialization
    deck = Deck.new()
    ui = Modal.new()
    game = Game.new(deck, ui)
    btn = Buttons.new()

    ---------------------------
    -- Setup local ui
    ---------------------------
    
    btn:add({
        text = "Mi sto",
        y = 500,
        onClick = function()
            game:playerStay()
        end
    })

    btn:add({
        text = "Carta",
        x = 450,
        y = 500,
        onClick = function()
            game:handleRound()
            print("--- \n")
        end
    })
    

    -- Start game
    game:newRound()
    game:handleRound()
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
    btn:handleEvents(x, y, button, istouch, presses)    
end

function playScreen:update(dt)
    require("lib.lovebird").update()
    -- Run at each frame before drawing it
    -- This is where you handle most of your game logic
    ui:update(dt)
end

function playScreen:draw()
    screenWidth, screenHeight = love.graphics.getDimensions()
    gradientBg:draw()
    ui:draw()
    self:drawCards();
    btn:draw()

    local font = love.graphics.getFont()
    --regular text
    local plainText = love.graphics.newText(font, "P:".. game.round.player.life .. " - $".. game.round.player.cash .." | " .. "AI:".. game.round.ai.life .." - $".. game.round.ai.cash)
    love.graphics.draw (plainText, 10, screenHeight - 30)

end

function playScreen:drawCards()
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
end

return playScreen
