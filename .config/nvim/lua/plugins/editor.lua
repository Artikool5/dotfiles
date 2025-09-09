return {
	{ "folke/flash.nvim", opts = {
		labels = "aoeuhtnsidpgcrlqjkvwmbxyfz",
	} },
	{
		"barrett-ruth/live-server.nvim",
		build = "pnpm add -g live-server",
		cmd = { "LiveServerStart", "LiveServerStop" },
		config = true,
	},
		},
			},
		},
	},
	{ "nvim-neo-tree/neo-tree.nvim", enabled = false },
}
