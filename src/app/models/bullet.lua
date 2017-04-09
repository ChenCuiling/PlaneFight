
local bullet = class("bullet")

function bullet:ctor()
    bullet.super.ctor(self)
    self.speed_ = 1.0
    self.touchRange_ = 50
	self.position_ = cc.p(0, 0)
    self.dist_ = 0
    self.destination_ = cc.p(0, 0)
    self.speed_ = 1
end

function bullet:getPosition()
    return self.position_
end

function bullet:getRotation()
    return self.rotation_
end

function bullet:getDist()
    return self.dist_
end

function bullet:setDestination(destination)
    self.destination_ = clone(destination)
    self.dist_ = math.random(display.width / 2 + 100, display.width / 2 + 200)

    local rotation = 270  --math.random(0, 360)
    self.position_ = self:calcPosition(rotation, self.dist_, destination)
    self.rotation_ = rotation - 180
    return self
end

local fixedDeltaTime = 1.0 / 60.0
function bullet:step(dt)
    self.dist_ = self.dist_ - self.speed_ * (dt / fixedDeltaTime)
    self.position_ = self:calcPosition(self.rotation_ + 180, self.dist_, self.destination_)
    return self
end

function bullet:calcPosition(rotation, dist, destination)
    local radians = rotation * math.pi / 180
    return cc.p(destination.x + math.cos(radians) * dist,
                destination.y - math.sin(radians) * dist)
end


return bullet