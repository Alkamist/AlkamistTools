local math = math
local reaper = reaper
local gfx = gfx

local function msg(m)
  reaper.ShowConsoleMsg(tostring(m) .. "\n")
end

---------------------------------- GUI ----------------------------------

local GUI = {
  windowTitle = "",
  windowX = 0,
  windowXPrevious = 0,
  windowXChange = 0,
  windowXJustChanged = 0,
  windowY = 0,
  windowYPrevious = 0,
  windowYChange = 0,
  windowYJustChanged = 0,
  windowW = 0,
  windowWPrevious = 0,
  windowWChange = 0,
  windowWJustChanged = false,
  windowH = 0,
  windowHPrevious = 0,
  windowHChange = 0,
  windowHJustChanged = false,
  windowJustResized = false,
  windowJustMoved = false,
  windowDock = 0,
  windowDockPrevious = 0,
  windowDockJustChanged = false,
  keyboardChar = nil,
  mouseJustMoved = false,
  mouseCap = 0,
  mouseCapPrevious = 0,
  mouseX = 0,
  mouseXPrevious = 0,
  mouseXChange = 0,
  mouseXJustChanged = false,
  mouseY = 0,
  mouseYPrevious = 0,
  mouseYChange = 0,
  mouseYJustChanged = false,
  mouseWheel = 0,
  mouseWheelJustMoved = false,
  mouseHWheel = 0,
  mouseHWheelJustMoved = false,
  mouseLeftIsPressed = false,
  mouseLeftWasPressed = false,
  mouseLeftJustPressed = false,
  mouseLeftJustReleased = false,
  mouseLeftJustDragged = false,
  mouseMiddleIsPressed = false,
  mouseMiddleWasPressed = false,
  mouseMiddleJustPressed = false,
  mouseMiddleJustReleased = false,
  mouseMiddleJustDragged = false,
  mouseRightIsPressed = false,
  mouseRightWasPressed = false,
  mouseRightJustPressed = false,
  mouseRightJustReleased = false,
  mouseRightJustDragged = false,
  shiftIsPressed = false,
  shiftWasPressed = false,
  shiftJustPressed = false,
  shiftJustReleased = false,
  shiftJustDragged = false,
  controlIsPressed = false,
  controlWasPressed = false,
  controlJustPressed = false,
  controlJustReleased = false,
  controlJustDragged = false,
  windowsIsPressed = false,
  windowsWasPressed = false,
  windowsJustPressed = false,
  windowsJustReleased = false,
  windowsJustDragged = false,
  altIsPressed = false,
  altWasPressed = false,
  altJustPressed = false,
  altJustReleased = false,
  altJustDragged = false
}

function GUI.setBackgroundColor(r, g, b)
  gfx.clear = math.floor(r * 255) + math.floor(g * 255) * 256 + math.floor(b * 255) * 65536
end

function GUI.init(title, w, h, dock, x, y)
  GUI.windowTitle = title
  GUI.windowX = tonumber(reaper.GetExtState(GUI.windowTitle, "windowX")) or x
  GUI.windowY = tonumber(reaper.GetExtState(GUI.windowTitle, "windowY")) or y
  GUI.windowW = tonumber(reaper.GetExtState(GUI.windowTitle, "windowW")) or w
  GUI.windowH = tonumber(reaper.GetExtState(GUI.windowTitle, "windowH")) or h
  GUI.windowDock = tonumber(reaper.GetExtState(GUI.windowTitle, "windowDock")) or dock
  GUI.windowXPrevious = GUI.windowX
  GUI.windowYPrevious = GUI.windowY
  GUI.windowWPrevious = GUI.windowW
  GUI.windowHPrevious = GUI.windowH
  GUI.windowDockPrevious = GUI.windowDock
  gfx.init(title, GUI.windowW, GUI.windowH, GUI.windowDock, GUI.windowX, GUI.windowY)
end

function GUI.run()
  GUI.windowDock, GUI.windowX, GUI.windowY, GUI.windowW, GUI.windowH = gfx.dock(-1, true, true, true, true)
  GUI.windowDockJustChanged = GUI.windowDock ~= GUI.windowDockPrevious
  GUI.windowXChange = GUI.windowX - GUI.windowXPrevious
  GUI.windowXJustChanged = GUI.windowX ~= GUI.windowXPrevious
  GUI.windowYChange = GUI.windowY - GUI.windowYPrevious
  GUI.windowYJustChanged = GUI.windowY ~= GUI.windowYPrevious
  GUI.windowWChange = GUI.windowW - GUI.windowWPrevious
  GUI.windowWJustChanged = GUI.windowW ~= GUI.windowWPrevious
  GUI.windowHChange = GUI.windowH - GUI.windowHPrevious
  GUI.windowHJustChanged = GUI.windowH ~= GUI.windowHPrevious
  GUI.windowJustResized = GUI.windowWJustChanged or GUI.windowHJustChanged
  GUI.windowJustMoved = GUI.windowXJustChanged or GUI.windowYJustChanged
  GUI.keyboardChar = gfx.getchar()
  GUI.mouseCap = gfx.mouse_cap
  GUI.mouseX = gfx.mouse_x
  GUI.mouseY = gfx.mouse_y
  GUI.mouseWheel = gfx.mouse_wheel / 120
  gfx.mouse_wheel = 0
  GUI.mouseHWheel = gfx.mouse_hwheel / 120
  gfx.mouse_hwheel = 0
  GUI.mouseWheelJustMoved = GUI.mouseWheel ~= 0
  GUI.mouseHWheelJustMoved = GUI.mouseHWheel ~= 0
  GUI.mouseXChange = GUI.mouseX - GUI.mouseXPrevious
  GUI.mouseXJustChanged = GUI.mouseX ~= GUI.mouseXPrevious
  GUI.mouseYChange = GUI.mouseY - GUI.mouseYPrevious
  GUI.mouseYJustChanged = GUI.mouseY ~= GUI.mouseYPrevious
  GUI.mouseJustMoved = GUI.mouseXJustChanged or GUI.mouseYJustChanged
  GUI.mouseLeftIsPressed = GUI.mouseCap & 1 == 1
  GUI.mouseLeftJustPressed = GUI.mouseLeftIsPressed and not GUI.mouseLeftWasPressed
  GUI.mouseLeftJustReleased = GUI.mouseLeftWasPressed and not GUI.mouseLeftIsPressed
  GUI.mouseLeftJustDragged = GUI.mouseLeftIsPressed and GUI.mouseJustMoved
  GUI.mouseMiddleIsPressed = GUI.mouseCap & 64 == 64
  GUI.mouseMiddleJustPressed = GUI.mouseMiddleIsPressed and not GUI.mouseMiddleWasPressed
  GUI.mouseMiddleJustReleased = GUI.mouseMiddleWasPressed and not GUI.mouseMiddleIsPressed
  GUI.mouseMiddleJustDragged = GUI.mouseMiddleIsPressed and GUI.mouseJustMoved
  GUI.mouseRightIsPressed = GUI.mouseCap & 2 == 2
  GUI.mouseRightJustPressed = GUI.mouseRightIsPressed and not GUI.mouseRightWasPressed
  GUI.mouseRightJustReleased = GUI.mouseRightWasPressed and not GUI.mouseRightIsPressed
  GUI.mouseRightJustDragged = GUI.mouseRightIsPressed and GUI.mouseJustMoved
  GUI.shiftIsPressed = GUI.mouseCap & 8 == 8
  GUI.shiftJustPressed = GUI.shiftIsPressed and not GUI.shiftWasPressed
  GUI.shiftJustReleased = GUI.shiftWasPressed and not GUI.shiftIsPressed
  GUI.shiftJustDragged = GUI.shiftIsPressed and GUI.mouseJustMoved
  GUI.controlIsPressed = GUI.mouseCap & 4 == 4
  GUI.controlJustPressed = GUI.controlIsPressed and not GUI.controlWasPressed
  GUI.controlJustReleased = GUI.controlWasPressed and not GUI.controlIsPressed
  GUI.controlJustDragged = GUI.controlIsPressed and GUI.mouseJustMoved
  GUI.windowsIsPressed = GUI.mouseCap & 32 == 32
  GUI.windowsJustPressed = GUI.windowsIsPressed and not GUI.windowsWasPressed
  GUI.windowsJustReleased = GUI.windowsWasPressed and not GUI.windowsIsPressed
  GUI.windowsJustDragged = GUI.windowsIsPressed and GUI.mouseJustMoved
  GUI.altIsPressed = GUI.mouseCap & 16 == 16
  GUI.altJustPressed = GUI.altIsPressed and not GUI.altWasPressed
  GUI.altJustReleased = GUI.altWasPressed and not GUI.altIsPressed
  GUI.altJustDragged = GUI.altIsPressed and GUI.mouseJustMoved

  -- Pass through the space bar.
  if GUI.keyboardChar == 32 then reaper.Main_OnCommandEx(40044, 0, 0) end

  GUI.update()

  if GUI.windowJustMoved or GUI.windowJustResized or GUI.windowDockJustChanged then
    reaper.SetExtState(GUI.windowTitle, "windowX", GUI.windowX, true)
    reaper.SetExtState(GUI.windowTitle, "windowY", GUI.windowY, true)
    reaper.SetExtState(GUI.windowTitle, "windowW", GUI.windowW, true)
    reaper.SetExtState(GUI.windowTitle, "windowH", GUI.windowH, true)
    reaper.SetExtState(GUI.windowTitle, "windowDock", GUI.windowDock, true)
  end

  GUI.mouseCapPrevious = GUI.mouseCap
  GUI.mouseXPrevious = GUI.mouseX
  GUI.mouseYPrevious = GUI.mouseY
  GUI.windowXPrevious = GUI.windowX
  GUI.windowYPrevious = GUI.windowY
  GUI.windowWPrevious = GUI.windowW
  GUI.windowHPrevious = GUI.windowH
  GUI.windowDockPrevious = GUI.windowDock
  GUI.mouseLeftWasPressed = GUI.mouseLeftIsPressed
  GUI.mouseMiddleWasPressed = GUI.mouseMiddleIsPressed
  GUI.mouseRightWasPressed = GUI.mouseRightIsPressed
  GUI.shiftWasPressed = GUI.shiftIsPressed
  GUI.controlWasPressed = GUI.controlIsPressed
  GUI.windowsWasPressed = GUI.windowsIsPressed
  GUI.altWasPressed = GUI.altIsPressed

  -- Keep the window open unless escape or the close button are pushed.
  if GUI.keyboardChar ~= 27 and GUI.keyboardChar ~= -1 then reaper.defer(GUI.run) end

  gfx.update()
end

local function drawStr(value, flags, x, y, right, bottom)
  local xCut = x + 0.5 * (right - x)
  local yCut = y + 0.5 * (bottom - y)
  if xCut >= 0 and xCut < GUI.windowW and yCut >= 0 and yCut < GUI.windowH then
    gfx.x = x
    gfx.y = y
    gfx.drawstr(value, flags, right, bottom)
  end
end

---------------------------------- Button ----------------------------------

local Button = {}

function Button:init()
  local self = {}
  self.title = ""
  self.x = 0
  self.y = 0
  self.w = 0
  self.h = 0
  self.r = 0.9
  self.g = 0.9
  self.b = 0.9
  self.a = 1.0
  self.isPressed = false
  return self
end

function Button:mouseIsInside()
  local mX, mY, x, y, w, h = GUI.mouseX, GUI.mouseY, self.x, self.y, self.w, self.h
  return mX >= x and mX <= x + w and mY >= y and mY <= y + h
end

function Button:draw()
  -- Fill:
  if self.isPressed then
    local fillTint = 0.35
    gfx.set(fillTint * self.r, fillTint * self.g, fillTint * self.b, self.a, 0)
    gfx.rect(self.x + 1, self.y + 1, self.w - 1, self.h - 1, true)
  end

  -- Outline:
  gfx.set(self.r, self.g, self.b, self.a, 0)
  gfx.rect(self.x, self.y, self.w, self.h, false)

  -- Title:
  drawStr(self.title, 5, self.x + 2, self.y + 2, self.x + self.w - 2, self.y + self.h - 2)
end

---------------------------------- Button Row ----------------------------------

local ButtonRow = {}

function ButtonRow:init()
  local self = {}
  self.maxButtons = 1
  self.buttons = {}
  self.x = 0
  self.y = 0
  self.w = 0
  self.buttonW = 0
  self.h = 0
  self.spacing = 1
  return self
end

function ButtonRow:updateButtons()
  self.buttonW = (self.w - self.spacing * self.maxButtons) / self.maxButtons

  local numButtons = #self.buttons
  for i = 1, numButtons do
    local button = self.buttons[i]
    button.x = self.x + (self.buttonW + self.spacing) * (i - 1)
    button.y = self.y
    button.w = self.buttonW
    button.h = self.h
  end
end

function ButtonRow:draw()
  local numButtons = #self.buttons

  for i = 1, numButtons do
    Button.draw(self.buttons[i])
  end
end

---------------------------------- Program ----------------------------------

local yScroll = 0
local yScrollWheelSensitivity = 30.0
local finalSubMasterScroll = 0

local function wipeScreen()
  gfx.set(0.08, 0.08, 0.08, 1, 0)
  gfx.rect(0, 0, GUI.windowW, GUI.windowH, true)
end

local function contains(t, v)
  local count = #t
  for i = 1, count do
    local value = t[i]
    if v == value then
      return true
    end
  end
  return false
end

local function getMonoSends(inputTrack, outputTrack)
  local output = {}
  local numSends = reaper.GetTrackNumSends(inputTrack, 0)

  for sendNumber = 1, numSends do
    local destTrack = reaper.GetTrackSendInfo_Value(inputTrack, 0, sendNumber - 1, "P_DESTTRACK")

    if destTrack == outputTrack then
      local channelIndex = reaper.GetTrackSendInfo_Value(inputTrack, 0, sendNumber - 1, "I_DSTCHAN")
      local channelIsMono = channelIndex & 1024 == 1024

      if channelIsMono then
        local send = {}
        send.number = sendNumber
        send.outputChannel = channelIndex - 1023
        table.insert(output, send)
      end
    end
  end

  return output
end

local function getStereoSends(inputTrack, outputTrack)
  local output = {}
  local numSends = reaper.GetTrackNumSends(inputTrack, 0)

  for sendNumber = 1, numSends do
    local destTrack = reaper.GetTrackSendInfo_Value(inputTrack, 0, sendNumber - 1, "P_DESTTRACK")

    if destTrack == outputTrack then
      local channelIndex = reaper.GetTrackSendInfo_Value(inputTrack, 0, sendNumber - 1, "I_DSTCHAN")
      local sourceMode = reaper.GetTrackSendInfo_Value(inputTrack, 0, sendNumber - 1, "I_SRCCHAN")
      local channelIsStereo = (channelIndex & 1024 == 0) and (sourceMode > -1)

      if channelIsStereo then
        local send = {}
        send.number = sendNumber
        send.outputChannel = channelIndex + 1
        table.insert(output, send)
      end
    end
  end

  return output
end

local function removeChannelSends(inputTrack, sends, numSends, channel)
  for sendId = 1, numSends do
    if channel == sends[sendId].outputChannel then
      reaper.RemoveTrackSend(inputTrack, 0, sends[sendId].number - 1)
    end
  end
end

local function createChannelSends(isMono, inputTrack, outputTrack, channel)
  local channelIndex = channel - 1
  if isMono then
    channelIndex = channelIndex + 1024
  end
  local newSendIndex = reaper.CreateTrackSend(inputTrack, outputTrack)
  reaper.SetTrackSendInfo_Value(inputTrack, 0, newSendIndex, "I_DSTCHAN", channelIndex)
end

local boxSelect = nil
local function processChannel(isMono, inputTrack, outputTrack, button, channel)
  local sends = nil
  if isMono then
    sends = getMonoSends(inputTrack, outputTrack)
  else
    sends = getStereoSends(inputTrack, outputTrack)
  end
  local numSends = #sends
  local channelIsOccupied = false

  for sendId = 1, numSends do
    if channel == sends[sendId].outputChannel then
      channelIsOccupied = true
    end
  end

  if Button.mouseIsInside(button) and GUI.mouseLeftJustPressed then
    boxSelect = {}
    boxSelect.xStart = GUI.mouseX
    boxSelect.yStart = GUI.mouseY

    if channelIsOccupied then
      removeChannelSends(inputTrack, sends, numSends, channel)
      boxSelect.mode = "Remove"
    else
      createChannelSends(isMono, inputTrack, outputTrack, channel)
      boxSelect.mode = "Create"
    end

  elseif GUI.mouseLeftJustReleased then
    boxSelect = nil

  elseif boxSelect and GUI.mouseLeftIsPressed then
    local buttonIsInsideBoxSelect = math.min(boxSelect.xStart, GUI.mouseX) < (button.x + button.w) and
                                    math.max(boxSelect.xStart, GUI.mouseX) > button.x and
                                    math.min(boxSelect.yStart, GUI.mouseY) < (button.y + button.h) and
                                    math.max(boxSelect.yStart, GUI.mouseY) > button.y

    if buttonIsInsideBoxSelect then
      if channelIsOccupied then
        if boxSelect.mode == "Remove" then
          removeChannelSends(inputTrack, sends, numSends, channel)
        end
      else
        if boxSelect.mode == "Create" then
          createChannelSends(isMono, inputTrack, outputTrack, channel)
        end
      end
    end
  end

  button.isPressed = channelIsOccupied
end

local function processSubMaster(inputTrack, subMaster, subMasterNumber)
  local _, subMasterName = reaper.GetTrackName(subMaster)
  local inset = 24
  local w = GUI.windowW - 2.0 * inset - 1
  local h = 32
  local x = inset
  local monoChannelsPerRow = 16
  local numMono = reaper.GetMediaTrackInfo_Value(subMaster, "I_NCHAN")
  local numMonoRows = math.ceil(numMono / monoChannelsPerRow)
  local stereoChannelsPerRow = 16
  local numStereo = numMono - 1
  local numStereoRows = math.ceil(numStereo / stereoChannelsPerRow)
  local monoHeight = numMonoRows * (h + 1)
  local stereoHeight = numStereoRows * (h + 1)
  local monoStereoSpacing = 12
  local trackSpacing = 32
  local fullHeight = monoHeight + stereoHeight + trackSpacing
  local y = yScroll + trackSpacing + (subMasterNumber - 1) * (fullHeight + monoStereoSpacing)

  finalSubMasterScroll = -(subMasterNumber - 1) * (fullHeight + monoStereoSpacing)

  --------------------- Title ---------------------

  drawStr(subMasterName, 5, x, y - trackSpacing, x + w, y)

  --------------------- Mono Rows ---------------------

  for rowNumber = 1, numMonoRows do
    local row = ButtonRow.init()
    row.maxButtons = monoChannelsPerRow
    row.w = w
    row.h = h
    row.x = x
    row.y = y + (rowNumber - 1) * (h + 1)

    local channelStart = 1 + (rowNumber - 1) * monoChannelsPerRow
    local channelEnd = math.min(rowNumber * monoChannelsPerRow, numMono)

    for channel = channelStart, channelEnd do
      local rowChannelIndex = channel - channelStart + 1
      row.buttons[rowChannelIndex] = Button.init()
      row.buttons[rowChannelIndex].title = channel
    end

    ButtonRow.updateButtons(row)

    for channel = channelStart, channelEnd do
      local rowChannelIndex = channel - channelStart + 1
      processChannel(true, inputTrack, subMaster, row.buttons[rowChannelIndex], channel)
    end

    ButtonRow.draw(row)
  end

  --------------------- Stereo Row ---------------------

  for rowNumber = 1, numStereoRows do
    local row = ButtonRow.init()
    row.maxButtons = stereoChannelsPerRow
    row.w = w
    row.h = h
    row.x = x
    row.y = monoStereoSpacing + y + monoHeight + (rowNumber - 1) * (h + 1)

    local channelStart = 1 + (rowNumber - 1) * stereoChannelsPerRow
    local channelEnd = math.min(rowNumber * stereoChannelsPerRow, numStereo)

    for channel = channelStart, channelEnd do
      local rowChannelIndex = channel - channelStart + 1
      row.buttons[rowChannelIndex] = Button.init()
      row.buttons[rowChannelIndex].title = channel .. "/" .. (channel + 1)
    end

    ButtonRow.updateButtons(row)

    for channel = channelStart, channelEnd do
      local rowChannelIndex = channel - channelStart + 1
      processChannel(false, inputTrack, subMaster, row.buttons[rowChannelIndex], channel)
    end

    ButtonRow.draw(row)
  end
end

local subMasters = {}
local function updateSubMasters(sourceTrack)
  local numSends = reaper.GetTrackNumSends(sourceTrack, 0)

  for sendNumber = 1, numSends do
    local destTrack = reaper.GetTrackSendInfo_Value(sourceTrack, 0, sendNumber - 1, "P_DESTTRACK")

    if not contains(subMasters, destTrack) then
      table.insert(subMasters, destTrack)
    end
  end
end

local inputTrack = nil
local inputTrackPrevious = nil

GUI.init("Channel Sends", 900, 500, false, 500, 400)
GUI.setBackgroundColor(0.08, 0.08, 0.08)

function GUI.update()
  if reaper.CountSelectedTracks(0) > 0 then
    inputTrack = reaper.GetSelectedTrack(0, 0)

    if inputTrack ~= inputTrackPrevious then
      subMasters = {}
    end

    updateSubMasters(inputTrack)

    local numSubMasters = #subMasters
    if numSubMasters > 0 then
      for subMasterNumber = 1, numSubMasters do
        processSubMaster(inputTrack, subMasters[subMasterNumber], subMasterNumber)
      end
    else
      wipeScreen()
    end
  else
    wipeScreen()
  end

  yScroll = yScroll + (GUI.mouseWheel * yScrollWheelSensitivity)
  if GUI.mouseMiddleIsPressed and GUI.mouseYJustChanged then
    yScroll = yScroll + GUI.mouseYChange
  end
  yScroll = math.min(yScroll, 0)
  yScroll = math.max(yScroll, finalSubMasterScroll)

  inputTrackPrevious = inputTrack
end

GUI.run()