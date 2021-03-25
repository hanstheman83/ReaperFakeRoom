local function Msg(param) 
    reaper.ShowConsoleMsg(tostring(param).."\n")
end

Room = {
    name = "",
    depth = 0,
    width = 0
}

function Room:New(o)
    o = o or {}
    self.__index = self
    setmetatable(o,self)
    return o
end