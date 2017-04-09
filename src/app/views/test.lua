local test = class("test",cc.load("mvc").ViewBase)


function test:onCreate()
	local layer = cc.Layer().creat()
	display.newSprite("PlaySceneBg.png","PlaySceneBg.png")
		:move(display.center)
		:addTo(self)
		
	cc.Label:createWithSystemFont("aaa", "Arial", 96)
        :align(display.CENTER, display.center)
        :addTo(self)
	
	
	
end

return test