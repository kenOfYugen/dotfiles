-- 1. get the config for this server from nvim-lspconfig and adjust the cmd path.
--    relative paths are allowed, lspinstall automatically adjusts the cmd and cmd_cwd for us!
local config = require'lspconfig'.jdtls.document_config

require'lspinstall/servers'.kotlin = vim.tbl_extend('error', config, {
    install_script = [[
      git clone https://github.com/fwcd/kotlin-language-server.git language-server
      cd language-server
	  ./gradlew :server:installDist
  ]],
    uninstall_script = nil -- can be omitted
})

require'lspinstall'.setup()
