loadfile("C:/Users/pract/Documents/Repos/ReaperPlugins/Lua/ReaperFakeRoom/Source/Send.lua")()

local function Msg(param) 
    reaper.ShowConsoleMsg(tostring(param).."\n")
end

AudioSource = {
    name = "",
    position = {0,0}, -- 2D position in room
    volume = 0, -- maybe not used..
    track = 0, -- will be changed to reaper track[Direct track reference even if index(order in reaper mixer/project) should change]
    mainMic = "", -- will send stereo signal to this mic.. mono to all other
    roomMicsSendsList = {}, -- list all sends
    closeMicsSendsList = {} -- 1st in list is ref to main mic, stereo send
}

function AudioSource:New(o)
    o = o or {}
    self.__index = self
    setmetatable(o,self)
    return o
end

function AudioSource:Ini() -- input all mic lists.. 
    -- calculate sends to mics from distances.. 
    -- each send should hold reverb and delay data...
    local newSend = Send:New()
    newSend.name = "new name"
    Msg("new send name "..newSend.name)
end