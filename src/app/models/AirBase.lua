
local AirBase = class("AirBase")

AirBase.AIR_TYPE_ONE = "ONE"
AirBase.AIR_TYPE_TWO = "TWO"

function AirBase:ctor()
    self.position_ = cc.p(0, 0)
    self.rotation_ = 0
    self.type_ = nil
    self.dist_ = 0
    self.destination_ = cc.p(0, 0)
    self.speed_ = 1
    self.touchRange_ = 0
end

function AirBase:getType()
    return self.type_
end

function AirBase:getPosition()
    return self.position_
end

function AirBase:getRotation()
    return self.rotation_
end

function AirBase:getDist()
    return self.dist_
end

function AirBase:setDestination(destination)
    self.destination_ = clone(destination)
    self.dist_ = math.random(display.width / 2 + 100, display.width / 2 + 200)

    --local rotation = math.random(0, 360)
	local rotation = 270
    self.position_ = cc.p(math.random(0,display.width),self.dist_) --self:calcPosition( rotation, self.dist_, destination)
	--self.position_ = cc.p(math.random(0,display.width),0)
    self.rotation_ = rotation - 180
    return self
end

local fixedDeltaTime = 1.0 / 60.0
function AirBase:step(dt)
    self.dist_ = self.dist_ - self.speed_ * (dt / fixedDeltaTime)
    --self.position_ = self:calcPosition(self.rotation_ + 180, self.dist_, self.destination_)
	self.position_ = self:calcPosition(self.rotation_ + 180,self.dist_, self.destination_) 
    return self
end

function AirBase:calcPosition(rotation,dist, destination) 
    local radians = rotation * math.pi / 180
    return cc.p( destination.x +  math.cos(radians) *dist,--math.random(0,display.width),
				destination.y - math.sin(radians) * dist)--
end

function AirBase:checkTouch(x, y)
    local dx, dy = x - self.position_.x, y - self.position_.y
    local offset = math.sqrt(dx * dx + dy * dy)
    return offset <= self.touchRange_
end

return AirBase
