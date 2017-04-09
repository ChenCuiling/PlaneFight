
local MapScene = class("MapScene", cc.load("mvc").ViewBase)

function MapScene:onCreate()
	local layerBg = cc.Layer:create():addTo(self)
	local sp1 = display.newSprite("PlaySceneBg.png")
	--sp1:move( display.cx, display.cy )
	sp1:setAnchorPoint(cc.p(0,0))  
    sp1:setPosition(cc.p(0,0))
	layerBg:addChild(sp1)
	
	local sp2 = display.newSprite("PlaySceneBg.png")
	--sp2:move(display.cx, display.cy - 400)
	sp2:setAnchorPoint(cc.p(0,0))  
    sp2:setPosition(cc.p(0,sp1:getContentSize().height))
	layerBg:addChild(sp2)
	
	local layer = cc.Layer:create():addTo(self)
	local air = display.newSprite("air.png")
	air:setPosition(display.cx,display.cy - 200)
	layer:addChild(air,1)
	--layer:setLocalZOrder(1)
	layer:setTouchEnabled(true)
	--layer:onTouch(handler(self, self.onTouch))
	
	local backgroundMove = function()  
		sp1:setPositionY(sp1:getPositionY()-2)  
		sp2:setPositionY(sp1:getPositionY() + sp1:getContentSize().height)  
		if sp2:getPositionY() == 0 then  
			sp1:setPositionY(0) 
		end
	end
	cc.Director:getInstance():getScheduler():scheduleScriptFunc(backgroundMove, 0.01,false) --handler(self, self.backgroundMove)
	--cc.Director:getInstance():getScheduler():unscheduleScriptEntry(backgroundEntry)  
end


return MapScene