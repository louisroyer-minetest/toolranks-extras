local function add_hoe(material)
	-- registering as tool
	local name = "farming:hoe_"..material
	toolranks.add_tool(name)

	-- getting after_use
	local def = minetest.registered_items[name]
	local hoe_on_use = def.on_use
	local hoe_after_use = def.after_use

	if (hoe_on_use == nil) or (hoe_after_use == nil) then
		return
	end
	minetest.override_item(name, {
		-- we also want hoes to increase dugnodes when farming soil
		on_use = function(itemstack, user, pointed_thing, uses)
			local under = minetest.get_node(pointed_thing.under)
			-- get origin wear
			local wear = itemstack:get_wear()
			-- apply previous on_use
			local ret_itemstack = hoe_on_use(itemstack, user, pointed_thing, uses)
			if ret_itemstack == nil then
				return nil
			end
			-- compute wear diff
			local hoe_uses = ret_itemstack:get_wear() - wear
			-- set wear back because it is up to hoe_after_use to add wear
			ret_itemstack:set_wear(wear)
			-- apply afteruse
			return hoe_after_use(ret_itemstack, user, under, {wear = hoe_uses})
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
