hl.workspace_rule({ workspace = "special:overview", gaps_out = 80 })
hl.workspace_rule({ workspace = "special:running", gaps_out = 80 })

hl.workspace_rule({ workspace = "2", gaps_out = 20 })
hl.workspace_rule({ workspace = "4", gaps_out = 50 })

local standard_workspaces = { "1", "3", "5", "6", "7", "8" }
for _, ws in ipairs(standard_workspaces) do
    hl.workspace_rule({
        workspace = ws,
        gaps_out = (ws == "1") and 20 or 30, 
        gaps_in = (ws ~= "3") and 10 or nil, 
    })
end
