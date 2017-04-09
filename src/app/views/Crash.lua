
local Crash = class("Crash",cc.load("mvc"),ViewBase)

local Bullet = import(".Bullet")

function Crash:onCreate()
	self.bullet_ = Bullet.create()

end



--碰撞检测
-- function Crash:detection()
    -- --遍历敌人数组
    -- local saa=table.getn(enemyarray)
        -- print(saa)
        -- if saa==0  then 
            -- local  GameSuccesScene = GameSuccesScene.new()
            -- display.replaceScene(GameSuccesScene)
        -- end
        -- if  xiaobing  then 
            -- for k,v  in pairs(enemyarray) do
                 -- --在这里让他和小兵进行碰撞
                -- local hPosX=v:getPositionX()
                -- local hPosY=v:getPositionY()
                -- local posX=xiaobing:getPositionX()
                -- local posY=xiaobing:getPositionY()
                -- if  math.abs(hPosX-posX)<xiaobing:getContentSize().width and math.abs(hPosY-posY) < 
                    -- xiaobing:getContentSize().height then
                    -- xiaobing:removeFromParentAndCleanup(true)
                    -- xiaobing=nil
                    -- local  GameOverScene=GameOverScene.new()
                    -- CCDirector:sharedDirector():replaceScene(GameOverScene)
                -- end
             -- --遍历子弹数组
                -- for s,t  in  pairs(Bulletarray)  do
                    -- local posX=t:getPositionX()
                    -- local posY=t:getPositionY()
                    -- if  math.abs(hPosX-posX)<t:getContentSize().width and math.abs(hPosY-posY) < t:getContentSize().height then
                        -- v:removeFromParentAndCleanup(true)
                        -- t:removeFromParentAndCleanup(true)
                        -- table.remove(enemyarray,k)
                        -- table.remove(Bulletarray,s)
                    -- end
                -- end
            -- end
        -- end
-- end
-- --碰撞检测的使用
-- function Crash:isCollsion()
	-- local hPosX=Enemy:getPositionX()
	-- local hPosY=Enemy:getPositionY()
	-- local posX=bullet:getPositionX()
	-- local posY=bullet:getPositionY()
	-- local sosX=player:getPositionX()
	-- local sosY=player:getPositionY()
	-- if math.abs(hPosX-posX)<bullet:getContentSize().width and math.abs(hPosY-posY) < bullet:getContentSize().height then
		-- Enemy:removeFromParent()
		-- bullet:removeFromParent()
	-- end
	-- if math.abs(hPosX-sosX)<player:getContentSize().width and math.abs(hPosY-sosY) < 
		-- player:getContentSize().height then
		-- Enemy:removeFromParent()
		-- player:removeFromParent()
		-- CCDirector:sharedDirector():unscheduleAll()
		-- local gameover=gameScene:new()
        -- display.replaceScene(gameover)
-- -----CCDirector:sharedDirector():replaceScene(gameover)
	-- end
-- end

-- --时间：设置游戏时间为半分钟
-- local CurrentDateTime = os.date("*t",ServerTimeStamp)
-- print("year="..CurrentDateTime.year)
-- print("month="..CurrentDateTime.month)
-- print("day="..CurrentDateTime.day)
-- print("hour="..CurrentDateTime.hour)
-- print("min="..CurrentDateTime.min)
-- print("sec="..CurrentDateTime.sec)

return Crash