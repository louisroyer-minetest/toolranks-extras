std = "lua51+minetest"
unused_args = false
allow_defined_top = true
max_line_length = 90

stds.minetest = {
	read_globals = {
		"minetest",
		"VoxelManip",
		"VoxelArea",
		"PseudoRandom",
		"ItemStack",
		"default",
		table = {
			fields = {
				"copy",
			},
		},
	}
}

read_globals = {
	"toolranks",
	"farming",
}

files["tool_types.lua"] = {
	read_globals = {
		toolranks = {
			fields = {
				get_tool_type = {
					read_only = false,
					other_fields = false
				},
				create_description = {
					read_only = false,
					otherfields = false
				},
			}
		}
	}
}
