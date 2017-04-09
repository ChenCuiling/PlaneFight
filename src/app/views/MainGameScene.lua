
local GameScene = class("GameScene", cc.load("mvc").ViewBase)

function GameScene:onCreate()
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
	
	display.newSprite("Star.png")
        :move(display.left + 50, display.top - 50)
        :addTo(self,2)
		
	 self.livesLabel_ = cc.Label:createWithSystemFont("25845", "Arial", 32)
        :move(display.left + 130, display.top - 50)
        :addTo(self,2)

	
	local layer = cc.Layer:create():addTo(self)
	local layerEnemy = cc.Layer:create():addTo(self)
	local air = display.newSprite("air.png")
	--layer:addChild(air,1)
	self:addChild(air,1)
	--sp = cc.p(display.cx,display.cy - 200)
	air:setPosition(display.cx,display.cy - 200)
	
	--local pworld = air:convertToNodeSpace(cc.p(display.cx,display.cy - 200))
	--air:setPosition(pworld.x,pworld.y)
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
		--bullet:setPosition(touchLocation.x, touchLocation.y)
		print(touchLocation.x..","..touchLocation.y)
		air:setPosition(touchLocation.x, touchLocation.y)
		layer:setPosition(touchLocation.x - display.cx, touchLocation.y - (display.cy - 200))
		
		--layer:convertToNodeSpace(air:getPosition())
		--local p = layer:convertToNodeSpace(touchLocation)
		local pworld = air:convertToNodeSpace(cc.p(0, 0))
		-- air.setPosition(pworld.x,pworld.y)
		--print(p.x,p.y)
		print(pworld.x,pworld.y)
		
		print(layer:getPosition())
		print(air:getPosition())
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

	local bulletArray = {}
	local enemyArray = {}
	
	
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
	
	
	local addEnemy = function()
		local visibleSize = cc.Director:getInstance():getVisibleSize()
		local enemy = display.newSprite("enemy_1.png")
		local enemyPostion = cc.p(display.cx,display.cy - 200)
		local enemyASizie = enemy:getContentSize()  
		local minX = enemyASizie.width / 2  
		local maxX = visibleSize.width - (enemyASizie.width / 2)  
		local rangX = maxX - minX  
		local actualX = (math.random() * rangX) + minX  
		enemy:setPosition(cc.p(actualX,visibleSize.height + enemyASizie.height / 2)) 
		  
		layerEnemy:addChild(enemy)  

		local minDuration = 10  
		local maxDuration = 20  
		local rangeDur = maxDuration - minDuration  
		local actuakDur = (math.random() * rangeDur) + minDuration - 5 
		
		local actionMove = cc.MoveTo:create(actuakDur,cc.p(actualX,0 - enemy:getContentSize().height / 2))  
		--local actionDone = cc.CallFunc:create(removeEnemy)  
		local actionDone = cc.MoveTo:create(0.5,cc.p(0,-visibleSize.height))
		local sequence = cc.Sequence:create(actionMove,actionDone)  
		enemy:runAction(sequence)	
		table.insert(enemyArray,enemy) 	
		print("敌机创建")
	end
	--layer:addChild(bulletArray[#bulletArray])
	
	cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,addBullet),0.5,false)
	cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,addEnemy), 2,false)  
	
	local backgroundMove = function()  
		sp1:setPositionY(sp1:getPositionY()-2)  
		sp2:setPositionY(sp1:getPositionY() + sp1:getContentSize().height)  
		if sp2:getPositionY() == 0 then  
			sp1:setPositionY(0) 
		end
	end
	
	local test = function()
		print(table.getn(enemyArray))
		print(air:getContentSize().width)
		print(air:getPosition())
	
	end
	
	
	local detection = function()
		--遍历敌人数组
		local saa = table.getn(enemyArray)
		print("a"..saa)
		-- if  air  then 
			-- --local  GameSuccesScene = GameSuccesScene.new()
			-- --display.replaceScene(victory)
			-- local victory = cc.CSLoader:createNode("Victory.csb")
			-- victory:addTo(self)
			
		-- end
		--遍历敌机数组
		for k,v in pairs(enemyArray) do
			--敌机和飞机进行碰撞
			local hPosX = v:getPositionX()
			local hPosY = v:getPositionY()
			local posX = air:getPositionX()
			local posY = air:getPositionY()
			if  math.abs(hPosX - posX) < air:getContentSize().width and math.abs(hPosY - posY) < air:getContentSize().height then
				air:removeFromParent(true)
				air = nil
				print("11")
				--cc.Director:getInstance():getScheduler():unscheduleScriptEntry(enemyEntry) 
				local defeat = cc.CSLoader:createNode("defeat.csb")
				defeat:addTo(self)
				-- local btnExit = defeat:getChildByName("Btn_Exit")
				-- btnExit:addClickEventListener(callback)
				local exitButton = cc.MenuItemImage:create("ExitButton.png", "ExitButton.png")
					--:setTextureRect(CCRectMake(0, 0, 100, 100)
					:onClicked(function()
						self:getApp():enterScene("MainScene")
					end)
				cc.Menu:create(exitButton)
					:move(display.cx + 5, display.cy - 190)
					:addTo(self)
			end
			--遍历子弹数组
			for s,t in pairs(bulletArray)  do
				local posX = t:getPositionX()
				local posY = t:getPositionY()
				if  math.abs(hPosX - posX) < t:getContentSize().width and math.abs(hPosY - posY) < t:getContentSize().height then
					-- v:removeFromParent(true)
					-- t:removeFromParent(true)
					-- table.remove(enemyArray,k)
					-- table.remove(bulletArray,s)
					print("22")
				end
			end
		end
	end	
	
	cc.Director:getInstance():getScheduler():scheduleScriptFunc(backgroundMove, 0.01,false) --handler(self, self.backgroundMove)
	cc.Director:getInstance():getScheduler():scheduleScriptFunc(test, 2,false)
	--cc.Director:getInstance():getScheduler():unscheduleScriptEntry(backgroundEntry)  
	cc.Director:getInstance():getScheduler():scheduleScriptFunc(detection, 2,false)

end

return MainGameScene