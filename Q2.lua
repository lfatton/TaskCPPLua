-- Q2 - Fix or improve the implementation of the below method
-- Corrected the db query where variables names need to be escaped, added some error handling,
-- the freeing of the query, and the loop to iterate over all the guild names returned

function printSmallGuildNames(memberCount)
    -- this method is supposed to print names of all guilds that have less than memberCount max members
    local selectGuildQuery = "SELECT `name` FROM `guilds` WHERE `max_members` < " .. db.escapeString(memberCount)
    local resultId = db.storeQuery(selectGuildQuery)

    if resultId ~= false then
        repeat
            local guildName = result.getString(resultId, "name")
            if guildName ~= false then
                print(guildName)
            end
        until not result.next(resultId)
        result.free(resultId)
    end
end