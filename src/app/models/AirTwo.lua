
local AirBase = import(".AirBase")

local AirTwo = class("AirTwo", AirBase)

function AirTwo:ctor()
    AirTwo.super.ctor(self)
    self.type_ = AirBase.AIR_TYPE_AIRTWO
    self.speed_ = 1.0
    self.touchRange_ = 70
end

return AirTwo
