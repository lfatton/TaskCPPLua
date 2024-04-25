// Q4 - Assume all method calls work fine. Fix the memory leak issue in below method
// Makes sure the newly allocated player object at line 9 gets freed even if there's an error

void Game::addItemToPlayer(const std::string& recipient, uint16_t itemId)
{
    Player* player = g_game.getPlayerByName(recipient);

    if (!player) {
        player = new Player(nullptr);
        if (!IOLoginData::loadPlayerByName(player, recipient)) {
            delete player; //delete the newly allocated empty player if we cannot load data onto it, which fix the leak
            return;
        }
    }

    Item* item = Item::CreateItem(itemId);
    if (!item) {
        return;
    }

    g_game.internalAddItem(player->getInbox(), item, INDEX_WHEREEVER, FLAG_NOLIMIT);

    if (player->isOffline()) {
        IOLoginData::savePlayer(player);
        delete player; //we don't need the player anymore if offline and saved
    }
}