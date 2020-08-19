local MP = minetest.get_modpath("toolranks_extras")

toolranks_extras = {}

-- mod information
toolranks_extras.mod = {version = "1.4.2", author = "Louis Royer"}

-- settings
toolranks_extras.settings = {
	enable_farming_tools = minetest.settings:get_bool("toolranks_extras.farming", true),
	enable_tool_types = minetest.settings:get_bool("toolranks_extras.tool_types", true),
}

-- XXX: when https://github.com/minetest/minetest/pull/7377
--      is merged, we can remove this function
--      and %s/toolranks_extras\.log/minetest\.log/g
toolranks_extras.log = function(level, text)
	local prefix = "[toolranks_extra] "
	if text then
		minetest.log(level, prefix..text)
	else
		minetest.log(prefix..level)
	end
end

-- mods detection
local use_farming = minetest.get_modpath("farming")
-- farming redo (https://notabug.org/tenplus1/farming)
-- already implements toolranks support
local use_farming_redo = use_farming and (farming.mod == "redo") or false

-- toolranks version
if toolranks.add_tool == nil then
	toolranks_extras.log("error", "Please a more recent version of"
		.." toolranks (at least version 1.2).")
end

dofile(MP.."/tool_types.lua")
if use_farming and (not use_farming_redo)
	and toolranks_extras.settings.enable_farming_tools then
	dofile(MP.."/hoe.lua")
end
