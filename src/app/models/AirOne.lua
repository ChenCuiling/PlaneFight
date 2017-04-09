
local AirBase = import(".AirBase")

local AirOne = class("AirOne", AirBase)

function AirOne:ctor()
    AirOne.super.ctor(self)
    self.type_ = AirBase.AIR_TYPE_AIRONE
    self.speed_ = 1.5
    self.touchRange_ = 70
end

return AirOne
