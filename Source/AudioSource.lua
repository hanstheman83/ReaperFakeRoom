local function Msg(param) 
    reaper.ShowConsoleMsg(tostring(param).."\n")
end

AudioSource = {
    name = "",
    position = {0,0}, -- 2D position in room
    volume = 0, -- maybe not used..
    mainMic = "" -- will send stereo signal to this mic.. mono to all other

}

function AudioSource:New(o)
    o = o or {}
    self.__index = self
    setmetatable(o,self)
    return o
end