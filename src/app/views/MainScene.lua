
local MainScene = class("MainScene", cc.load("mvc").ViewBase)

--MainScene.RESOURCE_FILENAME = "MainScene.csb"

function MainScene:onCreate()
	cc.Director:getInstance():setDisplayStats(false)
	local root = cc.CSLoader:createNode("MainScene.csb")
	--root:setPosition(display.x,display.y)
	root:setContentSize(cc.Director:getInstance():getVisibleSize())--屏幕适配
	ccui.Helper:doLayout(root)
	root:addTo(self)
	-- rank = cc.CSLoader:createNode("rank.csb")
	-- self:addChild(rank)
	
	
	local function onPlay()
		self:getApp():enterScene("GameScene")
		print("进入游戏")
	end
	
	local function delete(delete_btn)
		--self:getApp():enterScene("MainScene")
		--rank:setVisible(false)
		print("删除")
	end
	
	local function onRank()
		print("排行榜")
		local rank = cc.CSLoader:createNode("rank.csb")
		--rank:setPosition(display.x,display.y)
		rank:setContentSize(cc.Director:getInstance():getVisibleSize())--屏幕适配
		ccui.Helper:doLayout(rank)
		self:addChild(rank)
		-- local Panel = rank:getChildByName("Panel")
		-- Panel:setContentSize(cc.Director:getInstance():getVisibleSize())--屏幕适配
		-- ccui.Helper:doLayout(Panel)
		-- rank:addChild(Panel)
		local exitButton = cc.MenuItemImage:create("delete_.png", "delete_.png")
			--:setTextureRect(CCRectMake(0, 0, 100, 100)
			:onClicked(function()
				self:getApp():enterScene("MainScene")
			end)
		cc.Menu:create(exitButton)
			:move(display.cx+5, display.cy - 300)
			:addTo(self)
	end   

	local startgame = root:getChildByName("Btn_Start")
	startgame:addClickEventListener(onPlay)

	local ranklist = root:getChildByName("Btn_Rank")
	ranklist:addClickEventListener(onRank) 

end

-- function MainScene:ctor(app, name) 
	-- self:enableNodeEvents() 
	-- self.app_ = app 
	-- self.name_ = name 
	-- -- check CSB resource file 
	-- -- 搜索csb文件 
	-- local res = rawget(self.class, "RESOURCE_FILENAME") 
	-- if res then 
	-- --加载CocosStudio编辑出来的*.csb 文件 
	-- self:createResoueceNode(res) 
	-- end
	
	-- -- 查询csb文件控件名 
	-- local binding = rawget(self.class, "RESOURCE_BINDING") 
	-- if res and binding then 
	
	-- -- 获取UI上的控件并且保存起来 
	-- self:createResoueceBinding(binding) 
	-- end 
	-- if self.onCreate then 
	-- self:onCreate() 
	-- end 
-- end

-- local function createCocostudioUI() 
	-- local ccsLayout = ccs.GUIReader:shareReader():widgetFromJsonFile("DemoLogin/DemoLogin.json") 
	-- local ccsButton = ccsLayout:getChildByName("login_Button") 
	-- local ccsButton = ccsLayout:getChildByTag(14) 
	-- ccsButton:addTouchEventListener(function(...) 
	-- ccsLayout:setVisible(false) 
	-- end) 
	-- return ccsLayout 
-- end


return MainScene