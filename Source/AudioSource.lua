local function Msg(param) 
    reaper.ShowConsoleMsg(tostring(param).."\n")
end

AudioSource = {
    name = "",
    position = {0,0}, -- 2D position in room
    volume = 0, -- maybe not used..
    track = 0, -- will be changed to reaper track[Direct track reference even if index(order in reaper mixer/project) should change]
    mainMic = "", -- will send stereo signal to this mic.. mono to all other
    sendsList = {} -- list all sends
}

function AudioSource:New(o)
    o = o or {}
    self.__index = self
    setmetatable(o,self)
    return o
end