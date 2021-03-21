--[[
    The left and right mics are spaced two meters apart (about six and a half feet), and the center mic is about one and a half meters (a little less than five feet) in front of the others. Typically, the Decca Tree was hoisted eight to ten feet above the conductor, depending on the size of the room and ensemble. As for aiming the mics, best results are often achieved by pointing the left and right mics inward and down. The center is aimed down and, well, center. For larger groups, some engineers add two flanking mics. These can be put at the outside edges of the orchestra.
--]]


local function Msg(param) 
    reaper.ShowConsoleMsg(tostring(param).."\n")
end

RoomMic = {
    name = "",
    position = {0,0}, -- 2D position in room
    volume = 0, -- maybe not used..
    track = 0, -- will be changed to reaper track[Direct track reference even if index(order in reaper mixer/project) should change]
    delay = 0 -- 
}

function RoomMic:New(o)
    o = o or {}
    self.__index = self
    setmetatable(o,self)
    return o
end