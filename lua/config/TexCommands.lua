-- CreateTex command
-- Expand template names from ~/.config/nvim/assets/tex_templates/
local function tex_template_complete(arg_lead, cmd_line, cursor_pos)
	local template_dir = vim.fn.expand("~/.config/nvim/assets/tex_templates/")
	local files = vim.fn.readdir(template_dir)

	-- Keep only *.tex templates, strip extension
	local templates = {}
	for _, f in ipairs(files) do
	  if f:match("%.tex$") and f~="macros.tex" then
		  local name = f:gsub("%.tex$", " ")
	    table.insert(templates, name)
	  end
	end

	-- Filter for completion
	return vim.tbl_filter(function(item)
	  return vim.startswith(item, arg_lead)
	end, templates)
end

-- Autocomplete directories for the third argument
local function dir_complete(arg_lead, cmd_line, cursor_pos)
  local dirs = vim.fn.getcompletion(arg_lead, "dir")
  return dirs
end

-- Custom completion dispatcher: first arg = template, third arg = dir
local function create_tex_complete(arg_lead, cmd_line, cursor_pos)
  local args = vim.split(cmd_line, "%s+")
  local arg_count = #args - 1 -- subtract command name

  if arg_count == 1 then
    return tex_template_complete(arg_lead, cmd_line, cursor_pos)
  elseif arg_count == 3 then
    return dir_complete(arg_lead, cmd_line, cursor_pos)
  else
    return {}
  end
end

--Defining Command
vim.api.nvim_create_user_command(
  "CreateTex",
	function(opts)
	  local args = vim.deepcopy(opts.fargs)

	  if opts.bang then
		  -- Insert -o before other args
		  table.insert(args, 1, "-o")
	  end

-- Expand the script path
    local script = vim.fn.expand("~/.config/nvim/tex_templates.sh")
    if vim.fn.executable(script) == 0 then
      vim.notify("CreateTex: script not found or not executable: " .. script, vim.log.levels.ERROR)
      return
    end

    -- Run the script
    local cmd = script .. " " .. table.concat(args, " ")
    local result = vim.fn.system(cmd)
    local exit_code = vim.v.shell_error

    if exit_code ~= 0 then
      vim.notify("CreateTex: script failed!\n" .. result, vim.log.levels.ERROR)
      return
    end
	  -- Figure out where the file should be
	  local template_index = 1
	  local filename_index = template_index + 1
	  local dir_index = filename_index + 1

	  local filename = opts.fargs[filename_index]
	  local dir = opts.fargs[dir_index] or vim.fn.getcwd()
	  local filepath = vim.fn.expand(dir .. "/" .. filename .. ".tex")

	  -- Open the created file in current window
	  if vim.fn.filereadable(filepath) == 1 then
		  vim.cmd.edit(filepath)
	  else
		  vim.notify("CreateTex: could not find " .. filepath, vim.log.levels.WARN)
	  end
  end,
  {
    nargs = "*",
    bang = true,
    complete = create_tex_complete,
  }
)

-- Defining Command TexReveal
-- Only define on macOS
if vim.loop.os_uname().sysname == "Darwin" then
  vim.api.nvim_create_user_command("TexReveal", function()
    -- Check if vimtex main file exists
    local vimtex = vim.b.vimtex
    if not vimtex or not vimtex.tex or vimtex.tex == "" then
      vim.api.nvim_err_writeln("No main TeX file (b:vimtex.tex) set")
      return
    end

    -- Replace .tex with .pdf
    local pdffile = vimtex.tex:gsub("%.tex$", ".pdf")

    -- Check if PDF exists
    if vim.fn.filereadable(pdffile) == 0 then
      vim.api.nvim_err_writeln("PDF file does not exist: " .. pdffile)
      return
    end

    -- Reveal PDF in Finder
    vim.fn.jobstart({ "open", "-R", pdffile })
  end, { desc = "Reveal compiled PDF in Finder (macOS only)" })
end

-- Define TexCompileShell command
vim.api.nvim_create_user_command(
  "TexCompileShell",
  function(opts)
    -- Get current buffer full path
    local filepath = vim.fn.expand("%:p")
    if filepath == "" then
      vim.notify("CompileTex: no file in current buffer", vim.log.levels.WARN)
      return
    end

    -- Check if it is a .tex file
    if vim.fn.expand("%:e") ~= "tex" then
      vim.notify("CompileTex: current buffer is not a .tex file", vim.log.levels.WARN)
      return
    end

    -- Extract filename with extension and directory
    local filename = vim.fn.expand("%:t") -- file name with extension
    local dir = vim.fn.expand("%:p:h")    -- directory of the file

    -- Expand the script path
    local script = vim.fn.expand("~/.config/nvim/tex_compile.sh")
    if vim.fn.executable(script) == 0 then
      vim.notify("CompileTex: script not found or not executable: " .. script, vim.log.levels.ERROR)
      return
    end

    -- Build command: include -o if bang (!) is used
    local cmd
    if opts.bang then
      cmd = string.format("%s -o %s %s", script, vim.fn.shellescape(filename), vim.fn.shellescape(dir))
    else
      cmd = string.format("%s %s %s", script, vim.fn.shellescape(filename), vim.fn.shellescape(dir))
    end

    -- Run the compile script
    local result = vim.fn.system(cmd)
    local exit_code = vim.v.shell_error

    if exit_code ~= 0 then
      vim.notify("CompileTex: compilation failed!\n" .. result, vim.log.levels.ERROR)
      return
    end

    vim.notify("CompileTex: compilation successful!", vim.log.levels.INFO)
  end,
  {
    nargs = 0,
    bang = true, -- support CompileTex!
  }
)

-- Define TexClean command
vim.api.nvim_create_user_command(
	"TexClean",
	function()
	  -- Get buffer-local root
	  local root = vim.b.vimtex.tex
	  if not root or root == "" then
	    vim.api.nvim_err_writeln("No root file set (b:root missing)")
	    return
	  end

	  -- Run your shell script with root as argument
	  local cmd = string.format("~/.config/nvim/tex_clean.sh %s", vim.fn.shellescape(root))
	  local output = vim.fn.system(cmd)

	  -- Print confirmation
	  print("Ran tex_clean.sh on " .. root)
	  if output ~= "" then
	    print(output)
	  end
	end,
	{}
)

-- TexStart Command Definition
vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	callback = function()
	  vim.api.nvim_buf_create_user_command(0, "TexStart", function()
	    vim.cmd("VimtexCompile!")
	  end, { desc = "Runing continuous compilation" })
	end,
})

-- TexStop Command Definition
vim.api.nvim_create_autocmd("FileType", {
	pattern = "tex",
	callback = function()
	  vim.api.nvim_buf_create_user_command(0, "TexStop", function()
	    vim.cmd("VimtexStop")
	    vim.cmd("TexClean")
	  end, { desc = "Stopping continuous compilation" })
	end,
})

-- TexGoto Command Definition
vim.api.nvim_create_autocmd("FileType", {
  pattern = "tex",
  callback = function()
	  vim.api.nvim_buf_create_user_command(0, "TexGoto", function()
		  vim.cmd("VimtexView")
	  end, { desc = "Run VimTeX continuous compilation" })
  end,
})
