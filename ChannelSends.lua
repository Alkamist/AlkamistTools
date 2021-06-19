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
  self.fillMono = false
  self.fillLeft = false
  self.fillRight = false
  return self
end

function Button:mouseIsInside()
  local mX, mY, x, y, w, h = GUI.mouseX, GUI.mouseY, self.x, self.y, self.w, self.h
  return mX >= x and mX <= x + w and mY >= y and mY <= y + h
end

function Button:draw()
  local halfW = 0.5 * self.w
  local halfH = 0.5 * self.h
  local monoW = math.min(30, self.w)
  local monoH = math.min(20, self.h)
  local stereoW = math.min(34, self.w)
  local stereoH = math.min(24, self.h)

  -- Background:

  gfx.set(0.12, 0.12, 0.12, 1, 0)
  gfx.rect(self.x, self.y, self.w, self.h, true)

  -- Stereo:

  if self.fillLeft and self.fillRight then
    gfx.set(0.7, 0.2, 0.2, 1, 0)
    gfx.rect(self.x + 4, self.y + 4, self.w - 8, self.h - 8, true)
  elseif self.fillLeft then
    gfx.set(0.2, 0.2, 0.7, 1, 0)
    gfx.rect(self.x + 4, self.y + 4, self.w - 8, self.h - 8, true)
  elseif self.fillRight then
    gfx.set(0.2, 0.2, 0.7, 1, 0)
    gfx.rect(self.x + 8, self.y + 8, self.w - 16, self.h - 16, true)
  end

  -- Mono:

  if self.fillMono then
    gfx.set(0.2, 0.7, 0.2, 1, 0)
    local monoW = math.max(self.w - 32, 12)
    gfx.rect(self.x + halfW - 0.5 * monoW, self.y + 2, monoW, self.h - 4, true)
  end

  -- Outline:

  if Button.mouseIsInside(self) then
    gfx.set(1.0, 1.0, 1.0, 0.9, 0)
  else
    gfx.set(1.0, 1.0, 1.0, 0.5, 0)
  end
  gfx.rect(self.x, self.y, self.w, self.h, false)

  -- Title:

  gfx.set(1.0, 1.0, 1.0, 0.9, 0)
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

local monoBoxSelect = nil
local stereoBoxSelect = nil
local stereoIsOccupiedPrevious = false
local function processChannel(inputTrack, outputTrack, button, channel, numChannels)
  ----------------------- Mono -----------------------

  local monoSends = getMonoSends(inputTrack, outputTrack)
  local numMonoSends = #monoSends
  local monoIsOccupied = false

  for sendId = 1, numMonoSends do
    if channel == monoSends[sendId].outputChannel then
      monoIsOccupied = true
    end
  end

  if Button.mouseIsInside(button) and GUI.mouseRightJustPressed then
    monoBoxSelect = {}
    monoBoxSelect.xStart = GUI.mouseX
    monoBoxSelect.yStart = GUI.mouseY

    if monoIsOccupied then
      removeChannelSends(inputTrack, monoSends, numMonoSends, channel)
      monoBoxSelect.mode = "Remove"
    else
      createChannelSends(true, inputTrack, outputTrack, channel)
      monoBoxSelect.mode = "Create"
    end

  elseif GUI.mouseRightJustReleased then
    monoBoxSelect = nil

  elseif monoBoxSelect and GUI.mouseRightIsPressed then
    local buttonIsInsideBoxSelect = math.min(monoBoxSelect.xStart, GUI.mouseX) < (button.x + button.w) and
                                    math.max(monoBoxSelect.xStart, GUI.mouseX) > button.x and
                                    math.min(monoBoxSelect.yStart, GUI.mouseY) < (button.y + button.h) and
                                    math.max(monoBoxSelect.yStart, GUI.mouseY) > button.y

    if buttonIsInsideBoxSelect then
      if monoIsOccupied then
        if monoBoxSelect.mode == "Remove" then
          removeChannelSends(inputTrack, monoSends, numMonoSends, channel)
        end
      else
        if monoBoxSelect.mode == "Create" then
          createChannelSends(true, inputTrack, outputTrack, channel)
        end
      end
    end
  end

  button.fillMono = monoIsOccupied

  ----------------------- Stereo -----------------------

  local stereoSends = getStereoSends(inputTrack, outputTrack)
  local numStereoSends = #stereoSends
  local stereoIsOccupied = false

  for sendId = 1, numStereoSends do
    if channel == stereoSends[sendId].outputChannel then
      stereoIsOccupied = true
    end
  end

  if Button.mouseIsInside(button) and GUI.mouseLeftJustPressed then
    stereoBoxSelect = {}
    stereoBoxSelect.xStart = GUI.mouseX
    stereoBoxSelect.yStart = GUI.mouseY
    stereoBoxSelect.isEven = channel % 2 == 0

    if stereoIsOccupied then
      if channel < numChannels then removeChannelSends(inputTrack, stereoSends, numStereoSends, channel) end
      stereoBoxSelect.mode = "Remove"
    else
      if channel < numChannels then createChannelSends(false, inputTrack, outputTrack, channel) end
      stereoBoxSelect.mode = "Create"
    end

  elseif GUI.mouseLeftJustReleased then
    stereoBoxSelect = nil

  elseif stereoBoxSelect and GUI.mouseLeftIsPressed then
    local buttonIsInsideBoxSelect = math.min(stereoBoxSelect.xStart, GUI.mouseX) < (button.x + button.w) and
                                    math.max(stereoBoxSelect.xStart, GUI.mouseX) > button.x and
                                    math.min(stereoBoxSelect.yStart, GUI.mouseY) < (button.y + button.h) and
                                    math.max(stereoBoxSelect.yStart, GUI.mouseY) > button.y
    local isEven = channel % 2 == 0
    local matchingEvens = isEven and stereoBoxSelect.isEven
    local machingOdds = (not isEven) and (not stereoBoxSelect.isEven)

    if buttonIsInsideBoxSelect and (matchingEvens or machingOdds) then
      if stereoIsOccupied then
        if stereoBoxSelect.mode == "Remove" then
          if channel < numChannels then removeChannelSends(inputTrack, stereoSends, numStereoSends, channel) end
        end
      else
        if stereoBoxSelect.mode == "Create" then
          if channel < numChannels then createChannelSends(false, inputTrack, outputTrack, channel) end
        end
      end
    end
  end

  button.fillLeft = stereoIsOccupied
  button.fillRight = stereoIsOccupiedPrevious

  stereoIsOccupiedPrevious = stereoIsOccupied
end

local heightAccumulator = 0
local function processSubMaster(inputTrack, subMaster, subMasterNumber)
  local _, subMasterName = reaper.GetTrackName(subMaster)
  local inset = 24
  local trackSpacing = 32
  local w = GUI.windowW - 2.0 * inset - 1
  local h = 32
  local x = inset
  local channelsPerRow = 16
  local numMono = reaper.GetMediaTrackInfo_Value(subMaster, "I_NCHAN")
  local numStereo = numMono - 1
  local numRows = math.ceil(numMono / channelsPerRow)
  local y = yScroll + trackSpacing + heightAccumulator

  finalSubMasterScroll = -heightAccumulator

  heightAccumulator = heightAccumulator + trackSpacing + numRows * (h + 1)

  drawStr(subMasterName, 5, x, y - trackSpacing, x + w, y)

  for rowNumber = 1, numRows do
    local row = ButtonRow.init()
    row.maxButtons = channelsPerRow
    row.w = w
    row.h = h
    row.x = x
    row.y = y + (rowNumber - 1) * (h + 1)

    local channelStart = 1 + (rowNumber - 1) * channelsPerRow
    local channelEnd = math.min(rowNumber * channelsPerRow, numMono)

    for channel = channelStart, channelEnd do
      local rowChannelIndex = channel - channelStart + 1
      row.buttons[rowChannelIndex] = Button.init()
      row.buttons[rowChannelIndex].title = channel
    end

    ButtonRow.updateButtons(row)

    for channel = channelStart, channelEnd do
      local rowChannelIndex = channel - channelStart + 1
      processChannel(inputTrack, subMaster, row.buttons[rowChannelIndex], channel, numMono)
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
    stereoIsOccupiedPrevious = false
    heightAccumulator = 0

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