local M = {}

--[[
{
  "src/web/scenes/PlanApprovals/PlanApprovalListPage/PlanApprovalListPage.ts(54,19): error TS2552: Cannot find name 'planApprovalsLoading'. Did you mean 'lanApprovalsLoading'?\n",
  "src/web/scenes/PlanApprovals/PlanApprovalListPage/PlanApprovalListPage.ts(56,81): error TS2345: Argument of type 'unknown' is not assignable to parameter of type 'PlanApprovalListItem[]'.\n",
  "src/web/ scenes/PlanApprovals/PlanApprovalListPage/PlanApprovalListPage.ts(71,73): error TS2345: Argument of type 'unknown' is not assignable to parameter of type 'PlanApprovalListItem[]'.\nsrc/web/sc enes/PlanApprovals/PlanApprovalListPage/PlanApprovalListPage.ts(78,90): error TS2769: No overload matches this call.\n  The last overload gave the following error.\n    Type 'unknown' is not assignable to type 'PlanApprovalListItem[]'.\nsrc/web/scenes/PlanApprovals/PlanApprovalListPage/PlanApprovalListPage.ts(80,31): error TS2552: Cannot find name 'planApprovalsLoading'. Did you mean 'lanApprovalsLoading'?\n",
 "src/web/scenes/PlanApprovals/PlanApprovalListPage/PlanApprovalListPage.ts(80,67): error TS2552: Cannot find name 'planApprovalsLoading'. Did you mean 'lanAppr
ovalsLoading'?\n" }
]]

M.parse = function()
  local str = "src/web/scenes/PlanApprovals/PlanApprovalListPage/PlanApprovalListPage.ts(54,19): error TS2552: Cannot find name 'planApprovalsLoading'. Did you mean 'lanApprovalsLoading'?",

  local result = string.find(str, "$("))
  print(result)
end

M.typecheck = function()
  local cmd = { "yarn", "typecheck" }
  local found_issues = {}

  vim.system(cmd, {
    --text = true,
    stdout = function(_err, data)
      if data ~= nil and string.find(data, "error") then
        table.insert(found_issues, data)
      end
    end,
    stderr = function(_err, data)
      print("Typecheck failed...")
      print(data)
    end,
  }, function(obj)
    if obj.code == 1 then
      local qf_errors = {}

      local function to_qf_format(error)
        local filename, lineno, colno = error:match("^(.+)%((%d+),(%d+)%)%s*:%s*(.+)$")
        return {
          filename = filename,
          lnum = tonumber(lineno),
          col = tonumber(colno),
          type = "E",
        }
      end

      for _, error in ipairs(found_issues) do
        local formatted_error = to_qf_format(error)
        print("======= formatted_error =======")
        print(vim.inspect(formatted_error))
        table.insert(qf_errors, formatted_error)
      end
      if #qf_errors then
        vim.schedule(function()
          vim.fn.setqflist(qf_errors, "r")
          vim.cmd("copen")
        end)
      end
    end
  end)
end

return M
