reaper.ShowConsoleMsg("") -- TODO disable

loadfile("C:/Users/pract/Documents/Repos/ReaperPlugins/Lua/Own_GUI/Source/GUILibrary/Core.lua")()
loadfile("C:/Users/pract/Documents/Repos/ReaperPlugins/Lua/Own_GUI/Source/GUILibrary/Classes/Class - Slider.lua")()
loadfile("C:/Users/pract/Documents/Repos/ReaperPlugins/Lua/Own_GUI/Source/GUILibrary/Classes/Class - Button.lua")()
loadfile("C:/Users/pract/Documents/Repos/ReaperPlugins/Lua/Own_GUI/Source/GUILibrary/Classes/Class - Label.lua")()
loadfile("C:/Users/pract/Documents/Repos/ReaperPlugins/Lua/Own_GUI/Source/GUILibrary/Classes/Class - Options.lua")()
loadfile("C:/Users/pract/Documents/Repos/ReaperPlugins/Lua/Own_GUI/Source/GUILibrary/Classes/Class - Knob.lua")()
loadfile("C:/Users/pract/Documents/Repos/ReaperPlugins/Lua/Own_GUI/Source/GUILibrary/Classes/Class - Listbox.lua")()
loadfile("C:/Users/pract/Documents/Repos/ReaperPlugins/Lua/Own_GUI/Source/GUILibrary/Classes/Class - Textbox.lua")()

-- Extra Classes
loadfile("C:/Users/pract/Documents/Repos/ReaperPlugins/Lua/ReaperFakeRoom/Source/AudioSource.lua")()

------------------------------------------------------------------
-------------------- Helper Functions ----------------------------

local function Msg(param)
    reaper.ShowConsoleMsg(tostring(param).."\n")
end

BoolToString = function (bool)
  local convert = {[true] = "true", [false] = "false"}
  return convert[bool]
end

-----------------------------------------------------------------
---------------- shared variables -- ----------------------------
-----------------------------------------------------------------
local currentProject = reaper.GetCurrentProjectInLoadSave()
-- Msg("Reaper current project : "..currentProject)

local audioSourcesList = {}


-----------------------------------------------------
------------------------------------------------------
---------------- functions --------------------------
-----------------------------------------------------
------------------------------------------------------

-- Functions for creating audio sources and tracks
local function CreateAudioSourcesList()
  -- new audio sources into list
  local flutes = AudioSource:New()
  flutes.position = {10,10}
  flutes.name = "Flutes"
  table.insert(audioSourcesList, flutes)
  
  local clarinets = AudioSource:New()
  clarinets.position = {10,10}
  clarinets.name = "Clarinets"
  table.insert(audioSourcesList, clarinets)
  
  local oboes = AudioSource:New()
  oboes.position = {10,10}
  oboes.name = "Oboes"
  table.insert(audioSourcesList, oboes)
  
  local bassoons = AudioSource:New()
  bassoons.position = {10,10}
  bassoons.name = "Bassoons"
  table.insert(audioSourcesList, bassoons)
end

local function CreateAudioSourcesFolders()
  -- create folder for all sources
  local numTracks = reaper.GetNumTracks()
  Msg("num tracks : "..numTracks)
  reaper.InsertTrackAtIndex(numTracks, false)
  local audioSourcesTrack = reaper.GetTrack(currentProject, numTracks)
  -- 50 dark red on windows, 100 lighter red
  reaper.SetTrackColor(audioSourcesTrack, 10500)
  reaper.GetSetMediaTrackInfo_String(audioSourcesTrack, "P_NAME", "AUDIO SOURCES", true)
  
  -- Create individual audio sources tracks from audioSourcesList
  local insertedTrack
  for i = #audioSourcesList, 1, -1  do -- reversed iteration of list..
    Msg("i "..i)
    local index = #audioSourcesList-i + 1 -- from 1 to # of items in list
    Msg("index "..index)
    reaper.InsertTrackAtIndex(numTracks + index, false)  
    insertedTrack = reaper.GetTrack(currentProject, numTracks + index)
    local nameTrack = audioSourcesList[i].name
    Msg("Name new track "..nameTrack)
    reaper.GetSetMediaTrackInfo_String(insertedTrack, "P_NAME", nameTrack , true)
    reaper.SetOnlyTrackSelected(insertedTrack)
    reaper.ReorderSelectedTracks(numTracks + 1, 1) -- move up and set as child 
  end
end

-- Functions for creating mics and tracks
local function CreateRoomMicsList()
  Msg("Creating room mics list..")
end

local function CreateRoomMicsFolders()
  Msg("Creating room mics folders..")
end







--- Functions called directly from Buttons
local function CreateAudioSources()
  Msg("creating audio sources")
  -- get positions from GUI, store in AudioSource object
  CreateAudioSourcesList()
  CreateAudioSourcesFolders()
end

-- boolean reaper.ReorderSelectedTracks(integer beforeTrackIdx, integer makePrevFolder)

local function CreateRoomMics()
  Msg("Creating room mics")
  CreateRoomMicsList()
  CreateRoomMicsFolders()

end

local function CreateCloseMics()
  Msg("Creating close mics")
end



--- Buttons' Callbacks ---
local function Btn_InsertVerb()
  local numTracks = reaper.GetNumTracks()
  Msg("num tracks : "..numTracks)
  reaper.InsertTrackAtIndex(numTracks, false)
  local lastTrack = reaper.GetTrack(0, numTracks)
  local returnVal = reaper.TrackFX_AddByName(lastTrack, "ReaVerbate (Cockos)", false, -1000)
  local returnVal = reaper.TrackFX_AddByName(lastTrack, "ReaComp (Cockos)", false, -1000)
  local returnVal = reaper.TrackFX_AddByName(lastTrack, "Doubler4 Mono (Waves)", false, -1000)
  Msg(returnVal)
  local firstTrack = reaper.GetTrack(0, 0)
  local isSucces = reaper.CreateTrackSend(lastTrack, firstTrack)

  local orgVal = reaper.TrackFX_GetParam(lastTrack, 2, 0)
  Msg("org Val : "..orgVal)
  
  isSucces = reaper.TrackFX_SetParam(lastTrack, 2, 0, orgVal + 10)
  Msg("changed value "..BoolToString(isSucces))
  orgVal = reaper.TrackFX_GetParam(lastTrack, 2, 0)
  Msg("org Val : "..orgVal)

end

local function Btn_CreateRoom()
  -- create tracks
  -- create Audio Sources
  CreateAudioSources()
  -- create Room mics
  CreateRoomMics() -- take input from GUI settings..

  -- create Close mics
  CreateCloseMics()


end



-------------------------
--- Exit functions ------
local function SaveToProject(serializedData)
    
    reaper.SetExtState("ReaperFakeRoom", "SomeData", serializedData, true)
end


local function Save()
  local serializedData = "some data"
--   Msg(serializedData)
  SaveToProject(serializedData)
end

  
local function Exit()
  Msg("exiting..")
  Save()
end



local function InitializeGUI() -- M1
  GUI.name = "Fake Room"
  GUI.x, GUI.y = 860, 20
  GUI.w, GUI.h = 484, 596

-- Labels
  -- GUI.New("label_1", "Label", 1, 30, 465, "C")

-- Sliders
  -- GUI.New("slider_1", "Slider",  1, 156, 472, 48,     "", 0,   2,  1,    1)

-- Checklists
  -- GUI.New("chk_rep", "Checklist", 1, 240, 15 , 160, 80, "Repetitions", "First note repetition, Last note repetition")
  -- GUI.New("radio_ease", "Radio", 1, 240, 160, 160, 80, "Ease In/Out", "Ease In, Ease Out")

-- Knobs
  -- GUI.New("knob_easeInOut_range", "Knob", 2, 295, 350, 30, "Range", 0, 1, 50, 0.01)

  -- GUI.elms_hide[2] = false -- to hide z layer 2...

  -- Listbox
  -- listbox = {"empty block","empty block","empty block","empty block","empty block","empty block","empty block","empty block","empty block","empty block",}
  -- -- listbox = {}
  -- GUI.New("listbox_blocks", "Listbox", 1, 30, 30, 300, 300, listbox,false,"",10)
  -- GUI.elms.listbox_blocks.color = "cyan"

  -- Buttons
  GUI.New("btn_insertVerb", "Button",  1, 180,  544, 124, 24, "Insert Verb", Btn_InsertVerb)
  GUI.New("btn_createFakeRoom", "Button",  1, 30,  544, 124, 24, "Create fake room", Btn_CreateRoom)
  -- GUI.New("btn_deleteBlock", "Button",  1, 350,  544, 124, 24, "DELETE BLOCK", Btn_DeleteBlock)
  -- GUI.New("btn_renameBlock", "Button",  1, 340,  40, 124, 24, "RENAME BLOCK", Btn_RenameBlock)
  -- GUI.New("btn_blockUp", "Button",  1, 345,  120, 50, 24, "UP", Btn_BlockUp)
  -- GUI.New("btn_blockDown", "Button",  1, 407,  120, 50, 24, "DOWN", Btn_BlockDown)
  -- GUI.New("btn_blockBottom", "Button",  1, 350,  160, 110, 24, "BLOCK TO BOTTOM", Btn_BlockBottom)
  -- -- GUI.New("btn_blockTop", "Button",  1, 407,  160, 50, 24, "TOP", Btn_BlockTop)

  -- GUI.New("btn_extendList", "Button",  1, 365,  200, 80, 24, "EXTEND LIST", Btn_ExtendList)
  -- GUI.New("btn_shrinkList", "Button",  1, 365,  240, 80, 24, "SHRINK LIST", Btn_ShrinkList)
  -- GUI.New("btn_saveList", "Button",  1, 365,  340, 80, 24, "EXPORT LIST", Btn_SaveList)
  -- GUI.New("btn_loadList", "Button",  1, 365,  370, 80, 24, "IMPORT LIST", Btn_LoadList)

  -- GUI.elms.btn_extendList.col_fill = "green"
  -- GUI.elms.btn_extendList.col_txt = "white"
  -- GUI.elms.btn_shrinkList.col_txt = "black"
  -- GUI.elms.btn_shrinkList.col_fill = "red"

  -- GUI.elms.btn_deleteBlock.col_fill = "red"
  -- GUI.elms.btn_deleteBlock.col_txt = "black"
  -- GUI.elms.btn_blockUp.col_txt = "white"
  -- GUI.elms.btn_blockUp.col_fill = "green"
  -- GUI.elms.btn_blockDown.col_txt = "white"
  -- GUI.elms.btn_blockDown.col_fill = "green"
  -- GUI.elms.btn_renameBlock.col_txt = "black"
  -- GUI.elms.btn_renameBlock.col_fill = "yellow"
  -- GUI.elms.btn_insertMediaItem.col_txt = "white"
  -- GUI.elms.btn_saveMediaItem.col_txt = "white"
  -- GUI.elms.btn_blockBottom.col_txt = "white"
  -- GUI.elms.btn_blockTop.col_txt = "white"

-- textfield
-- GUI.New("txt_rename", "Textbox",2, 340, 80, 124, 24)
-- GUI.New("txt_listName", "Textbox", 2, 340, 400, 124,24)
--   -- experimental, block implementation
-- GUI.New("block_firstBlock", "Block", 1, 30, 380, 124, 24, "test", "test2")
-- GUI.elms.block_firstBlock.col_fill = "red"
-- GUI.elms.block_firstBlock.col_outline = "black"


  -- INI GUI
  GUI.Init()

  GUI.Main()
end

InitializeGUI()
-- Start()
-- Main()
reaper.atexit(Exit)