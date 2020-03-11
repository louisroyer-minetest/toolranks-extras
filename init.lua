local MP = minetest.get_modpath("toolranks_extras")

toolranks_extras = {}

-- mod information
toolranks_extras.mod = {version = "1.3.1", author = "Louis Royer"}

-- settings
toolranks_extras.settings =
	{enable_farming_tools = minetest.settings:get_bool("toolranks_extra.farming", true)}

-- mods detection
local use_farming = minetest.get_modpath("farming")
-- farming redo (https://notabug.org/tenplus1/farming)
-- already implements toolranks support
local use_farming_redo = use_farming and (farming.mod == "redo") or false


if use_farming and (not use_farming_redo)
	and toolranks_extras.settings.enable_farming_tools then
	dofile(MP.."/hoe.lua")
end
