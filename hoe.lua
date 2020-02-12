local function add_hoe(material)
	local name = "farming:hoe_"..material
	local desc = ItemStack(name):get_definition().description
	minetest.override_item(name, {
		original_description = desc,
		description = toolranks.create_description(desc, 0, 1),
		after_use = toolranks.new_afteruse
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
