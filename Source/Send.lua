local function Msg(param) 
    reaper.ShowConsoleMsg(tostring(param).."\n")
end

Send = {
    name = "",
    destinationTrack = 0 
}

function Send:New(o)
    o = o or {}
    self.__index = self
    setmetatable(o,self)
    return o
end