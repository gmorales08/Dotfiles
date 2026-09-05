return {
  "MagicDuck/grug-far.nvim",
  lazy = true,
  cmd = { "GrugFar", "GrugFarWithin" },
  keys = {
    {
      "<leader>fr",
      function()
        require("grug-far").open({ transient = true })
      end,
      desc = "Find and replace in project",
    },
  },
  opts = {},
}
