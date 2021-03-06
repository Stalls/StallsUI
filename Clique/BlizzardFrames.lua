local addonName, addon = ...
local L = addon.L 

--[[---------------------------------------------------------------------------
--  Options panel definition
---------------------------------------------------------------------------]]--

local panel = CreateFrame("Frame")
panel.name = "Blizzard Frame Options"
panel.parent = addonName

panel:SetScript("OnShow", function(self)
    if not panel.initialized then
        panel:CreateOptions()
        panel.refresh()
    end
end)

local function make_checkbox(name, label)
    local frame = CreateFrame("CheckButton", "CliqueOptionsBlizzFrame" .. name, panel, "UICheckButtonTemplate")
    frame.text = _G[frame:GetName() .. "Text"]
    frame.type = "checkbox"
    frame.text:SetText(label)
    return frame
end

local function make_label(name, template)
    local label = panel:CreateFontString("OVERLAY", "CliqueOptionsBlizzFrame" .. name, template)
    label:SetWidth(panel:GetWidth())
    label:SetJustifyH("LEFT")
    label.type = "label"
    return label
end

function panel:CreateOptions()
    panel.initialized = true
    
    local bits = {}
    self.intro = make_label("Intro", "GameFontHighlightSmall")
    self.intro:SetText(L["These options control whether or not Clique auotmatically registers certain Blizzard-created frames for binding. Changes made to these settings will not take effect until the user interface is reloaded."])
    self.intro:SetPoint("RIGHT")
    self.intro:SetHeight(45)

    self.PlayerFrame = make_checkbox("PlayerFrame", L["Player frame"])
    self.PetFrame = make_checkbox("PetFrame", L["Player's pet frame"])
    self.TargetFrame = make_checkbox("TargetFrame", L["Player's target frame"])
    self.TargetFrameToT = make_checkbox("TargetFrameToT", L["Target of target frame"])
    self.FocusFrame = make_checkbox("FocusFrame", L["Player's focus frame"])
    self.FocusFrameToT = make_checkbox("FocusFrameToT", L["Target of focus frame"])
    self.arena = make_checkbox("ArenaEnemy", L["Arena enemy frames"])
    self.party = make_checkbox("Party", L["Party member frames"])
    self.compactraid = make_checkbox("CompactRaid", L["Compact raid frames"])
    self.compactparty = make_checkbox("CompactParty", L["Compact party frames"])
    self.boss = make_checkbox("BossTarget", L["Boss target frames"])

    table.insert(bits, self.intro)
    table.insert(bits, self.PlayerFrame)
    table.insert(bits, self.PetFrame)
    table.insert(bits, self.TargetFrame)
    table.insert(bits, self.FocusFrame)
    table.insert(bits, self.FocusFrameToT)

    -- Group these together
    bits[1]:SetPoint("TOPLEFT", 5, -5)

    for i = 2, #bits, 1 do
        bits[i]:SetPoint("TOPLEFT", bits[i-1], "BOTTOMLEFT", 0, 0)
    end

    local last = bits[#bits]

    table.wipe(bits)
    table.insert(bits, self.arena)
    table.insert(bits, self.party)
    table.insert(bits, self.compactraid)
    table.insert(bits, self.compactparty)
    table.insert(bits, self.boss)

    bits[1]:SetPoint("TOPLEFT", last, "BOTTOMLEFT", 0, -15)

    for i = 2, #bits, 1 do
        bits[i]:SetPoint("TOPLEFT", bits[i-1], "BOTTOMLEFT", 0, 0)
    end
end

function panel.refresh()
    local opt = addon.settings.blizzframes

    panel.PlayerFrame:SetChecked(opt.PlayerFrame)
    panel.PetFrame:SetChecked(opt.PetFrame)
    panel.TargetFrame:SetChecked(opt.TargetFrame)
    panel.FocusFrame:SetChecked(opt.FocusFrame)
    panel.FocusFrameToT:SetChecked(opt.FocusFrameToT)
    panel.arena:SetChecked(opt.arena)
    panel.party:SetChecked(opt.party)
    panel.compactraid:SetChecked(opt.compactraid)
    panel.compactparty:SetChecked(opt.compactparty)
    panel.boss:SetChecked(opt.boss)
end

function panel.okay()
    local opt = addon.settings.blizzframes
    opt.PlayerFrame = panel.PlayerFrame:GetChecked()
    opt.PetFrame = panel.PetFrame:GetChecked()
    opt.TargetFrame = panel.TargetFrame:GetChecked()
    opt.FocusFrame = panel.FocusFrame:GetChecked()
    opt.FocusFrameToT = panel.FocusFrameToT:GetChecked()
    opt.arena = panel.arena:GetChecked()
    opt.party = panel.party:GetChecked()
    opt.compactraid = panel.compactraid:GetChecked()
    opt.compactparty = panel.compactparty:GetChecked()
    opt.boss = panel.boss:GetChecked()
end

InterfaceOptions_AddCategory(panel)

--[[---------------------------------------------------------------------------
--  Blizzard Frame integration code 
---------------------------------------------------------------------------]]--
local function enable(frame)
    if type(frame) == "string" then
        local frameName = frame
        frame = _G[frameName]
        if not frame then
            print("Error registering frame: " .. tostring(frameName))
        end
    end

    if frame then
        ClickCastFrames[frame] = true
    end
end

function addon:Enable_BlizzCompactUnitFrames()
    if not addon.settings.blizzframes.compactraid then
        return
    end

    hooksecurefunc("CompactUnitFrame_SetUpFrame", function(frame, ...)
        enable(frame)
    end)
end

function addon:Enable_BlizzArenaFrames()
    if not addon.settings.blizzframes.arena then
        return
    end

    local frames = {
        "ArenaEnemyFrame1",
        "ArenaEnemyFrame2",
        "ArenaEnemyFrame3",
        "ArenaEnemyFrame4",
        "ArenaEnemyFrame5",
    }
    for idx, frame in ipairs(frames) do
        enable(frame)
    end
end

function addon:Enable_BlizzSelfFrames()
    local frames = {
        "PlayerFrame",
        "PetFrame",
        "TargetFrame",
        "TargetFrameToT",
        "FocusFrame",
        "FocusFrameToT",
    }
    for idx, frame in ipairs(frames) do
        if addon.settings.blizzframes[frame] then
            enable(frame)
        end
    end
end

function addon:Enable_BlizzPartyFrames()
    if not addon.settings.blizzframes.party then
        return
    end

    local frames = {
        "PartyMemberFrame1",
		"PartyMemberFrame2",
		"PartyMemberFrame3",
		"PartyMemberFrame4",
        --"PartyMemberFrame5",
		"PartyMemberFrame1PetFrame",
		"PartyMemberFrame2PetFrame",
		"PartyMemberFrame3PetFrame",
        "PartyMemberFrame4PetFrame",
        --"PartyMemberFrame5PetFrame",
    }
    for idx, frame in ipairs(frames) do
        enable(frame)
    end
end

function addon:Enable_BlizzCompactParty()
    if not addon.settings.blizzframes.compactparty then
        return
    end

    local frames = {
        --"CompactPartyFrameMemberSelf", 
        --"CompactPartyFrameMemberSelfBuff1", 
        --"CompactPartyFrameMemberSelfBuff2", 
        --"CompactPartyFrameMemberSelfBuff3", 
        --"CompactPartyFrameMemberSelfDebuff1", 
        --"CompactPartyFrameMemberSelfDebuff2", 
        --"CompactPartyFrameMemberSelfDebuff3", 
        "CompactPartyFrameMember1", 
        "CompactPartyFrameMember1Buff1", 
        "CompactPartyFrameMember1Buff2", 
        "CompactPartyFrameMember1Buff3", 
        "CompactPartyFrameMember1Debuff1", 
        "CompactPartyFrameMember1Debuff2", 
        "CompactPartyFrameMember1Debuff3", 
        "CompactPartyFrameMember2", 
        "CompactPartyFrameMember2Buff1", 
        "CompactPartyFrameMember2Buff2", 
        "CompactPartyFrameMember2Buff3", 
        "CompactPartyFrameMember2Debuff1", 
        "CompactPartyFrameMember2Debuff2", 
        "CompactPartyFrameMember2Debuff3", 
        "CompactPartyFrameMember3", 
        "CompactPartyFrameMember3Buff1", 
        "CompactPartyFrameMember3Buff2", 
        "CompactPartyFrameMember3Buff3", 
        "CompactPartyFrameMember3Debuff1", 
        "CompactPartyFrameMember3Debuff2", 
        "CompactPartyFrameMember3Debuff3", 
        "CompactPartyFrameMember4", 
        "CompactPartyFrameMember4Buff1", 
        "CompactPartyFrameMember4Buff2", 
        "CompactPartyFrameMember4Buff3", 
        "CompactPartyFrameMember4Debuff1", 
        "CompactPartyFrameMember4Debuff2", 
        "CompactPartyFrameMember4Debuff3", 
        "CompactPartyFrameMember5", 
        "CompactPartyFrameMember5Buff1", 
        "CompactPartyFrameMember5Buff2", 
        "CompactPartyFrameMember5Buff3", 
        "CompactPartyFrameMember5Debuff1", 
        "CompactPartyFrameMember5Debuff2", 
        "CompactPartyFrameMember5Debuff3", 
    }
    for idx, frame in ipairs(frames) do
        enable(frame)
    end
end

function addon:Enable_BlizzBossFrames()
    if not addon.settings.blizzframes.boss then
        return
    end

    local frames = {
        "Boss1TargetFrame",
        "Boss2TargetFrame",
        "Boss3TargetFrame",
        "Boss4TargetFrame",
    }
    for idx, frame in ipairs(frames) do
        enable(frame)
    end
end


function addon:EnableBlizzardFrames()
    self:Enable_BlizzCompactUnitFrames()
    self:Enable_BlizzSelfFrames()
    self:Enable_BlizzPartyFrames()
    self:Enable_BlizzCompactParty()
    self:Enable_BlizzBossFrames()
    if IsAddOnLoaded("Blizzard_ArenaUI") then
        self:Enable_BlizzArenaFrames()
    else
        local frame = CreateFrame("Frame")
        frame:RegisterEvent("ADDON_LOADED")
        frame:SetScript("OnEvent", function(frame, event, ...)
            if ... == "Blizzard_ArenaUI" then
                self:UnregisterEvent("ADDON_LOADED")
                self:SetScript("OnEvent", nil)
                self:Enable_BlizzArenaFrames()
            end
        end)
    end
 end

