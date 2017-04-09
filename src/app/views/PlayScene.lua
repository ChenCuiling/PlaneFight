
local PlayScene = class("PlayScene", cc.load("mvc").ViewBase)

local GameView = import(".GameView")

function PlayScene:onCreate()
    -- create game view and add it to stage
    self.gameView_ = GameView:create()
        :addEventListener(GameView.events.PLAYER_DEAD_EVENT, handler(self, self.onPlayerDead))
        :start()
        :addTo(self)
end

function PlayScene:onPlayerDead(event)

	local victory = cc.CSLoader:createNode("victory.csb")
	victory:addTo(self)
    -- self.Node_ = display.newNode():addTo(self)
	-- local btn_exit = victory:getChildByName("Btn_Exit")
	-- btn_exit:addTo(self.Node_)
	-- btn_exit:addEventListener(function()
		-- self:getApp().enterScene("MainScene")
	-- end)
	
	
	-- add game over text
    -- local text = string.format("You get %d score", self.gameView_:getKills())
    -- cc.Label:createWithSystemFont(text, "Arial", 50)
        -- :align(display.CENTER, display.center)
        -- :addTo(self)
		
    -- add exit button
    local exitButton = cc.MenuItemImage:create("ExitButton.png", "ExitButton.png")
        :onClicked(function()
            self:getApp():enterScene("MainScene")
        end)
    cc.Menu:create(exitButton)
        :move(display.cx + 10, display.cy - 190)
        :addTo(self)
end

return PlayScene















































-- local PlayScene = class("PlayScene", cc.load("mvc").ViewBase)

-- local test = import(".test")

-- PlayScene.RESOURCE_FILENAME = "PlayScene.csb"

-- function PlayScene:onCreate()
    -- local Playroot = cc.CSLoader:createNode("PlayScene.csb")
	-- Playroot:addTo(self)
	-- local target = cc.Sprite:Create("air.png")
	
	
	-- display.newSprite("PlaySceneBg.jpg")
        -- :move(display.center)
		-- :addTo(self)
	
	-- local layer=cc.Layer:create()
	-- local target = cc.Sprite:create("air.png")
	-- target:move(display.cx,display.cy)
	-- layer:addChild(target)
		
	-- air = cc.MenuItemImage:create("air.png", "air.png")
        -- :onClicked(function()
            -- self:getApp():enterScene("MainScene")
        -- end)
		-- :onTouch(handler(self, self.onTouch))
	-- cc.Menu:create(air)
        -- :move(display.cx, display.cy - 200)
        -- :addTo(self)
		
	-- local function onTouchBegan( touch, event )
		-- return true  
	-- end
	-- local function onTouchEnded( touch, event )
		-- print("onTouchesEnd");
	-- end
	-- local function onTouchMoved( touch, event )
		-- local target = event:getCurrentTarget()  --获取当前的控件
        -- local posX,posY = target:getPosition()  --获取当前的位置
        -- local delta = touch:getDelta() --获取滑动的距离
        -- target:setPosition(cc.p(posX + delta.x, posY + delta.y)) --给精灵重新设置位置
	-- end
			
	-- local listener = cc.EventListenerTouchOneByOne:create()  --创建一个单点事件监听
	-- listener:setSwallowTouches(true)  --是否向下传递
	-- listener:registerScriptHandler(onTouchBegan,cc.Handler.EVENT_TOUCH_BEGAN )
	-- listener:registerScriptHandler(onTouchMoved,cc.Handler.EVENT_TOUCH_MOVED )
	-- listener:registerScriptHandler(onTouchEnded,cc.Handler.EVENT_TOUCH_ENDED )

	-- local eventDispatcher = self:getEventDispatcher() 
	-- eventDispatcher:addEventListenerWithSceneGraphPriority(listener, air) --分发监听事件
-- end


-- function PlayScene:onCreate()
    -- -- create game view and add it to stage
    -- self.gameView_ = GameView:create()
        -- :addEventListener(GameView.events.PLAYER_DEAD_EVENT, handler(self, self.onPlayerDead))
        -- :start()
        -- :addTo(self)
-- end

-- function PlayScene:onPlayerDead(event)
    -- -- add game over text
    -- local text = string.format("You killed %d bugs", self.gameView_:getKills())
    -- cc.Label:createWithSystemFont(text, "Arial", 96)
        -- :align(display.CENTER, display.center)
        -- :addTo(self)

    -- -- add exit button
    -- local exitButton = cc.MenuItemImage:create("ExitButton.png", "ExitButton.png")
        -- :onClicked(function()
            -- self:getApp():enterScene("MainScene")
        -- end)
    -- cc.Menu:create(exitButton)
        -- :move(display.cx, display.cy - 200)
        -- :addTo(self)
-- end


















-- --添加一个creaet函数
-- function MenuScene:create()
-- local scene=MenuScene.new()
-- scene:addChild(scene:init())
-- return scene
-- end
 
-- --添加一个构造
-- function MenuScene:ctor()
    -- self.winsize=cc.Director:getInstance():getWinSize()
-- end
-- --初始化
-- function MenuScene:init()
-- --定义一个layer作为容器
-- local layer=cc.Layer:create()
 
-- --添加一个精灵背景
-- local spbk=cc.Sprite:create("fonts/Resources/logo.jpg")
-- layer:addChild(spbk)
-- spbk:setPosition(cc.vertex2F(self.winsize.width/2,self.winsize.height/2))
-- --定义logo
-- local splogo=cc.Sprite:create("fonts/Resources/LOGO.png")
-- layer:addChild(splogo)
-- --执行动作，从底下移动到上方
-- splogo:setPositionX(self.winsize.width/2)
-- splogo:runAction(cc.MoveTo:create(0.5,cc.vertex2F(self.winsize.width/2,self.winsize.height/2+300)))
-- --添加一个按钮
-- --local label1=cc.LabelTTF:create("开始游戏","",23)
-- local label1=cc.MenuItemImage:create("fonts/Resources/kaishia.png","fonts/Resources/kaishib.png")
-- local start=cc.MenuItemLabel:create(label1)
-- local menu=cc.Menu:create()
-- menu:addChild(start)
-- start:setTag(10)
-- start:setColor(cc.c4f(255,255,1,1))
-- layer:addChild(menu)
 
    -- --locallabel2=cc.LabelTTF:create("游戏帮助","",23)
    -- local label2=cc.MenuItemImage:create("fonts/Resources/xuanyaoa.png","fonts/Resources/xuanyaob.png")
    -- local help=cc.MenuItemLabel:create(label2)
    -- local menu=cc.Menu:create()
    -- menu:addChild(help)
    -- help:setPositionY(help:getPositionY()-100)
    -- help:setTag(11)
    -- help:setColor(cc.c4f(255,255,1,1))
    -- layer:addChild(menu)
-- --添加回调函数
   -- local function menucallback(obj)
  
       -- if tonumber(obj)==10 then
      -- local scene=require("GameScene")
       -- local gs=scene:create()
       -- cc.Director:getInstance():replaceScene(gs)
       -- elseif tonumber(obj)==11 then
       -- local scene=require("HelpScene")
       -- local hs=scene:create()
       -- cc.Director:getInstance():replaceScene(hs)
    
 -- end
   -- end
-- help:registerScriptTapHandler(menucallback)
    -- start:registerScriptTapHandler(menucallback)
    -- return layer
-- end
 -- return MenuScene

-- return PlayScene
