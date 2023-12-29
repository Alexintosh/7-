-- Load the classes helper file
local classes = require "class.classes"
local inspect = require "lib.inspect"

local Game = classes.class() -- Create a class without any parent

Game.StateOptions = {
    PlayerDue = 1,
    AIDue = 2, 
    End = 3,
    Deal = 4
}

Game.PlayerOptions = {
    Bet = 1,
    Call = 2,
    Stay = 3
}

Game.Rules = {
    maxValue = 7.5,
}

function Game:init(deck)
    self.started = true
    self.points = { 
        player = 0, 
        ai = 0,
    }
    self.deck = deck
    self:newRound()
end

function Game:newRound() 
    self.round = {
        playerCards = {},
        aiCards = {},
        nextState = Game.StateOptions.Deal
    }
end

function Game:calcPlayerHand()
    local total = 0
    for i = 1, #self.round.playerCards do
        if total + self.round.playerCards[i].value > 7 then 
            total = total + 0.5 
        else 
            total = total + self.round.playerCards[i].value 
        end
    end
    return total
end

function Game:calcAiHand()
    local total = 0
    for i = 1, #self.round.aiCards do
        if total + self.round.aiCards[i].value > 7 then 
            total = total + 0.5 
        else 
            total = total + self.round.aiCards[i].value 
        end
    end
    return total
end

function Game:endRound()
    if self:calcPlayerHand() > Game.Rules.maxValue then
        print("Banco wins")
        self.points.ai = self.points.ai + 1;
    elseif self:calcPlayerHand() == self:calcAiHand() then
        print("Banco wins")
        self.points.ai = self.points.ai + 1;
    else
        print("Player wins")
        self.points.player = self.points.player + 1;
    end

    self.round.nextState = Game.StateOptions.End
    print("Scoring")
    print("--------------")
    print("Player / Banco")
    print("--------------")
    print("  " .. self.points.player .. " | " .. self.points.ai)
    print("--------------")

    self:newRound()
end

function Game:handleRound()
    print("round.nextState", self.round.nextState)

    if self.round.nextState == Game.StateOptions.Deal then
        -- Give card to player
        local playerLastCard = self.deck:deal(1)
        
        if playerLastCard then
            table.insert(self.round.playerCards, playerLastCard)
            print("player card: ",  playerLastCard.value .. " ".. playerLastCard.seed .. " / Total: ".. self:calcPlayerHand())
        else 
            print('!cards')
            return
        end
        -- Give card to AI
        table.insert(self.round.aiCards, self.deck:deal(1))
        local bancoLastCard = self.round.aiCards[#self.round.aiCards]
        print("bancoLastCard: ",  bancoLastCard.value .. " ".. bancoLastCard.seed.. " / Total: ".. self:calcAiHand())
        self.round.nextState = Game.StateOptions.PlayerDue
        return
    end

    if self.round.nextState == Game.StateOptions.PlayerDue then
        -- Give card to player
        table.insert(self.round.playerCards, self.deck:deal(1) )
        local playerLastCard = self.round.playerCards[#self.round.playerCards]

        print("player card: ",  playerLastCard.value .. " ".. playerLastCard.seed .. " / Total: ".. self:calcPlayerHand())

        local bancoLastCard = self.round.aiCards[#self.round.aiCards]
        print("bancoLastCard: ",  bancoLastCard.value .. " ".. bancoLastCard.seed.. " / Total: ".. self:calcAiHand())

        -- if not palazzo then it's player's turn again
        if self:calcPlayerHand() > 7.5 then
            print("palazzo")
            self:endRound()
        else 
            self.round.nextState = Game.StateOptions.PlayerDue
        end
        return
    end

    if self.round.nextState == Game.StateOptions.AIDue then
        -- Give card to player
        local aiLastCard = self.deck:deal(1)
        table.insert(self.round.aiCards, aiLastCard)
        local playerLastCard = self.round.playerCards[#self.round.playerCards]
        
        print("player card: ",  playerLastCard.value .. " ".. playerLastCard.seed .. " / Total: ".. self:calcPlayerHand())
        print("bancoLastCard: ",  aiLastCard.value .. " ".. aiLastCard.seed.. " / Total: ".. self:calcAiHand())

        if self:calcAiHand() >= 7.5 then
            self:endRound()
        else
            self:handleRound()
        end
    end
end

function Game:playerStay()
    print("playerStay")
    if self.round.nextState == Game.StateOptions.PlayerDue then
        self.round.nextState = Game.StateOptions.AIDue
    end
    self:handleRound()
end

return Game