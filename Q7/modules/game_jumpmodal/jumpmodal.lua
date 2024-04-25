local jumpModalWindow = nil
local jumpModalButton = nil
local jumpBtn = nil
local moveEvent = nil
local BTN_MOVE_DELAY = 50
local BTN_MOVEMENT_AMPLITUDE = 6
local minX = 0
local maxX = 0 
local minY = 0
local maxY = 0
local MARGIN = 40


function init()
  jumpModalWindow = g_ui.displayUI('jumpmodal')
  jumpModalWindow:hide()

  jumpModalButton = modules.client_topmenu.addRightGameToggleButton('jumpModalButton', tr('Jump mini game'),
          '/images/topbuttons/protection_zone', toggle) -- adds icon in top right menu
  jumpModalButton:setOn(false)
  
  jumpBtn = jumpModalWindow:getChildById('jumpBtn')
end

function terminate()
  removeEvent(moveEvent)
  jumpModalWindow:destroy()
  jumpModalButton:destroy()
end

function toggle() -- creates a modal window similar to the spell list one
  if jumpModalButton:isOn() then
    jumpModalButton:setOn(false)
    jumpModalWindow:hide()
    btnMoving(false)
  else
    jumpModalButton:setOn(true)
    jumpModalWindow:show()
    btnMoving(true)
  end
end

function btnMoving(isMoving)
  if (isMoving) then
    moveEvent = cycleEvent(function() -- creates cycle event
      local currentBtnX = jumpBtn:getX()

      setBtnClamps()
      if (currentBtnX - BTN_MOVEMENT_AMPLITUDE > minX) then
        jumpBtn:setX(currentBtnX - BTN_MOVEMENT_AMPLITUDE) -- moves towards the left if not at the window left border
      else
        jumpBtn:setPosition({x = maxX, y = math.random(minY, maxY)}) -- starts back at the window right border
      end

    end, BTN_MOVE_DELAY) -- repeated every 50 milliseconds
  else
    removeEvent(moveEvent) -- clean event if the modal window is closed
  end
end

function makeBtnJump() -- jumps on mouse click
  jumpBtn:setPosition({x = math.random(minX, maxX), y = math.random(minY, maxY)}) -- sets random btn positions
end

function setBtnClamps() -- makes sure the btn stays within the window
  local currentWinX = jumpModalWindow:getX()
  local currentWinY = jumpModalWindow:getY()
  minX = MARGIN + currentWinX
  minY = MARGIN + currentWinY
  maxX = jumpModalWindow:getWidth() + currentWinX - jumpBtn:getWidth() - MARGIN
  maxY = jumpModalWindow:getHeight() + currentWinY - jumpBtn:getHeight() - MARGIN
end