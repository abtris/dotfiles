-- Debugging: nvim-dap + nvim-dap-go (Delve). Delve is installed via mason
-- (see lsp.lua ensure_installed). dap-ui opens automatically on a session.
return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "rcarriga/nvim-dap-ui", dependencies = { "nvim-neotest/nvim-nio" } },
    "leoluz/nvim-dap-go",
    "theHamsta/nvim-dap-virtual-text",
  },
  keys = {
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step into" },
    { "<leader>do", function() require("dap").step_over() end, desc = "Step over" },
    { "<leader>dO", function() require("dap").step_out() end, desc = "Step out" },
    { "<leader>dt", function() require("dap-go").debug_test() end, desc = "Debug Go test" },
    { "<leader>dl", function() require("dap-go").debug_last_test() end, desc = "Debug last Go test" },
    { "<leader>du", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    dapui.setup()
    require("dap-go").setup()
    require("nvim-dap-virtual-text").setup()

    dap.listeners.before.attach.dapui_config = function() dapui.open() end
    dap.listeners.before.launch.dapui_config = function() dapui.open() end
    dap.listeners.before.event_terminated.dapui_config = function() dapui.close() end
    dap.listeners.before.event_exited.dapui_config = function() dapui.close() end

    vim.fn.sign_define("DapBreakpoint", { text = "●", texthl = "DiagnosticError", linehl = "", numhl = "" })
    vim.fn.sign_define("DapStopped", { text = "▶", texthl = "DiagnosticWarn", linehl = "Visual", numhl = "" })
  end,
}
