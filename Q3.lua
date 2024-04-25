-- Q3 - Fix or improve the name and the implementation of the below method
-- Renamed the function to be clearer and also match the language conventions (CamelCase),
-- modified the loop, as we weren't using the key, assuming there's a getName() function to return the member name,
-- we compared it to the name we were given and if they match, we remove the member from the party

function removeMemberFromPlayerParty(playerId, name)
    player = Player(playerId)
    local party = player:getParty()

    for _, member in ipairs(party:getMembers()) do
        local memberName = member:getName()
        if memberName == name then
            party:removeMember(member)
        end
    end
end