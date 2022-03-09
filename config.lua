Config = {}

Config.useTarget = false	    -- Use QB Target to enable the billing
Config.useCommand = true	-- Use QB Target to enable the billing
Config.useCash = false		-- Abillity to use cash for billing/ If false then Banking

-- Add this in your QB-Target Init.lua and set useTraget to true

--[[
    Config.GlobalPlayerOptions = {
        options = {
            {
            type = "client",
            event = "jerzys_billing:client:openBillingMenu",
            icon = 'fas fa-phone',
            label = 'Generate a bill',
            },
        }
    }
]]--