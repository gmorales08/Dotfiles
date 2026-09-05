local M = {}

function M.cpp_header_extensions()
  if vim.g.use_h_as_c_header then
    return { "hpp", "h", "hh", "hxx" }
  end

  return { "h", "hpp", "hh", "hxx" }
end

function M.setup()
  if type(vim.g.use_h_as_c_header) ~= "boolean" then
    error("vim.g.use_h_as_c_header must be a boolean")
  end

  vim.filetype.add({
    extension = {
      h = vim.g.use_h_as_c_header and "c" or "cpp",
      v = "verilog",
      vh = "verilog",
    },
  })
end

return M
