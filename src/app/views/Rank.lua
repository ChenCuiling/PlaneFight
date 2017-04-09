local Rank = class("rank",cc.load"mvc",viewBase)

function Rank:ctor()
	local rank = cc.CSLoader:createNode("rank.csb")
	rank:addTo(self)
	
	local function delete()
		--self:getApp():enterScene("MainScene")
		print("删除")
	end
	
	local delete_btn = root:getChildByName("delete")
	delete_btn:addClickEventListener(delete) 
		
end

return Rank