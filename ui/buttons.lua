-- Load the classes helper file
local classes = require "class.classes"
local inspect = require "lib.inspect"
local Buttons = classes.class() -- Create a class without any parent

function Buttons:init()
    self.elements = {}
end

function Buttons:add(conf)
    table.insert(self.elements, {
        text = conf.text and conf.text or "Text",
        x = conf.x and conf.x or 100,
        y = conf.y and conf.y or 100,
        cornerRadius = 10,
        borderWidth = 5,
        width = conf.width and conf.width or 200,
        height = conf.height and conf.height or  50,
        onClick = conf.onClick and conf.onClick or function()
            print("click")
        end
    })
end

function Buttons:draw()
    for _, button in ipairs(self.elements) do
        love.graphics.setColor(0, 0, 0)
        love.graphics.rectangle("line", button.x, button.y, button.width, button.height, button.cornerRadius)
        love.graphics.setColor(0, 0, 0)
        love.graphics.printf(button.text, button.x, button.y + button.height / 4, button.width, "center")
    end
end

function Buttons:handleEvents(x, y, button, istouch, presses)
    if button == 1 then -- left mouse button
        for _, b in ipairs(self.elements) do
            if x > b.x and x < b.x + b.width and y > b.y and y < b.y + b.height then
                b.onClick()
            end
        end
    end
end

return Buttons
