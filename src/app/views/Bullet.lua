
local Bullet = class("Bullet", cc.load("mvc").ViewBase)

function Bullet:onCreate()	
	local bg = display.newSprite("PlaySceneBg.png")
	bg:move(display.cx, display.cy)
	bg:addTo(self)

	local layer = cc.Layer:create():addTo(self)
	local air = display.newSprite("air.png")
	air:setPosition(display.cx,display.cy - 200)
	layer:addChild(air,1)
	--layer:setLocalZOrder(1)
	layer:setTouchEnabled(true)
	--layer:onTouch(handler(self, self.onTouch))
	
	--实现事件触发回调
	local function onTouchBegan(touch, event)
		print("a")
		return true
	end
	local function onTouchMoved(touch, event)
		print("b")
		local touchLocation = touch:getLocation()
		print(touchLocation.x..","..touchLocation.y)
		layer:setPosition(touchLocation.x - display.cx , touchLocation.y - (display.cy - 200))
	end
	local function onTouchEnded(touch, event)
		print("c")
	end
	 
	local listener = cc.EventListenerTouchOneByOne:create() -- 创建一个事件监听器
	listener:setSwallowTouches(true)
	listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
	 
	local eventDispatcher = self:getEventDispatcher() -- 得到事件派发器
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer) -- 将监听器注册到派发器中

	
	local addBullet = function()
		local bullet = display.newSprite("bullet.png")
		bullet:setScale(0.05,0.05)
		local bulletPostion = cc.p(display.cx,display.cy - 200)
		bullet:setPosition(bulletPostion)
		layer:addChild(bullet)
		
		local visibleSize = cc.Director:getInstance():getVisibleSize()
		local length = visibleSize.height + bullet:getContentSize().height / 2 - bulletPostion.y;  --子弹锚点到顶部的距离
		local velocity = 250 --飞行速度  
		local moveTime = length/velocity  --飞行到顶部的时间
		local actionMove = cc.MoveTo:create(moveTime,cc.p(bulletPostion.x,visibleSize.height + bullet:getContentSize().height / 2))  --持续移动到指定位置
		local actionDone = cc.MoveTo:create(0.5,cc.p(0,visibleSize.height+500))
		local sequence = cc.Sequence:create(actionMove,actionDone)  --WithTwoActions
		bullet:runAction(sequence)  
		table.insert(bulletArray,bullet) 
		print("子弹创建")
	end
	
	--layer:addChild(bulletArray[#bulletArray])
	
	
	cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,addBullet),0.5,false)
end


-- function Bullet:addBullet()
	
	-- local bullet = display.newSprite("bullet.png")
	-- bullet:setScale(0.05,0.05)
    -- local bulletPostion = cc.p(display.cx,display.cy - 200)
    -- bullet:setPosition(bulletPostion)  
    -- self:addChild(bullet)  
    
	-- local visibleSize = cc.Director:getInstance():getVisibleSize()
    -- local length = visibleSize.height + bullet:getContentSize().height / 2 - bulletPostion.y;  --子弹锚点到顶部的距离
    -- local velocity = 250 --飞行速度  
    -- local moveTime = length/velocity  --飞行到顶部的时间
    -- local actionMove = cc.MoveTo:create(moveTime,cc.p(bulletPostion.x,visibleSize.height + bullet:getContentSize().height / 2))  --持续移动到指定位置
    -- --cc.RepeatForever:create(actionMove)
	-- --cc.runAction(actionMove)
	 
	-- -- local removeBullet = function()
	-- -- end
    -- -- local actionDone = cc.CallFunc:create(removeBullet)
	-- local actionDone = cc.MoveTo:create(0.5,cc.p(0,visibleSize.height))
    -- local sequence = cc.Sequence:create(actionMove,actionDone)  --WithTwoActions
    -- bullet:runAction(sequence)  
    -- --table.insert(bulletArray,bullet)  
	-- print("子弹创建")
-- end

return Bullet