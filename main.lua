--require('lib.scenery.scenery')('splash'):hook(love)
local SceneryInit = require("lib.scenery.scenery")
local scenery = SceneryInit(
    { path = "scenes.splash"; key = "splash" },
    { path = "scenes.playScreen"; key = "playScreen" }
)
scenery:hook(love)