local function add_hoe(material)
	local name = "farming:hoe_"..material
	local desc = ItemStack(name):get_definition().description
	local hoe_on_use = ItemStack(name):get_definition().on_use
	minetest.override_item(name, {
		original_description = desc,
		description = toolranks.create_description(desc, 0, 1),
		after_use = toolranks.new_afteruse,
		-- we also want hoes to increase dugnodes when farming soil
		on_use = function(itemstack, user, pointed_thing, uses)
			local wear = itemstack:get_wear()
			local ret_itemstack = hoe_on_use(itemstack, user, pointed_thing, uses)
			local hoe_uses = ret_itemstack and ret_itemstack:get_wear() - wear or 0
			if (hoe_uses > 0) then -- increase dugnode if tool damaged
				return toolranks.new_afteruse(ret_itemstack, user, nil, {wear = hoe_uses})
			else
				return ret_itemstack or nil
			end
		end

	})
end


add_hoe("wood")
add_hoe("stone")
add_hoe("steel")

-- Following hoes are not available in creative inventory, but
-- it is possible to /give them
add_hoe("bronze")
add_hoe("mese")
add_hoe("diamond")
