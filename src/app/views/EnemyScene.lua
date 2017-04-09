--定义敌机实体类
local EnemyScene = class("EnemyScene", cc.load("mvc").ViewBase)

 

	
function EnemyScene:onCreate() 


	-- local enemyAEntry = nil  
	-- local enemyBEntry = nil  
	-- local enemyCEntry = nil 

	-- local Enemy_A_Life = 1  
	-- local Enemy_B_Life = 2  
	-- local Enemy_C_Life = 3  

	-- local Enemy_A_SCORE = 5  
	-- local Enemy_B_SCORE = 10  
	-- local Enemy_C_SCORE = 15  

	-- local Enemy_A_Level = 1  
	-- local Enemy_B_Level = 2  
	-- local Enemy_C_Level = 3  

	local layer = cc.Layer:create():addTo(self)
	local sp1 = display.newSprite("PlaySceneBg.png")
	--sp1:move( display.cx, display.cy )
	sp1:setAnchorPoint(cc.p(0,0))  
    sp1:setPosition(cc.p(0,0))
	layer:addChild(sp1) 
	
		
	local enemyArray = {} 
	
	-- local function create(frameName)--,life,score,level
		-- local enemy = cc.Sprite:createWithSpriteFrameName(frameName)  
		-- -- local peer = tolua.getpeer(enemy)  
		-- -- peer.life = life--敌机的生命值  
		-- -- peer.score = score--打爆这架敌机，可获得的分数  
		-- -- peer.level = level--敌机的等级，图片资源中有三种敌机  
		-- return enemy  
	-- end
	
	
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
		  
		layer:addChild(enemy)  
		
		
		-- local length = visibleSize.height + enemy:getContentSize().height / 2 - enemyPostion.y;  --子弹锚点到顶部的距离
		-- local velocity = 250 --飞行速度  
		-- local moveTime = length/velocity  --飞行到顶部的时间
		
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
	

	-- local addEnemyA = addEnemy("enemy_1.png")
	-- local addEnemyB = addEnemy("enemy_2.png")
	-- local addEnemyC = addEnemy("enemy_5.png")
     
	cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,addEnemy), 2,false)  
	-- enemyBEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,addEnemyB), 1,false)  
	-- enemyCEntry = cc.Director:getInstance():getScheduler():scheduleScriptFunc(handler(self,addEnemyC), 10,false)  


	
end      
	  


return EnemyScene








-- function Enemy:ctor()
	-- local sprite = cc.Sprite:createWithSpriteFrameName(frame)   
	-- local peer = {}  
	-- tolua.setpeer(sprite,peer)  
	-- return sprite  
-- end

-- Enemy.__index = Enemy  
  
-- function Enemy:create(frame,life,score,level)  
    -- local enemy = Enemy.new(frame)  
    -- local peer = tolua.getpeer(enemy)  
    -- peer.life = life--敌机的生命值  
    -- peer.score = score--打爆这架敌机，可获得的分数  
    -- peer.level = level--敌机的等级，图片资源中有三种敌机  
    -- return enemy  
-- end  
  
-- function Enemy:getLife()  
    -- return tolua.getpeer(self).life  
-- end  
  
-- function Enemy:getLevel()  
    -- return tolua.getpeer(self).level  
-- end  
  
-- function Enemy:getScore()  
    -- return tolua.getpeer(self).score  
-- end  
      
  
-- function Enemy:loseLife()  
    -- tolua.getpeer(self).life = tolua.getpeer(self).life - 1  
-- end  