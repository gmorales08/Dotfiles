-- shipwright_build.lua

local lushwright = require("shipwright.transform.lush")
run(require("gmorales_nvim_lush"),
  -- generate lua code
  lushwright.to_lua,
  -- write the lua code into our destination.
  -- you must specify open and close markers yourself to account
  -- for differing comment styles, patchwrite isn't limited to lua files.
  {patchwrite, "../gmorales_nvim.lua", "-- PATCH_OPEN", "-- PATCH_CLOSE"})
