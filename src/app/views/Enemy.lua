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
    peer.life = life--�л�������ֵ  
    peer.score = score--����ܵл����ɻ�õķ���  
    peer.level = level--�л��ĵȼ���ͼƬ��Դ�������ֵл�  
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