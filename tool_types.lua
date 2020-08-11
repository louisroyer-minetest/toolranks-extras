toolranks_extras.registered_tool_types = {}
--[[
--   `keyword` is a string to be detected in tool description
--   `tool_type` is a localized tool type (if nil, then unregister the keyword)
-- example
-- `toolranks_extras.register_tool_type("battle_axe", S("battle axe"))`
--]]
toolranks_extras.register_tool_type = function(keyword, tool_type)
	toolranks_extras.registered_tool_types[string.lower(keyword)] = tool_type
end

toolranks_extras.ignored_toolranks_tool_types = {}
--[[
--   `keyword` is a string to be detected in tool description
--   `tool_type` is a localized tool type
--
-- example
-- `toolranks_extras.ignore_toolranks_tool_type("pickaxe")`
-- This only works with tool types built in toolranks default get_tool_types function.
--]]
toolranks_extras.ignore_toolranks_tool_type = function(keyword)
	table.insert(toolranks_extras.ignored_toolranks_tool_types, string.lower(keyword))
end
toolranks_extras.ignore_toolranks_tool_type("tool")

if toolranks_extras.settings.enable_tool_types then
	local TR = minetest.get_translator("toolranks")
	local origin_get_tool_type = toolranks.get_tool_type
	--[[
	-- Returns nil if the keyword is ignored, else returns the keyword.
	--]]
	local function check_ignore(keyword)
		for _, k in ipairs(toolranks_extras.ignored_toolranks_tool_types) do
			if keyword == k then
				return
			end
		end
		return keyword
	end

	-- overwrite of toolranks.get_tool_type(description)
	toolranks.get_tool_type = function(description)
		-- execute original function
		local tool_type = check_ignore(origin_get_tool_type(description))
		if tool_type ~= nil then
			return TR(tool_type)
		end
		-- search for registered tool types
		local d = string.lower(description)
		for k, desc in pairs(toolranks_extras.registered_tool_types) do
			if string.find(d, k) then
				return desc
			end
		end
		-- fallback
		return TR("tool")
	end

	-- overwrite of toolranks.create_description(name, uses)
	toolranks.create_description = function(name, uses)
		local tooltype = toolranks.get_tool_type(name)
		local newdesc = TR(
			"@1@2\n@3Level @4 @5\n@6@Node dug: @7",
			toolranks.colors.green,
			name,
			toolranks.colors.gold,
			toolranks.get_level(uses),
			tooltype,
			toolranks.colors.grey,
			(type(uses) == "number" and uses or 0)
			)
		return newdesc
	end
end
