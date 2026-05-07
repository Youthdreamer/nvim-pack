local servers = {
	-- lua
	["lua_ls"] = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					-- path = vim.split(package.path, ";"),
				},
				diagnostics = {
					globals = { "vim" },
				},
				codeLens = {
					enable = true,
				},
				workspace = {
					checkThirdParty = false,
					library = { vim.env.VIMRUNTIME },
				},
				hint = {
					enable = true,
					setType = false,
					paramType = true,
					paramName = "Disable",
					semicolon = "Disable",
					arrayIndex = "Disable",
				},
			},
		},
	},
	-- rust
	["rust_analyzer"] = {
		settings = {
			["rust-analyzer"] = {
				check = { command = "clippy", onSave = true },
				inlayHints = {
					chainingHints = { enable = true },
					enable = true,
					parameterHints = { enable = true },
					typeHints = { enable = true },
				},
			},
		},
	},
}

return servers
