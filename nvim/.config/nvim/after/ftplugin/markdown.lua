if vim.b.did_my_after_ftplugin then
  return
end
vim.b.did_my_after_ftplugin = true

vim.opt_local.spell = true
-- vim.opt_local.spelllang = { "en" }

vim.api.nvim_create_autocmd("BufWinEnter", {
  pattern = "md",
  callback = function()
    local lang_rs = vim.list_contains(vim.opt_local.spelllang:get(), "sr")
    if lang_rs then
      local EN_US_IDX = 0
      local SR_LAT_IDX = 1
      -- local SR_CYR_IDX = 2

      local ins_kblayout = SR_LAT_IDX
      local normal_kblayout = EN_US_IDX

      local function set_sway_kblayout(idx)
        vim.fn.jobstart(
          string.format(
            "swaymsg 'input type:keyboard xkb_switch_layout %d'",
            idx
          )
        )
      end

      vim.api.nvim_create_autocmd("InsertEnter", {
        pattern = "*.md",
        callback = function()
          set_sway_kblayout(ins_kblayout)
        end,
      })

      vim.api.nvim_create_autocmd("InsertLeave", {
        pattern = "*.md",
        callback = function()
          set_sway_kblayout(normal_kblayout)
        end,
      })
    end
  end,
})

local mdgroup = vim.api.nvim_create_augroup("MdAfterFtplugin", { clear = true })

local function build()
  local mdfile = vim.api.nvim_buf_get_name(0)
  local pdffile = vim.fn.expand("%:p:r") .. ".pdf"

  local buildcmd =
    { "pandoc", "--pdf-engine=lualatex", "-o" .. pdffile, mdfile }
  local jobid = vim.fn.jobstart(buildcmd, { detatch = true })
  if jobid == 0 then
    print("bad arguments")
  elseif jobid == -1 then
    print(buildcmd[0] .. "or shell is not executable!")
  else
    -- print("Succesfully started job id: " .. jobid)
  end

  -- print(unpack(buildcmd))
end

vim.api.nvim_create_user_command("ZathuraPreview", function(_)
  build()
  local viewcmd = { "zathura", vim.fn.expand("%:p:r") .. ".pdf" }
  -- print(unpack(viewcmd))
  -- if true then
  -- 	return
  -- end

  local jobid = vim.fn.jobstart(viewcmd)
  if jobid == 0 then
    print("bad arguments")
  elseif jobid == -1 then
    print(viewcmd[0] .. "or shell is not executable!")
  else
    -- print("Succesfully started job id: " .. jobid)
  end
end, {})

vim.api.nvim_create_autocmd("BufWritePost", {
  pattern = "*.md",
  callback = build,
  group = mdgroup,
})

build()
