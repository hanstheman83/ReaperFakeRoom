local function Msg(param) 
    reaper.ShowConsoleMsg(tostring(param).."\n")
end

CloseMic = {
    name = "",
    position = {0,0}, -- 2D position in room
    volume = 0, -- maybe not used..
    track = 0, -- will be changed to reaper track[Direct track reference even if index(order in reaper mixer/project) should change]
    delay = 0
}

function CloseMic:New(o)
    o = o or {}
    self.__index = self
    setmetatable(o,self)
    return o
end