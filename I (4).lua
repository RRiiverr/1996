local plist_set, plist_get = plist.set, plist.get
local getplayer = entity.get_players
local entity_isenemy = entity.is_enemy

local function resolve(player)
   

 
    plist_set(player, "Correction Active", false)--skeetin resolveri yarak kapatgitsin

    --resolver basliyor

    plist_set(player, "Force body yaw", true)
    plist_set(player, "Force body yaw value", math.random(-45,49 ))
end
local function onpaint ()
   local enemies = getplayer(true)
   for i = 1, #enemies do
       local player = enemies[i]
       resolve(player)
    end
end

client.register_esp_flag("Sikik", 0, 255, 0, function(entindex)
    if not entity_isenemy(entindex) then
       return false
    end
    
    if plist_get(entindex, "Force body yaw") == true then
        return true
    end
    
    return false
end)
client.set_event_callback('net_update_start', onpaint)