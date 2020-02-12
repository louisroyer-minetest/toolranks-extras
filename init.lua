local MP = minetest.get_modpath("toolranks_extras")

if minetest.settings:get_bool("toolranks_extra.farming", true) then
	dofile(MP.."/hoe.lua")
end
