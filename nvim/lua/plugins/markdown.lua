return {
  {
    "MeanderingProgrammer/render-markdown.nvim",

    ft = {
      "markdown",
      "norg",
      "rmd",
      "org",
      "codecompanion",
    },

    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },

      heading = {
        sign = false,
        icons = {},
      },

      checkbox = {
        enabled = false,
      },
    },

    config = function(_, opts)
      require("render-markdown").setup(opts)

      -- Toggle rendering
      vim.keymap.set("n", "<leader>um", function()
        local rm = require("render-markdown")

        if rm.get() then
          rm.set(false)
        else
          rm.set(true)
        end
      end, {
        desc = "Toggle Markdown Rendering",
      })
    end,
  },
}
