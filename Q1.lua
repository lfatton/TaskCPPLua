-- Q1 - Fix or improve the implementation of the below methods
-- Added two variables to make code clearer, one is for the 1 second delay and the other for the storage key

local DELAY = 1000
local KEY = 1000

local function releaseStorage(player)
    player:setStorageValue(KEY, -1)
end

function onLogout(player)
    if player:getStorageValue(KEY) == 1 then
        addEvent(releaseStorage, DELAY, player)
    end
    return true
end