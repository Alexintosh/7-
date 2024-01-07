-- Load the classes helper file
local classes = require "class.classes"
local inspect = require "lib.inspect"
local Score = classes.class() -- Create a class without any parent

function Score:init()
    self.elements = {}
end

function Score:add(conf)
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

function Score:draw()
    for _, button in ipairs(self.elements) do
        love.graphics.setColor(0, 0, 0)
        love.graphics.printf(button.text, button.x, button.y + button.height / 4, button.width, "center")
    end
end

return Buttons
