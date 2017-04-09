-- GameView is a combination of view and controller
local GameView = class("GameView", cc.load("mvc").ViewBase)

local AirBase   = import("..models.AirBase")
local AirTwo    = import("..models.AirTwo")
local AirOne = import("..models.AirOne")

local AirSprite = import(".AirSprite")
local DeadAirSprite = import(".DeadAirSprite")

GameView.HOLE_POSITION = cc.p(display.cx, display.cy - 200)--cc.p(math.random(0,display.width),display.y) ----
GameView.INIT_LIVES = 5
GameView.ADD_AIR_INTERVAL_MIN = 1
GameView.ADD_AIR_INTERVAL_MAX = 3

GameView.IMAGE_FILENAMES = {}
GameView.IMAGE_FILENAMES[AirBase.AIR_TYPE_ONE] = "enemy1.png"
GameView.IMAGE_FILENAMES[AirBase.AIR_TYPE_TWO] = "enemy2.png"

GameView.AIR_ANIMATION_TIMES = {}
GameView.AIR_ANIMATION_TIMES[AirBase.AIR_TYPE_ONE] = 0.15
GameView.AIR_ANIMATION_TIMES[AirBase.AIR_TYPE_TWO] = 0.1

GameView.ZORDER_AIR = 100
GameView.ZORDER_DEAD_AIR = 50

GameView.events = {
    PLAYER_DEAD_EVENT = "PLAYER_DEAD_EVENT",
}

function GameView:start()
    self:scheduleUpdate(handler(self, self.step))
    return self
end

function GameView:stop()
    self:unscheduleUpdate()
    return self
end

function GameView:step(dt)
    if self.lives_ <= 0 then return end

    self.addAIRInterval_ = self.addAIRInterval_ - dt
    if self.addAIRInterval_ <= 0 then
        self.addAIRInterval_ = math.random(GameView.ADD_AIR_INTERVAL_MIN, GameView.ADD_AIR_INTERVAL_MAX)
        self:addAIR()
    end

    for _, air in pairs(self.airs_) do
        air:step(dt)
        if air:getModel():getDist() <= 0 then
            self:AIREnterHole(air)
        end
    end

    return self
end

function GameView:getLives()
    return self.lives_
end

function GameView:getKills()
    return self.kills_
end

function GameView:addAIR()
    local airtype = AirBase.AIR_TYPE_TWO
    if math.random(1, 2) % 2 == 0 then
        airtype = AirBase.AIR_TYPE_ONE
    end

    local AirModel
    if airtype == AirBase.AIR_TYPE_TWO then
        AirModel = AirTwo:create()
    else
        AirModel = AirOne:create()
    end

    local air = AirSprite:create(GameView.IMAGE_FILENAMES[airtype], AirModel)
        :start(GameView.HOLE_POSITION)
        :addTo(self.AIRsNode_, GameView.ZORDER_AIR)

    self.airs_[air] = air
    return self
end

function GameView:AIREnterHole(air)
    self.airs_[air] = nil

    air:fadeOut({time = 0.5, removeSelf = true})
        :scaleTo({time = 0.5, scale = 0.3})
        :rotateTo({time = 0.5, rotation = math.random(360, 720)})

    self.lives_ = self.lives_ - 1
    self.livesLabel_:setString(self.lives_)
    audio.playSound("AirEnterHole.wav")

    if self.lives_ <= 0 then
        self:dispatchEvent({name = GameView.events.PLAYER_DEAD_EVENT})
    end

    return self
end

function GameView:AIRDead(air)
    local imageFilename = GameView.IMAGE_FILENAMES[air:getModel():getType()]
    DeadAirSprite:create(imageFilename)
        :fadeOut({time = 2.0, delay = 0.5, removeSelf = true})
        :move(air:getPosition())
        :rotate(air:getRotation() + 120)
        :addTo(self.AIRsNode_, GameView.ZORDER_DEAD_AIR)

    self.airs_[air] = nil
    air:removeSelf()

    self.kills_ = self.kills_ + 5
    audio.playSound("AirDead.wav")

    return self
end

function GameView:onCreate()
    self.lives_ = GameView.INIT_LIVES
    self.kills_ = 0
    self.airs_ = {}
    self.addAIRInterval_ = 0

    -- add touch layer
    display.newLayer()
        :onTouch(handler(self, self.onTouch))
	-- add background image
    display.newSprite("PlaySceneBg.jpg")
        :move(display.center)
        :addTo(self)
		
    -- add AIRs node
    self.AIRsNode_ = display.newNode():addTo(self)

    -- add lives icon and label
    display.newSprite("Star.png")
        :move(display.left + 50, display.top - 50)
        :addTo(self)
		
	-- add air image
	-- local air = cc.ONE:create("air.png")
	-- air:move(display.cx,display.cy-100)
	-- air:addTo(self)
    display.newSprite("air.png")
        :move(display.cx,display.cy-300)
        :addTo(self)
		
	-- self.killsLabel_ = cc.Label:createWithSystemFont(self.kills_, "Arial", 32)
        -- :move(display.right + 90, display.top - 50)
        -- :addTo(self)
    self.livesLabel_ = cc.Label:createWithSystemFont(self.lives_, "Arial", 32)
        :move(display.left - 90, display.top - 50)
        :addTo(self)

    -- create animation for AIRs
    for AIRType, filename in pairs(GameView.IMAGE_FILENAMES) do
        -- load image
        local texture = display.loadImage(filename)
        local frameWidth = texture:getPixelsWide() / 3
        local frameHeight = texture:getPixelsHigh()

        -- create ONE frame based on image
        local frames = {}
        for i = 0, 1 do
            local frame = display.newSpriteFrame(texture, cc.rect(frameWidth * i, 0, frameWidth, frameHeight))
            frames[#frames + 1] = frame
        end

        -- create animation
        local animation = display.newAnimation(frames, GameView.AIR_ANIMATION_TIMES[AIRType])
        -- caching animation
        display.setAnimationCache(filename, animation)
    end

    -- bind the "event" component
    cc.bind(self, "event")
end

function GameView:onTouch(event)
    if event.name ~= "began" then return end
    local x, y = event.x, event.y
    for _, AIR in pairs(self.AIRs_) do
        if AIR:getModel():checkTouch(x, y) then
            self:AIRDead(AIR)
        end
    end
end

function GameView:onCleanup()
    self:removeAllEventListeners()
end

return GameView

