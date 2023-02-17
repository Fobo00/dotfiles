local dap = require("dap")
local codelldb_path = vim.fn.stdpath("data") .. "/mason/packages/codelldb/extension/adapter/codelldb.exe"
local cargo_inspector = require("LSP.dap-utils")


dap.adapters.clldb = {
  type = 'server',
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
    detached = false,
  }
}

dap.adapters.lldb = {
  type = "server",
  port = "${port}",
  executable = {
    command = codelldb_path,
    args = { "--port", "${port}" },
  },
  enrich_config = function(config, on_config)
    -- If the configuration(s) in `launch.json` contains a `cargo` section
    -- send the configuration off to the cargo_inspector.
    if config["cargo"] ~= nil then on_config(cargo_inspector(config)) end
  end,
}


dap.configurations.rust = {
    {
    name = "Debugging rust",
    type = "lldb",
    request = "launch",
    cargo = {
      args = { "test", "--no-run", "--lib" },
      problemMatcher = "rustc",
    },
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. '/', "file")
    end,

    cwd = "&{workspaceFolder}",
    stopOnEntry = false,
  },
}

require("dap.ext.vscode").load_launchjs("./launch.json", { lldb = { "c", "cpp", "rust" } })


-----------------------UI------------------------------
local dapui = require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
  dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
  dapui.close()
end
