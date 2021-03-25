--[[
    The left and right mics are spaced two meters apart (about six and a half feet), 
    and the center mic is about one and a half meters (a little less than five feet) 
    in front of the others. 
    Typically, the Decca Tree was hoisted eight to ten feet above the conductor, 
    depending on the size of the room and ensemble. 
    As for aiming the mics, best results are often achieved by pointing the 
    left and right mics inward and down. The center is aimed down and, well, center. 
    For larger groups, some engineers add two flanking mics. 
    These can be put at the outside edges of the orchestra.

    Spot to Room delay 
    http://www.mee.tcd.ie/~gkearney/MCAT/MAT_Lecture_6_Surround_Recording_2.pdf

    Alternative surround room mic setup 
    http://www.sengpielaudio.com/Surround-Fukada-Hamasaki.pdf

    Traditionally Neumann M50 Tube Microphone [omnidirectional]
    https://www.neumann.com/homestudio/en/cardioid-omni-figure-8-why-do-microphones-have-different-pickup-patterns

    So today a shift towards directional mics for tree and omni for rigger and directional for surround 

    -- more directional at higher frequencies
    -- https://en-de.neumann.com/m-150-tube
    Like its predecessor, the M 150 uses a 12 mm small diaphragm capsule, 
    flush mounted in a 40 mm sphere. The capsule itself is a pressure transducer, 
    but the sphere modifies its omnidirectional pattern to become gradually more directional at higher frequencies. 
    The M 150’s condenser transducer is extraordinary in other respects, too: Its ultra-thin diaphragm is made of titanium, 
    a light yet rigid metal, and spaced only 10 microns from the backplate, also made of titanium. 
    The result is a sound transducer with unparalleled transient response. This delicate capsule is protected by an acoustically open headgrille – 
    shaped just like that of the venerable M 50.
--]]


local function Msg(param) 
    reaper.ShowConsoleMsg(tostring(param).."\n")
end

RoomMic = {
    name = "",
    position = { {["x"] = 0}, {["y"]= 0} }, -- 2D position in room, Bottom left is 0,0
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