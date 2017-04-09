

local SpriteTouch = class("SpriteTouch", cc.load("mvc").ViewBase)


function SpriteTouch:onCreate()	
	local bg = display.newSprite("PlaySceneBg.png")
	bg:move(display.cx, display.cy)
	bg:addTo(self)
	

    --注意：飞机和子弹应该是在不同的layer，避免使用定时器时子弹浮在飞机上面
	local layer = cc.Layer:create():addTo(self)
	local air = display.newSprite("air.png")
	air:setPosition(display.cx,display.cy - 200)
	layer:addChild(air)
	layer:setLocalZOrder(1)
	layer:setTouchEnabled(true)

	--实现事件触发回调
	local function onTouchBegan(touch, event)
		print("a")
		-- local touchLocation = touch:getLocation()
		-- print(touchLocation.x..","..touchLocation.y)
		return true
	end
	local function onTouchMoved(touch, event)
		print("b")
		local touchLocation = touch:getLocation()
		print(touchLocation.x..","..touchLocation.y)
		-- local touchLocation = cc.Touch:getLocation()
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

	
end

return SpriteTouch