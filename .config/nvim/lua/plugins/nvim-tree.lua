return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      local pink      = "#f5c2e7"
      local mauve     = "#cba6f7"
      local base      = "#1e1e2e"
      local surface0  = "#313244"
      local text      = "#cdd6f4"
      local subtext0  = "#a6adc8"
      local overlay0  = "#6c7086"
      local blue      = "#89b4fa"
      local green     = "#a6e3a1"
      local red       = "#f38ba8"
      local yellow    = "#f9e2af"
      local rosewater = "#f5e0dc"
      local teal      = "#94e2d5"
      local sap       = "#74c7ec"


      local function on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        vim.keymap.set("n", "<C-]>",     api.tree.change_root_to_node,        opts("CD"))
        vim.keymap.set("n", "<C-e>",     api.node.open.replace_tree_buffer,   opts("Open: In Place"))
        vim.keymap.set("n", "<C-k>",     api.node.show_info_popup,            opts("Info"))
        vim.keymap.set("n", "<C-r>",     api.fs.rename_sub,                   opts("Rename: Omit Filename"))
        vim.keymap.set("n", "<C-t>",     api.node.open.tab,                   opts("Open: New Tab"))
        vim.keymap.set("n", "<C-v>",     api.node.open.vertical,              opts("Open: Vertical"))
        vim.keymap.set("n", "<C-x>",     api.node.open.horizontal,            opts("Open: Horizontal"))
        vim.keymap.set("n", "<BS>",      api.node.navigate.parent_close,      opts("Close Directory"))
        vim.keymap.set("n", "<CR>",      api.node.open.edit,                  opts("Open"))
        vim.keymap.set("n", "<Tab>",     api.node.open.preview,               opts("Open Preview"))
        vim.keymap.set("n", ">",         api.node.navigate.sibling.next,      opts("Next Sibling"))
        vim.keymap.set("n", "<",         api.node.navigate.sibling.prev,      opts("Previous Sibling"))
        vim.keymap.set("n", ".",         api.node.run.cmd,                    opts("Run Command"))
        vim.keymap.set("n", "-",         api.tree.change_root_to_parent,      opts("Up"))
        vim.keymap.set("n", "a",         api.fs.create,                       opts("Create"))
        vim.keymap.set("n", "bmv",       api.marks.bulk.move,                 opts("Move Bookmarked"))
        vim.keymap.set("n", "B",         api.tree.toggle_no_buffer_filter,    opts("Toggle No Buffer Filter"))
        vim.keymap.set("n", "c",         api.fs.copy.node,                    opts("Copy"))
        vim.keymap.set("n", "C",         api.tree.toggle_git_clean_filter,   opts("Toggle Git Clean Filter"))
        vim.keymap.set("n", "[c",        api.node.navigate.git.prev,          opts("Prev Git"))
        vim.keymap.set("n", "]c",        api.node.navigate.git.next,          opts("Next Git"))
        vim.keymap.set("n", "d",         api.fs.remove,                      opts("Delete"))
        vim.keymap.set("n", "D",         api.fs.trash,                        opts("Trash"))
        vim.keymap.set("n", "E",         api.tree.expand_all,                 opts("Expand All"))
        vim.keymap.set("n", "e",         api.fs.rename_basename,              opts("Rename: Basename"))
        vim.keymap.set("n", "]e",        api.node.navigate.diagnostics.next,  opts("Next Diagnostic"))
        vim.keymap.set("n", "[e",        api.node.navigate.diagnostics.prev,  opts("Prev Diagnostic"))
        vim.keymap.set("n", "F",         api.live_filter.clear,               opts("Clear Filter"))
        vim.keymap.set("n", "f",         api.live_filter.start,               opts("Filter"))
        vim.keymap.set("n", "g?",        api.tree.toggle_help,                opts("Help"))
        vim.keymap.set("n", "gy",        api.fs.copy.absolute_path,           opts("Copy Absolute Path"))
        vim.keymap.set("n", "H",         api.tree.toggle_hidden_filter,       opts("Toggle Dotfiles"))
        vim.keymap.set("n", "I",         api.tree.toggle_gitignore_filter,    opts("Toggle Git Ignore"))
        vim.keymap.set("n", "J",         api.node.navigate.sibling.last,      opts("Last Sibling"))
        vim.keymap.set("n", "K",         api.node.navigate.sibling.first,     opts("First Sibling"))
        vim.keymap.set("n", "m",         api.marks.toggle,                    opts("Toggle Bookmark"))
        vim.keymap.set("n", "o",         api.node.open.edit,                  opts("Open"))
        vim.keymap.set("n", "O",         api.node.open.no_window_picker,      opts("Open: No Window Picker"))
        vim.keymap.set("n", "p",         api.fs.paste,                        opts("Paste"))
        vim.keymap.set("n", "P",         api.node.navigate.parent_close,        opts("Parent Close"))
        vim.keymap.set("n", "q",         api.tree.close,                      opts("Close"))
        vim.keymap.set("n", "r",         api.fs.rename,                       opts("Rename"))
        vim.keymap.set("n", "R",         api.tree.reload,                     opts("Refresh"))
        vim.keymap.set("n", "s",         api.node.run.system,                 opts("Run System"))
        vim.keymap.set("n", "S",         api.tree.search_node,                opts("Search"))
        vim.keymap.set("n", "U",         api.tree.toggle_custom_filter,       opts("Toggle Hidden"))
        vim.keymap.set("n", "W",         api.tree.collapse_all,               opts("Collapse"))
        vim.keymap.set("n", "x",         api.fs.cut,                          opts("Cut"))
        vim.keymap.set("n", "y",         api.fs.copy.filename,                opts("Copy Name"))
        vim.keymap.set("n", "Y",         api.fs.copy.relative_path,           opts("Copy Relative Path"))
        vim.keymap.set("n", "<2-LeftMouse>",  api.node.open.edit,             opts("Open"))
        vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node,   opts("CD"))
      end

      require("nvim-tree").setup({
        on_attach = on_attach,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = { enable = true, update_root = true },
        view = {
          width = 35,
          side = "left",
        },
        renderer = {
          group_empty = true,
          highlight_git = true,
          highlight_opened_files = "name",
          icons = {
            show = { git = true, folder = true, file = true, folder_arrow = true },
            glyphs = {
              default = " ",
              symlink = " ",
              bookmark = " ",
              folder = {
                arrow_closed = ">",
                arrow_open = "v",
                default = " ",
                open = " ",
                empty = " ",
                empty_open = " ",
                symlink = " ",
                symlink_open = " ",
              },
              git = {
                unstaged = "✗",
                staged = "✓",
                unmerged = "=",
                renamed = "»",
                untracked = "★",
                deleted = "✕",
                ignored = "◌",
              },
            },
          },
        },
        filters = { dotfiles = false },
        actions = {
          open_file = { quit_on_open = false, resize_window = true, window_picker = { enable = false } },
        },
        diagnostics = { enable = true, show_on_dirs = true },
      })

      vim.api.nvim_set_hl(0, "NvimTreeNormal",           { bg = base, fg = text })
      vim.api.nvim_set_hl(0, "NvimTreeVertSplit",        { bg = base, fg = base })
      vim.api.nvim_set_hl(0, "NvimTreeEndOfBuffer",      { bg = base, fg = base })
      vim.api.nvim_set_hl(0, "NvimTreeCursorLine",       { bg = surface0 })
      vim.api.nvim_set_hl(0, "NvimTreeRootFolder",       { fg = teal, bold = true })
      vim.api.nvim_set_hl(0, "NvimTreeFolderName",       { fg = blue })
      vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = teal, bold = true })
      vim.api.nvim_set_hl(0, "NvimTreeEmptyFolderName",  { fg = overlay0 })
      vim.api.nvim_set_hl(0, "NvimTreeFolderIcon",       { fg = blue })
      vim.api.nvim_set_hl(0, "NvimTreeSymlink",          { fg = sap })
      vim.api.nvim_set_hl(0, "NvimTreeFileName",         { fg = text })
      vim.api.nvim_set_hl(0, "NvimTreeFileIcon",         { fg = text })
      vim.api.nvim_set_hl(0, "NvimTreeImageFile",        { fg = blue })
      vim.api.nvim_set_hl(0, "NvimTreeSpecialFile",      { fg = yellow })
      vim.api.nvim_set_hl(0, "NvimTreeIndentMarker",     { fg = overlay0 })
      vim.api.nvim_set_hl(0, "NvimTreeGitDirty",         { fg = yellow })
      vim.api.nvim_set_hl(0, "NvimTreeGitNew",           { fg = green })
      vim.api.nvim_set_hl(0, "NvimTreeGitDeleted",       { fg = red })
      vim.api.nvim_set_hl(0, "NvimTreeGitStaged",        { fg = green })
      vim.api.nvim_set_hl(0, "NvimTreeGitMerge",         { fg = yellow })
      vim.api.nvim_set_hl(0, "NvimTreeGitRenamed",       { fg = sap })
      vim.api.nvim_set_hl(0, "NvimTreeGitIgnored",       { fg = overlay0 })
      vim.api.nvim_set_hl(0, "NvimTreeWindowPicker",     { bg = teal, fg = base })
      vim.api.nvim_set_hl(0, "NvimTreeLiveFilterPrefix", { fg = teal })
      vim.api.nvim_set_hl(0, "NvimTreeStatusline",       { bg = base, fg = base })

      vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file tree" })
    end,
  },
}
