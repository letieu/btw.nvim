local Btw = {}
local H = {}

Btw.config = {
	text = " I use Neovim. (BTW)",
}

Btw.setup = function(config)
	Btw.config = vim.tbl_extend("force", Btw.config, config or {})
	H.create_autocommands()
end

Btw.open = function(buf_id)
	-- Ensure proper buffer and open it
	if H.is_in_vimenter then
		-- Use current buffer as it should be empty and not needed. This also
		-- solves the issue of redundant buffer when opening a file from Starter.
		buf_id = vim.api.nvim_get_current_buf()
	end

	if buf_id == nil or not vim.api.nvim_buf_is_valid(buf_id) then
		buf_id = vim.api.nvim_create_buf(false, true)
	end

	-- Create buffer data entry
	vim.api.nvim_set_current_buf(buf_id)

	-- Setup buffer behavior
	H.make_buffer_autocmd(buf_id)
	H.apply_buffer_options(buf_id)

	-- Populate buffer
	Btw.refresh(buf_id)

	-- Issue custom event
	vim.cmd("doautocmd User BtwOpened")

	-- Ensure not being in VimEnter
	H.is_in_vimenter = false
end

Btw.refresh = function(buf_id)
	local text = Btw.config.text
	local lines = H.create_lines(text)

	vim.api.nvim_buf_set_option(buf_id, "modifiable", true)
	vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, lines)
	-- vim.api.nvim_buf_set_option(buf_id, "modifiable", false)
end

Btw.close = function(buf_id)
	pcall(vim.api.nvim_buf_delete, buf_id, {})
end

H.buffer_number = 0

H.create_autocommands = function()
	local augroup = vim.api.nvim_create_augroup("Btw", {})

	local on_vimenter = function()
		H.is_in_vimenter = true
		Btw.open()
	end

	vim.api.nvim_create_autocmd(
		"VimEnter",
		{ group = augroup, nested = true, once = true, callback = on_vimenter, desc = "Open on VimEnter" }
	)
end

-- Work with starter buffer ---------------------------------------------------
H.make_buffer_autocmd = function(buf_id)
	local augroup = vim.api.nvim_create_augroup("BtwBuffer", {})

	local au = function(event, callback, desc)
		vim.api.nvim_create_autocmd(event, { group = augroup, buffer = buf_id, callback = callback, desc = desc })
	end

	au("VimResized", function()
		Btw.refresh(buf_id)
	end, "Refresh")

	local cache_showtabline = vim.o.showtabline
	au("BufLeave", function()
		if vim.o.cmdheight > 0 then
			vim.cmd("echo ''")
		end
		if vim.o.showtabline == 1 then
			vim.o.showtabline = cache_showtabline
		end
	end, "On BufLeave")

	au("InsertEnter", function()
		Btw.close(buf_id)
	end, "On InsertEnter")
end

H.apply_buffer_options = function(buf_id)
	-- NOTE: assumed that it is executing with `buf_id` being current buffer

	-- Force Normal mode. NOTEs:
	-- - Using `vim.cmd('normal! \28\14')` weirdly does not work.
	-- - Using `vim.api.nvim_input([[<C-\><C-n>]])` doesn't play nice if `<C-\>`
	--   mapping is present (maybe due to non-blocking nature of `nvim_input()`).
	vim.api.nvim_feedkeys("\28\14", "nx", false)

	-- Set unique buffer name. Prefer "Starter" prefix as more user friendly.
	H.buffer_number = H.buffer_number + 1
	local name = H.buffer_number <= 1 and "Starter" or ("Starter_" .. H.buffer_number)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.fn.fnamemodify(vim.api.nvim_buf_get_name(buf), ":t") == name then
			name = "starter://" .. H.buffer_number
			break
		end
	end
	vim.api.nvim_buf_set_name(buf_id, name)

	-- Having `noautocmd` is crucial for performance: ~9ms without it, ~1.6ms with it
	vim.cmd("noautocmd silent! set filetype=starter")

	local options = {
		"bufhidden=wipe",
		"colorcolumn=",
		"foldcolumn=0",
		"matchpairs=",
		"nobuflisted",
		"nocursorcolumn",
		"nocursorline",
		"nolist",
		"nonumber",
		"noreadonly",
		"norelativenumber",
		"nospell",
		"noswapfile",
		"signcolumn=no",
		"synmaxcol&",
		"buftype=nofile",
		"nomodeline",
		"nomodifiable",
		"foldlevel=999",
		"nowrap",
	}
	-- Vim's `setlocal` is currently more robust compared to `opt_local`
	vim.cmd(("silent! noautocmd setlocal %s"):format(table.concat(options, " ")))

	vim.o.showtabline = 1
end

--- @param text string The text to be centered in the buffer.
--- @return string[] A table of lines with the centered text.
H.create_lines = function(text)
	-- Get the window's width and height
	local win_width = vim.api.nvim_win_get_width(0)
	local win_height = vim.api.nvim_win_get_height(0)

	-- Calculate the horizontal and vertical padding
	local hor_padding = math.floor((win_width - string.len(text)) / 2)
	local ver_padding = math.floor(win_height / 2)

	-- Create the lines with the centered text
	local lines = {}
	for _ = 1, ver_padding do
		table.insert(lines, "")
	end
	table.insert(lines, string.rep(" ", hor_padding) .. text)
	for _ = 1, win_height - ver_padding - 1 do
		table.insert(lines, "")
	end

	return lines
end

return Btw