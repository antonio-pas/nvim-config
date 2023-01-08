local modes = {
  ["n"] = "NORMAL",
  ["no"] = "NORMAL",
  ["v"] = "VISUAL",
  ["V"] = "VISUAL LINE",
  [""] = "VISUAL BLOCK",
  ["s"] = "SELECT",
  ["S"] = "SELECT LINE",
  [""] = "SELECT BLOCK",
  ["i"] = "INSERT",
  ["ic"] = "INSERT",
  ["R"] = "REPLACE",
  ["Rv"] = "VISUAL REPLACE",
  ["c"] = "COMMAND",
  ["cv"] = "VIM EX",
  ["ce"] = "EX",
  ["r"] = "PROMPT",
  ["rm"] = "MOAR",
  ["r?"] = "CONFIRM",
  ["!"] = "SHELL",
  ["t"] = "TERMINAL",
}
local function get_mode()
  return modes[vim.api.nvim_get_mode()['mode']]
end
local function get_lsp_messages()
  local messages = vim.lsp.util.get_progress_messages()
  local result = ""
  for _, message in ipairs(messages) do
    result = message.title
    if message.message then
      result = result..": "..message.message
    end
    if message.percentage then
      result = result.." "..message.percentage.."%%"
    end
  end
  return result
end
local function file_info()
  return table.concat({
    "%{&filetype} ",
    "%{WebDevIconsGetFileTypeSymbol()}",
    " | ",
    "%{&fileformat} ",
    "%{WebDevIconsGetFileFormatSymbol()}",
    " | ",
    "%{&fileencoding}",
    " | "
  })
end
local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
local function get_diagnostics()
  local severities = {
    "Error",
    "Warn",
    "Hint",
    "Info"
  }
  local counts = {}
  for _, v in pairs(severities) do
    local diagnostics = vim.diagnostic.get(0, { severity = v })
    local diagnostic_count = vim.tbl_count(diagnostics)
    counts[v] = diagnostic_count
  end
  for k, v in pairs(counts) do
    counts[k] = v
  end
  local result = ""
  for k, v in pairs(counts) do
    if v == 0 then goto continue end
    result = result..signs[k]..v.." "
    ::continue::
  end
  return result
end
local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":t")
  return fpath
end
function Statusline()
  return table.concat({
    "%#StatusLine#",
    " ",
    get_mode(),
    " ",
    "%#CursorColumn#",
    "  ",
    filepath(),
    "%h%m  ",
    get_diagnostics(),
    "%=",
    get_lsp_messages(),
    --treesitter.statusline(50) or "",
    "%=",
    file_info(),
    "%l:%L ",
    "%p%%"
  })
end
local statusline = "%!luaeval('Statusline()')"
vim.o.statusline = statusline
