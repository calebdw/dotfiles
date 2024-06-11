return {
	"nvim-tree/nvim-tree.lua",
	opts = function()
		local api = require("nvim-tree.api")
		local map = require("calebdw.util").map

		map("n", "<leader>nt", api.tree.toggle)
		map("n", "<leader>nr", api.tree.reload)
		map("n", "<leader>nn", function()
			api.tree.open({ find_file = true })
		end)

		local on_attach = function(bufnr)
			local Map = function(mode, lhs, rhs, desc)
				map(mode, lhs, rhs, { buffer = bufnr, nowait = true, desc = "nvim-tree" .. desc })
			end

			-- Defaults
			-- Map('n', '<CR>',  api.node.open.edit,                    'Open')
			-- Map('n', '<Tab>', api.node.open.preview,                 'Open Preview')

			Map("n", "<C-]>", api.tree.change_root_to_node, "CD")
			Map("n", "<C-e>", api.node.open.replace_tree_buffer, "Open: In Place")
			Map("n", "<C-k>", api.node.show_info_popup, "Info")
			Map("n", "<C-r>", api.fs.rename_sub, "Rename: Omit Filename")
			Map("n", "<C-t>", api.node.open.tab, "Open: New Tab")
			Map("n", "<C-v>", api.node.open.vertical, "Open: Vertical Split")
			Map("n", "<C-x>", api.node.open.horizontal, "Open: Horizontal Split")
			Map("n", "<BS>", api.node.navigate.parent_close, "Close Directory")
			Map("n", "<cr>", api.node.open.preview, "Open Preview")
			Map("n", "<tab>", api.node.open.edit, "Open")
			Map("n", ">", api.node.navigate.sibling.next, "Next Sibling")
			Map("n", "<", api.node.navigate.sibling.prev, "Previous Sibling")
			Map("n", ".", api.node.run.cmd, "Run Command")
			Map("n", "-", api.tree.change_root_to_parent, "Up")
			Map("n", "a", api.fs.create, "Create")
			Map("n", "bmv", api.marks.bulk.move, "Move Bookmarked")
			Map("n", "B", api.tree.toggle_no_buffer_filter, "Toggle No Buffer")
			Map("n", "c", api.fs.copy.node, "Copy")
			Map("n", "C", api.tree.toggle_git_clean_filter, "Toggle Git Clean")
			Map("n", "[c", api.node.navigate.git.prev, "Prev Git")
			Map("n", "]c", api.node.navigate.git.next, "Next Git")
			Map("n", "d", api.fs.remove, "Delete")
			Map("n", "D", api.fs.trash, "Trash")
			Map("n", "E", api.tree.expand_all, "Expand All")
			Map("n", "e", api.fs.rename_basename, "Rename: Basename")
			Map("n", "]e", api.node.navigate.diagnostics.next, "Next Diagnostic")
			Map("n", "[e", api.node.navigate.diagnostics.prev, "Prev Diagnostic")
			Map("n", "F", api.live_filter.clear, "Clean Filter")
			Map("n", "f", api.live_filter.start, "Filter")
			Map("n", "g?", api.tree.toggle_help, "Help")
			Map("n", "gy", api.fs.copy.absolute_path, "Copy Absolute Path")
			Map("n", "H", api.tree.toggle_hidden_filter, "Toggle Dotfiles")
			Map("n", "I", api.tree.toggle_gitignore_filter, "Toggle Git Ignore")
			Map("n", "J", api.node.navigate.sibling.last, "Last Sibling")
			Map("n", "K", api.node.navigate.sibling.first, "First Sibling")
			Map("n", "m", api.marks.toggle, "Toggle Bookmark")
			Map("n", "o", api.node.open.edit, "Open")
			Map("n", "O", api.node.open.no_window_picker, "Open: No Window Picker")
			Map("n", "p", api.fs.paste, "Paste")
			Map("n", "P", api.node.navigate.parent, "Parent Directory")
			Map("n", "q", api.tree.close, "Close")
			Map("n", "r", api.fs.rename, "Rename")
			Map("n", "R", api.tree.reload, "Refresh")
			Map("n", "s", api.node.run.system, "Run System")
			Map("n", "S", api.tree.search_node, "Search")
			Map("n", "U", api.tree.toggle_custom_filter, "Toggle Hidden")
			Map("n", "W", api.tree.collapse_all, "Collapse")
			Map("n", "x", api.fs.cut, "Cut")
			Map("n", "y", api.fs.copy.filename, "Copy Name")
			Map("n", "Y", api.fs.copy.relative_path, "Copy Relative Path")
			Map("n", "<2-LeftMouse>", api.node.open.edit, "Open")
			Map("n", "<2-RightMouse>", api.tree.change_root_to_node, "CD")
		end

		return {
			-- open_on_setup = true,
			git = {
				ignore = false,
			},
			on_attach = on_attach,
			renderer = {
				indent_markers = {
					enable = true,
				},
				-- icons = {
				--   glyphs = require('nvim-nonicons.extentions.nvim-tree').glyphs,
				-- },
			},
			respect_buf_cwd = false,
			-- sync_root_with_cwd = false,
			update_focused_file = {
				-- enable = true,
				update_root = true,
			},
		}
	end,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		-- 'yamatsum/nvim-nonicons',
	},
}
