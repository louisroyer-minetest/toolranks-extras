local MP = minetest.get_modpath("toolranks_extras")
local use_mtg_farming = minetest.get_modpath("farming")

if use_mtg_farming and minetest.settings:get_bool("toolranks_extra.farming", true) then
	dofile(MP.."/hoe.lua")
end
