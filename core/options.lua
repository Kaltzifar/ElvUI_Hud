local E, L, V, P, G = unpack(ElvUI); --Inport: Engine, Locales, ProfileDB, GlobalDB
local H = E:GetModule('HUD');
local LSM = LibStub("LibSharedMedia-3.0");

E.Options.args.hud = {
    order = 2150,
    type = "group",
    name = L["Hud"],
    args = {
        header = {
            order = 1,
            type = "header",
            name = L["ElvUI Hud by Sortokk"],
        },
        description = {
            order = 2,
            type = "description",
            name = L["ElvUI Hud provides a configurable Heads Up Display for use with ElvUI.\n"],
        },
        general = {
            order = 3,
            type = "group",
            name = L["General"],
            guiInline = true,

            args = {
                enabled = {
                    type = "toggle",
                    order = 1,
                    name = L["Enable"],
                    desc = L["Enable the Hud."],
                    get = function(info) return E.db.hud[info[#info]] end,
                    set = function(info,value) E.db.hud[info[#info]] = value; H:Enable(); end,
                },
                resetsettings = {
                    type = "execute",
                    order = 2,
                    name = L["Reset Settings"],
                    desc = L["Reset the settings of this addon to their defaults."],
                    func = function() E:CopyTable(E.db.hud,P.hud); H:Enable(); H:UpdateHideSetting(); H:UpdateMedia(); H:UpdateMouseSetting(); end
                },
            },
        },
        hudOptions = {
            order = 4,
            type = "group",
            name = L["Hud Options"],
            guiInline = true,
            get = function(info) return E.db.hud[info[#info]] end,
            set = function(info,value) E.db.hud[info[#info]] = value; end, 
            args = {
                simpleLayout = {
                    type = "toggle",
                    order = 4,
                    name = L["Simple Layout"],
                    desc = L["A simple layout inspired by Hydra, player health on left, power on right, no target/pet hud /n(Overwrites all other settings except Offsets)"],
                    get = function(info) return E.db.hud[info[#info]] end,
                    set = function(info,value) E.db.hud[info[#info]] = value; StaticPopup_Show("CONFIG_RL"); end, 
                },
                simpleTarget = {
                    type = "toggle",
                    order = 5,
                    name = L["Simple Layout Target"],
                    desc = L["Show target health/power in the simple layout"],
                    get = function(info) return E.db.hud[info[#info]] end,
                    set = function(info,value) E.db.hud[info[#info]] = value; StaticPopup_Show("CONFIG_RL"); end,
                },
                petHud = {
                    type = "toggle",
                    order = 7,
                    name = L["Pet Hud"],
                    desc = L["Show the Pet Hud in the hud"],
                },
                hideElv = {
                    type = "toggle",
                    order = 8,
                    name = L["Hide ElvUI Unitframes"],
                    desc = L["Hide the ElvUI Unitframes when the Hud is enabled"],
                    get = function(info) return E.db.hud[ info[#info] ] end,   
                    set = function(info, value) E.db.hud[ info[#info] ] = value; H:UpdateElvUFSetting(false) end,
                },
                names = {
                    type = "toggle",
                    order = 9,
                    name = L["Show Names"],
                    desc = L["Show names of units on Hud"],
                    get = function(info) return E.db.hud[ info[#info] ] end,
                    set = function(info, value)
                        E.db.hud[ info[#info] ] = value;
                        if value then
                            if ElvUF_PlayerHud then
                                ElvUF_PlayerHud.Name:Show()
                                ElvUF_TargetHud.Name:Show()
                            end
                        else
                            if ElvUF_PlayerHud then
                                ElvUF_PlayerHud.Name:Hide()
                                ElvUF_TargetHud.Name:Hide()
                            end
                        end
                    end,
                },
                showThreat = {
                    type = "toggle",
                    order = 10,
                    name = L["Threat"],
                    desc = L["Show a Threatbar next to the Player Hud"],
                },
                classBars = {
                    type = "toggle",
                    order = 11,
                    name = L["Class Bar"],
                    desc = L["Show a Class Bar (rune bar, totem bar, eclipse bar, etc.)"],
                },
                showValues = {
                    type = "toggle",
                    order = 12,
                    name = L["Text Values"],
                    desc = L["Show Text Values (Health/Mana) in the Hud"],
                },
                unicolor = {
                    type = "toggle",
                    order = 13,
                    name = L["Unicolor"],
                    desc = L["Use a unicolor theme"],
                },
                smooth = {
                    type = "toggle",
                    order = 14,
                    name = L["Smooth Bars"],
                    desc = L["Show smooth bars"],
                },
                flash = {
                    type = "toggle",
                    order = 15,
                    name = L["Flash"],
                    desc = L["Flash health/power when the low threshold is reached"],
                },
                warningText = {
                    type = "toggle",
                    order = 16,
                    name = L["Text Warning"],
                    desc = L["Show a Text Warning when the low threshold is reached"],
                },
                hideOOC  = {
                    type = "toggle",
                    order = 17,
                    name = L["Hide Out of Combat"],
                    desc = L["Hide the Hud when out of Combat"],
                    get = function(info) return E.db.hud[ info[#info] ] end,   
                    set = function(info, value) E.db.hud[ info[#info] ] = value; H:UpdateHideSetting() end,
                },
                colorHealthByValue = {
                    type = "toggle",
                    order = 18,
                    name = L["Color Health By Value"],
                    desc = L["Color the health bars relative to their value"],
                },
                enableMouse = {
                    type = "toggle",
                    order = 19,
                    name = L["Enable Mouse"],
                    desc = L["Enable the mouse to interface with the hud (this option has no effect is ElvUI Unitframes are hidden)"],
                    get = function(info) return E.db.hud[ info[#info] ] end,   
                    set = function(info, value) E.db.hud[ info[#info] ] = value; H:UpdateMouseSetting() end,
                },
                horizCastbar = {
                    type = "toggle",
                    order = 20,
                    name = L["Horizontal Castbar"],
                    desc = L["Use a horizontal castbar"],
                    get = function(info) return E.db.hud[info[#info]] end,
                    set = function(info,value) E.db.hud[info[#info]] = value; StaticPopup_Show("CONFIG_RL"); end,
                },
                font = {
                    type = "select", dialogControl = 'LSM30_Font',
                    order = 1,
                    name = L["Default Font"],
                    desc = L["The font that the core of the UI will use."],
                    values = AceGUIWidgetLSMlists.font, 
                    get = function(info) return E.db.hud[ info[#info] ] end,   
                    set = function(info, value) E.db.hud[ info[#info] ] = value; H:UpdateMedia() end,
                },
                texture = {
                    type = "select", dialogControl = 'LSM30_Statusbar',
                    order = 1,
                    name = L["Primary Texture"],
                    desc = L["The texture that will be used mainly for statusbars."],
                    values = AceGUIWidgetLSMlists.statusbar,
                    get = function(info) return E.db.hud[ info[#info] ] end,
                    set = function(info, value) E.db.hud[ info[#info] ] = value; H:UpdateMedia() end,                            
                },
            },
        },
        hudVariables = {
            order = 5,
            type = "group",
            name = L["Variables and Movers"],
            guiInline = true,
            get = function(info) return E.db.hud[info[#info]] end,
            set = function(info,value) E.db.hud[info[#info]] = value; end,
            args = {
                offset = {
                    type = "range",
                    order = 1,
                    name = L["Horizontal Offset"],
                    desc = L["Set the Horizontal offset of the hud from the Centre of the screen"],
                    min = 50, max = 500, step = 1,  
                },
                yoffset = {
                    type = "range",
                    order = 2,
                    name = L["Vertical Offset"],
                    desc = L["Raise or Lower the Hud Position"],
                    min = -500, max = 500, step = 1,    
                },
                height = {
                    type = "range",
                    order = 3,
                    name = L["Hud Height"],
                    desc = L["Set the Height of the Hud Bars"],
                    min = 100, max = 600, step = 1, 
                },
                width = {
                    type = "range",
                    order = 4,
                    name = L["Hud Width"],
                    desc = L["Set the Width of the Hud Bars"],
                    min = 10, max = 30, step = 1,   
                },
                fontsize = {
                    type = "range",
                    order = 5,
                    name = L["Font Size"],
                    desc = L["Set the Width of the Text Font"],
                    min = 10, max = 30, step = 1,   
                },
                alpha = {
                    type = "range",
                    order = 6,
                    name = L["Alpha"],
                    desc = L["Set the Alpha of the Hud when in combat"],
                    min = 0, max = 1, step = .05,   
                },
                alphaOOC = {
                    type = "range",
                    order = 7,
                    name = L["Out of Combat Alpha"],
                    desc = L["Set the Alpha of the Hud when OOC"],
                    min = 0, max = 1, step = 0.05,  
                },
                lowThreshold = {
                    type = "range",
                    order = 8,
                    name = L["Low Threshold"],
                    desc = L["Start flashing health/power under this percentage"],
                    min = 0, max = 100, step = 1,
                }
            },
        },
    }
}
