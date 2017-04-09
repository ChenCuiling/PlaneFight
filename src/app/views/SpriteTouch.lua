

local SpriteTouch = class("SpriteTouch", cc.load("mvc").ViewBase)


function SpriteTouch:onCreate()	
	local bg = display.newSprite("PlaySceneBg.png")
	bg:move(display.cx, display.cy)
	bg:addTo(self)
	

    --ע�⣺�ɻ����ӵ�Ӧ�����ڲ�ͬ��layer������ʹ�ö�ʱ��ʱ�ӵ����ڷɻ�����
	local layer = cc.Layer:create():addTo(self)
	local air = display.newSprite("air.png")
	air:setPosition(display.cx,display.cy - 200)
	layer:addChild(air)
	layer:setLocalZOrder(1)
	layer:setTouchEnabled(true)

	--ʵ���¼������ص�
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
	 
	local listener = cc.EventListenerTouchOneByOne:create() -- ����һ���¼�������
	listener:setSwallowTouches(true)
	listener:registerScriptHandler(onTouchBegan, cc.Handler.EVENT_TOUCH_BEGAN)
	listener:registerScriptHandler(onTouchMoved, cc.Handler.EVENT_TOUCH_MOVED)
	listener:registerScriptHandler(onTouchEnded, cc.Handler.EVENT_TOUCH_ENDED)
	 
	local eventDispatcher = self:getEventDispatcher() -- �õ��¼��ɷ���
	eventDispatcher:addEventListenerWithSceneGraphPriority(listener, layer) -- ��������ע�ᵽ�ɷ�����

	
end

return SpriteTouch