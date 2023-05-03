return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    ft = { "cpp", "c", "python", "py", "java", "jav" },
    config = function()
      local mason_registry = require "mason-registry"
      local dap = require "dap"
      local StartServer = function()
        vim.cmd "FloatermNew! --silent --autoclose=1 ~/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb --port 13000"
        local fileName = vim.fn.fnamemodify(vim.fn.expand "%", ":t:r")
        io.popen("g++ -g -o " .. fileName .. " " .. fileName .. ".cpp")
        -- CompileDebugCProject()
      end
      dap.adapters.python = {
        type = "executable",
        command = mason_registry.get_package("debugpy"):get_install_path() .. "/venv/bin/python",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          -- The first three options are required by nvim-dap
          type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
          request = "launch",
          name = "Launch file",

          -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

          program = "${file}", -- This configuration will launch the current file if used.
          pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
              return cwd .. "/venv/bin/python"
            elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
              return cwd .. "/.venv/bin/python"
            else
              return "/usr/bin/python"
            end
          end,
        },
      }

      dap.adapters.cppdbg = {
        id = "cppdbg",
        type = "executable",
        -- command = mason_registry.get_package("vscode-cpptools"):get_install_path() .. "/debugAdapters/OpenDebugAD7",
        -- command = vim.fn.exepath "OpenDebugAD7",
        command = "/home/cbr/.local/share/nvim/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
      }
      dap.adapters.codelldb = {
        type = "server",
        port = "${port}",
        executable = {
          -- command = vim.fn.exepath "codelldb",
          command = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/adapter/codelldb",
          -- command = "~/.local/share/nvim/mason/packages/codelldb/extension/adapter/codelldb",
          args = { "--port", "${port}" },
        },
      }
      dap.configurations.cpp = {
        {
          name = "Launch file",
          type = "cppdbg",
          request = "launch",
          program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
          cwd = "${workspaceFolder}",
          stopAtEntry = true,
        },
        {
          name = "LLDB: Launch",
          type = "codelldb",
          request = "launch",
          program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
          cwd = "${workspaceFolder}",
          stopOnEntry = true,
          args = {},
        },
        -- {
        --   name = "Attach to gdbserver :1234",
        --   type = "cppdbg",
        --   request = "launch",
        --   MIMode = "gdb",
        --   miDebuggerServerAddress = "localhost:1234",
        --   miDebuggerPath = vim.fn.exepath "gdb",
        --   cwd = "${workspaceFolder}",
        --   program = function() return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file") end,
        -- },
      }
    end,
  },
}
