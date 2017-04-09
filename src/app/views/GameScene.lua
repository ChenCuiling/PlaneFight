
local GameScene = class("GameScene", cc.load("mvc").ViewBase)


local bulletArray = {}
local enemyArray = {}

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
	
	self.score = 0
	
	display.newSprite("Star.png")
        :move(display.left + 50, display.top - 50)
        :addTo(self,2)
		
	self.score_ = cc.Label:createWithSystemFont(self.score, "Arial", 32)
        :move(display.left + 130, display.top - 50)
        :addTo(self,2)

	
	local layer = cc.Layer:create():addTo(self)
	local layerEnemy = cc.Layer:create():addTo(self)
	local air = display.newSprite("air.png")
	air:setPosition(display.cx,display.cy - 200)
	self:addChild(air,1)
	--layer:setLocalZOrder(1)
	layer:setTouchEnabled(true)
	--layer:onTouch(handler(self, self.onTouch))
	
	--实现事件触发回调
	local function onTouchBegan(touch, event)
		return true
	end
	local function onTouchMoved(touch, event)
		local touchLocation = touch:getLocation()
		air:setPosition(touchLocation.x,touchLocation.y)
		--bullet:setPosition(touchLocation.x,touchLocation.y)
		-- local a = cc.p(touchLocation.x - display.cx , touchLocation.y - (display.cy - 200))
		-- layer:setPosition(a)
		-- self.b = layer:convertToNodeSpace(cc.p(display.cx,display.cy - 200))
		-- print("子弹相对于父节点的位置"..self.b.x,self.b.y)
		print(air:getPosition())
		--bulletArray[#bulletArray]:setPosition(touchLocation.x,touchLocation.y)
	end
	local function onTouchEnded(touch, event)
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
		--bullet:setScale(0.05,0.05)
		
		--local bulletPostion = cc.p(display.cx,display.cy - 200)
		--bulletPostion = bulletArray[#bulletArray]:getPosition()
		local airX = air:getPositionX()
		local airY = air:getPositionY()
		local bulletPostion = cc.p(airX,airY)
		
		bullet:setPosition(bulletPostion)
		
		layer:addChild(bullet)
		
		-- local b = layer:convertToNodeSpace(bulletPostion)
		-- print("子弹相对于父节点的位置"..b.x)
		-- bullet:setPosition(cc.p(b.x,b.y))
		
		local visibleSize = cc.Director:getInstance():getVisibleSize()
		local length = visibleSize.height + bullet:getContentSize().height / 2 - bulletPostion.y;  --子弹锚点到顶部的距离
		local velocity = 200 --飞行速度  
		local moveTime = length/velocity  --飞行到顶部的时间
		
		local bWPos = bullet:convertToWorldSpace(cc.p(0,0))--cc.p(bulletPostion.x,bulletPostion.y)
		--bullet:setPosition(bWPos.x - 285.5,display.cy - 200)
		--bullet:setPosition(cc.p(self.b.x,self.b.y)) 
		
		--bullet:setPosition(cc.p(bWPos.x + 33, display.cy - 200)) -- 285.5 - 235
		local actionMove = cc.MoveTo:create(moveTime,cc.p(bullet:getPositionX(),visibleSize.height + bullet:getContentSize().height / 2 + 300))  --持续移动到指定位置bulletPostion.x
		--local actionDone = cc.MoveTo:create(0.5,cc.p(0,visibleSize.height+500))
		--local sequence = cc.Sequence:create(actionMove,actionDone)  --WithTwoActions
		bullet:runAction(actionMove)  
		table.insert(bulletArray,bullet)
		
		--print("子弹世界坐标"..bWPos.x,bWPos.y)
		print("子弹坐标"..bullet:getPosition())
		print("子弹创建")
	end
	
	
	local addEnemy = function()
		local visibleSize = cc.Director:getInstance():getVisibleSize()
		local enemy = display.newSprite("enemy_1.png")
		if math.random(1, 2) % 2 == 0 then
			enemy = display.newSprite("enemy_4.png")
		end
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
		-- local actionDone = cc.MoveTo:create(0.5,cc.p(0,-visibleSize.height))
		-- local sequence = cc.Sequence:create(actionMove,actionDone)  
		enemy:runAction(actionMove)	
		table.insert(enemyArray,enemy) 	
		print("敌机创建")
	end
	--layer:addChild(bulletArray[#bulletArray])
	
	local add1 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,addBullet), 0.5,false)
	local add2 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,addEnemy), 2,false)  
	
	local backgroundMove = function()  
		sp1:setPositionY(sp1:getPositionY()-2)  
		sp2:setPositionY(sp1:getPositionY() + sp1:getContentSize().height)  
		if sp2:getPositionY() == 0 then  
			sp1:setPositionY(0) 
		end
	end
	
	local Entry1 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(backgroundMove, 0.01,false) --handler(self, self.backgroundMove)
	
	local detection = function()
		--遍历敌人数组
		local saa = table.getn(enemyArray)
		local sbb = table.getn(bulletArray)
		print("a"..saa)
		print("b"..sbb)
		
		local enemyClone = {}
		local bulletClone = {}
		
		--遍历敌机数组
		--for k,v in pairs(enemyArray) do
		for k = #enemyArray, 1, -1 do
			--敌机和飞机进行碰撞
			local v = enemyArray[k]
			local hPosX = v:getPositionX()
			local hPosY = v:getPositionY()
			print("敌机坐标"..hPosX,hPosY)
			
			if hPosY <=0 then
				table.remove(enemyArray,k)
				break
			end
			
			if air then 
				self.posX = air:getPositionX()
				self.posY = air:getPositionY()
			
				if  math.abs(hPosX - self.posX) < air:getContentSize().width and math.abs(hPosY - self.posY) < air:getContentSize().height then
					air:removeFromParent(true)
					air = nil
					local defeat = cc.CSLoader:createNode("defeat.csb")
					defeat:setContentSize(cc.Director:getInstance():getVisibleSize())--屏幕适配
					ccui.Helper:doLayout(defeat)
					defeat:addTo(self)
					
					
					local exitButton = cc.MenuItemImage:create("ExitButton.png", "ExitButton.png")
						:onClicked(function()
							self:getApp():enterScene("MainScene")
							self:objremove()
						end)
					cc.Menu:create(exitButton)
						:move(display.cx + 5, display.cy - 190)
						:addTo(self)
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(add1)
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(add2)
					cc.Director:getInstance():getScheduler():unscheduleScriptEntry(Entry1)
					--cc.Director:getInstance():getScheduler():unscheduleScriptEntry(Entry2)
					print("定时器停止")
					break
				end
			end
			
			local i = 1
			local j = 1
			while i <= #bulletArray do
				local t = bulletArray[i]
				local posX = t:getPositionX()
				local posY = t:getPositionY()
				print("子弹坐标"..posX,posY)
				if posY >= 960 then
					table.remove(bulletArray,i)
				end
			
				if  math.abs(hPosX - posX) < t:getContentSize().width and math.abs(hPosY - posY) < t:getContentSize().height then
					self.score = self.score + 50
					self.score_:setString(self.score)
					print("分数"..self.score)
					--bulletClone[i] = bulletArray[i]
					table.remove(bulletArray,i)
					table.remove(enemyArray,k)
					t:removeFromParent()
					v:removeFromParent()
					enemyClone[j] = enemyArray[K]
					print("元素删除成功")
					break
				else
					i = i + 1
				end
			end
		end
	end	
	
	local Entry2 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(detection, 0.01,false)
	
	local PlayVictory = function()
		if air then
			-- local victory = cc.CSLoader:createNode("victory.csb")
			-- victory:setContentSize(cc.Director:getInstance():getVisibleSize())--屏幕适配
			-- ccui.Helper:doLayout(victory)
			-- victory:addTo(self,2)
			
			display.newSprite("V.png")
				:move(display.cx,display.cy)
				:addTo(self)
			
			local exitButton = cc.MenuItemImage:create("ExitButton.png", "ExitButton.png")
				--:setTextureRect(CCRectMake(0, 0, 100, 100)
				:onClicked(function()
					self:getApp():enterScene("MainScene")
					--display.replaceScene("MainScene")
					self:objremove()
				end)
			cc.Menu:create(exitButton)
				:move(display.cx + 5, display.cy - 150)
				:addTo(self,3)
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(add1)
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(add2)
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(Entry1)
			cc.Director:getInstance():getScheduler():unscheduleScriptEntry(Entry2)
			print("游戏胜利")
		end
	end
	local Entry3 = cc.Director:getInstance():getScheduler():scheduleScriptFunc(PlayVictory, 30,false)	
	-- bind the "event" component
    --cc.bind(self, "event")
end


function GameScene:objremove()
	for a = #enemyArray, 1, -1 do 
		table.remove(enemyArray,k)
		print("所有对象都清除了")
	end
	for b = #bulletArray, 1, -1 do 
		table.remove(bulletArray,k)
		print("所有对象都清除了")
	end
end

-- function GameScene:onCleanup()
    -- self:removeAllEventListeners()
-- end

return GameScene



