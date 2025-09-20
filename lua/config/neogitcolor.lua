-- Stronger Neogit light overrides + winhighlight to avoid CursorLine/Visual stomping fg
local function neogit_light_overrides()
	-- Diff highlights (unfocused)
	vim.api.nvim_set_hl(0, "NeogitDiffAddHighlight",    { bg = "#e6ffed", fg = "#22863a", nocombine = true })
	vim.api.nvim_set_hl(0, "NeogitDiffDeleteHighlight", { bg = "#ffeef0", fg = "#cb2431", nocombine = true })
	vim.api.nvim_set_hl(0, "NeogitDiffContextHighlight",{ bg = "#f6f8fa", fg = "#24292e", nocombine = true })

	-- Diff highlights (focused, higher contrast)
	vim.api.nvim_set_hl(0, "NeogitDiffAdd",    { bg = "#9fd59f", fg = "#0b5820", nocombine = true })
	vim.api.nvim_set_hl(0, "NeogitDiffDelete", { bg = "#f19b9b", fg = "#8b1717", nocombine = true })
	vim.api.nvim_set_hl(0, "NeogitDiffContext",{ bg = "#d1d5da", fg = "#24292e", nocombine = true })

	-- Hunk headers (normal vs focused)
	vim.api.nvim_set_hl(0, "NeogitHunkHeader",          { bg = "#f0f0f0", fg = "#24292e", bold = true, nocombine = true })
	vim.api.nvim_set_hl(0, "NeogitHunkHeaderHighlight", { bg = "#bfc9d1", fg = "#24292e", bold = true, nocombine = true })

	-- Branch & remote labels
	vim.api.nvim_set_hl(0, "NeogitBranch", { fg = "#0366d6", bold = true, nocombine = true })
	vim.api.nvim_set_hl(0, "NeogitRemote", { fg = "#6f42c1", bold = true, nocombine = true })



	vim.api.nvim_set_hl(0, "NeogitDiffDeleteCursor", { fg = "#c43f2d"})
end

local function diffview_light_overrides()
end

local function neogit_dark_overrides()
end


-- apply once (if in light background)
if vim.o.background == "light" then
  	neogit_light_overrides()
  	diffview_light_overrides()
  else
	neogit_dark_overrides()
end

-- re-apply after colorscheme change (if you want)
vim.api.nvim_create_autocmd("ColorScheme", {
  callback = function()
    if vim.o.background == "light" then
      neogit_light_overrides()
    else
	  neogit_dark_overrides()
    end
  end,
})
