local MP = minetest.get_modpath("toolranks_extras")
local enable_farming_tools = minetest.settings:get_bool("toolranks_extra.farming", true)
local use_farming = minetest.get_modpath("farming")

-- farming redo (https://notabug.org/tenplus1/farming)
-- already implements toolranks support
local use_farming_redo = (farming.mod == "redo")


if use_farming and (not use_farming_redo) and enable_farming_tools then
	dofile(MP.."/hoe.lua")
end
