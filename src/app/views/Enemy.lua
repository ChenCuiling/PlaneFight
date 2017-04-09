Enemy = class("Enemy", function(frame)  
        local sprite = cc.Sprite:createWithSpriteFrameName(frame)   
        local peer = {}  
        tolua.setpeer(sprite,peer)  
        return sprite  
    end  
  )  
Enemy.__index = Enemy  
  
function Enemy:ctor(frame,life,score,level)  
    local enemy = Enemy.new(frame)  
    local peer = tolua.getpeer(enemy)  
    peer.life = life--敌机的生命值  
    peer.score = score--打爆这架敌机，可获得的分数  
    peer.level = level--敌机的等级，图片资源中有三种敌机  
    return enemy  
end  
  
function Enemy:getLife()  
    return tolua.getpeer(self).life  
end  
  
function Enemy:getLevel()  
    return tolua.getpeer(self).level  
end  
  
function Enemy:getScore()  
    return tolua.getpeer(self).score  
end  
      
  
function Enemy:loseLife()  
    tolua.getpeer(self).life = tolua.getpeer(self).life - 1  
end  

return Enemy