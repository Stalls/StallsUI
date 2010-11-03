--------------------------------------------------------------------
-- MINIMAP BORDER
--------------------------------------------------------------------

local TukuiMinimap = CreateFrame("Frame", "TukuiMinimap", Minimap)
TukuiMinimap:RegisterEvent("ADDON_LOADED")

TukuiDB.CreatePanel(TukuiMinimap, 144, 144, "CENTER", Minimap, "CENTER", -0, 0)
TukuiMinimap:ClearAllPoints()
TukuiMinimap:SetPoint("TOPLEFT", TukuiDB.Scale(-2), TukuiDB.Scale(2))
TukuiMinimap:SetPoint("BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(-2))

Minimap:ClearAllPoints()
Minimap:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", TukuiDB.Scale(-24), TukuiDB.Scale(-12))
Minimap:SetSize(TukuiDB.Scale(144), TukuiDB.Scale(144))
TukuiDB.CreateGloss(Minimap)
TukuiDB.CreateShadow(TukuiMinimap)

-- Hide Border
MinimapBorder:Hide()
MinimapBorderTop:Hide()

-- Hide Zoom Buttons
MinimapZoomIn:Hide()
MinimapZoomOut:Hide()

-- Hide Voice Chat Frame
MiniMapVoiceChatFrame:Hide()

-- Hide North texture at top
MinimapNorthTag:SetTexture(nil)

-- Hide Zone Frame
MinimapZoneTextButton:Hide()

-- Hide Tracking Button
MiniMapTracking:Hide()

-- Hide Calendar Button
GameTimeFrame:Hide()

-- Hide Mail Button
MiniMapMailFrame:ClearAllPoints()
MiniMapMailFrame:SetPoint("TOPRIGHT", Minimap, TukuiDB.Scale(3), TukuiDB.Scale(4))
MiniMapMailBorder:Hide()
MiniMapMailIcon:SetTexture("Interface\\AddOns\\Tukui\\media\\textures\\mail")

-- Move battleground icon
MiniMapBattlefieldFrame:ClearAllPoints()
MiniMapBattlefieldFrame:SetPoint("BOTTOMRIGHT", Minimap, TukuiDB.Scale(3), 0)
MiniMapBattlefieldBorder:Hide()

-- Hide world map button
MiniMapWorldMapButton:Hide()

-- shitty 3.3 flag to move
MiniMapInstanceDifficulty:ClearAllPoints()
MiniMapInstanceDifficulty:SetParent(Minimap)
MiniMapInstanceDifficulty:SetPoint("TOPLEFT", Minimap, "TOPLEFT", 0, 0)

local function UpdateLFG()
	MiniMapLFGFrame:ClearAllPoints()
	MiniMapLFGFrame:SetPoint("BOTTOMRIGHT", Minimap, "BOTTOMRIGHT", TukuiDB.Scale(2), TukuiDB.Scale(1))
	MiniMapLFGFrameBorder:Hide()
end
hooksecurefunc("MiniMapLFG_UpdateIsShown", UpdateLFG)

-- Enable mouse scrolling
Minimap:EnableMouseWheel(true)
Minimap:SetScript("OnMouseWheel", function(self, d)
	if d > 0 then
		_G.MinimapZoomIn:Click()
	elseif d < 0 then
		_G.MinimapZoomOut:Click()
	end
end)

TukuiMinimap:SetScript("OnEvent", function(self, event, addon)
	if addon == "Blizzard_TimeManager" then
		-- Hide Game Time
		TukuiDB.Kill(TimeManagerClockButton)
	end
end)

----------------------------------------------------------------------------------------
-- Right click menu
----------------------------------------------------------------------------------------

local menuFrame = CreateFrame("Frame", "MinimapRightClickMenu", UIParent, "UIDropDownMenuTemplate")
local menuList = {
    {text = CHARACTER_BUTTON,
    func = function() ToggleCharacter("PaperDollFrame") end},
    {text = SPELLBOOK_ABILITIES_BUTTON,
    func = function() ToggleFrame(SpellBookFrame) end},
    {text = TALENTS_BUTTON,
    func = function() if not PlayerTalentFrame then LoadAddOn("Blizzard_TalentUI") end PlayerTalentFrame_Toggle() end},
    {text = ACHIEVEMENT_BUTTON,
    func = function() ToggleAchievementFrame() end},
    {text = QUESTLOG_BUTTON,
    func = function() ToggleFrame(QuestLogFrame) end},
    {text = SOCIAL_BUTTON,
    func = function() ToggleFriendsFrame(1) end},
    {text = PLAYER_V_PLAYER,
    func = function() ToggleFrame(PVPFrame) end},
    {text = ACHIEVEMENTS_GUILD_TAB,
    func = function() if IsInGuild() then if not GuildFrame then LoadAddOn("Blizzard_GuildUI") end GuildFrame_Toggle() end end},
    {text = LFG_TITLE,
    func = function() ToggleFrame(LFDParentFrame) end},
    {text = L_LFRAID,
    func = function() ToggleFrame(LFRParentFrame) end},
    {text = HELP_BUTTON,
    func = function() ToggleHelpFrame() end},
    {text = L_CALENDAR,
    func = function()
    if(not CalendarFrame) then LoadAddOn("Blizzard_Calendar") end
        Calendar_Toggle()
    end},
}

Minimap:SetScript("OnMouseUp", function(self, btn)
	if btn == "RightButton" then
		ToggleDropDownMenu(1, nil, MiniMapTrackingDropDown, self)
	elseif btn == "MiddleButton" then
		EasyMenu(menuList, menuFrame, "cursor", 0, 0, "MENU", 2)
	else
		Minimap_OnClick(self)
	end
end)


-- Set Square Map Mask
Minimap:SetMaskTexture('Interface\\ChatFrame\\ChatFrameBackground')

-- For others mods with a minimap button, set minimap buttons position in square mode.
function GetMinimapShape() return 'SQUARE' end

-- reskin LFG dropdown
TukuiDB.SetTemplate(LFDSearchStatus)

----------------------------------------------------------------------------------------
-- Animation Coords and Current Zone. Awesome feature by AlleyKat.
----------------------------------------------------------------------------------------


--Style Zone and Coord panels
local m_zone = CreateFrame("Frame","zonebar",topbar)
TukuiDB.CreatePanel(m_zone, 140, 16, "TOP", topbar, "TOP", 0, TukuiDB.Scale(-7))
m_zone:SetFrameLevel(5)
m_zone:SetFrameStrata("MEDIUM")
TukuiDB.CreateShadow(m_zone)
TukuiDB.CreateGloss(m_zone)
m_zone:SetBackdropColor(TukuiCF["media"].backdropcolor[1], TukuiCF["media"].backdropcolor[2], TukuiCF["media"].backdropcolor[3], 0.7)

local m_zone_text = m_zone:CreateFontString(nil,"Overlay")
m_zone_text:SetFont(TukuiCF["media"].font, 10, "OUTLINE")
m_zone_text:SetPoint("Center",0,0)
m_zone_text:SetJustifyH("CENTER")
m_zone_text:SetJustifyV("MIDDLE")
m_zone_text:SetHeight(TukuiDB.Scale(m_zone:GetHeight()))
m_zone_text:SetWidth(TukuiDB.Scale(m_zone:GetWidth()-6))

local m_coord_x = CreateFrame("Frame","coordx",UIParent)
TukuiDB.CreatePanel(m_coord_x, 40, 16, "RIGHT", m_zone, "LEFT", TukuiDB.Scale(2), 0)
m_coord_x:SetFrameStrata("MEDIUM")
m_coord_x:SetBackdropColor(TukuiCF["media"].backdropcolor[1], TukuiCF["media"].backdropcolor[2], TukuiCF["media"].backdropcolor[3], 0.7)
TukuiDB.CreateGloss(m_coord_x)

local m_coord_text_x = m_coord_x:CreateFontString(nil,"Overlay")
m_coord_text_x:SetFont(TukuiCF["media"].pixelfont, 8, "MONOCHROMEOUTLINE")
m_coord_text_x:SetPoint("Center",TukuiDB.Scale(-1),0)
m_coord_text_x:SetJustifyH("CENTER")
m_coord_text_x:SetJustifyV("MIDDLE")
 
m_coord_text_x:SetText("--")

local m_coord_y = CreateFrame("Frame","coordy",UIParent)
TukuiDB.CreatePanel(m_coord_y, 40, 16, "LEFT", m_zone, "RIGHT", TukuiDB.Scale(-2), 0)
m_coord_y:SetFrameStrata("MEDIUM")
m_coord_y:SetBackdropColor(TukuiCF["media"].backdropcolor[1], TukuiCF["media"].backdropcolor[2], TukuiCF["media"].backdropcolor[3], 0.7)
TukuiDB.CreateGloss(m_coord_y)

local m_coord_text_y = m_coord_y:CreateFontString(nil,"Overlay")
m_coord_text_y:SetFont(TukuiCF["media"].pixelfont, 8, "MONOCHROMEOUTLINE")
m_coord_text_y:SetPoint("Center",TukuiDB.Scale(-1),0)
m_coord_text_y:SetJustifyH("CENTER")
m_coord_text_y:SetJustifyV("MIDDLE")
 
m_coord_text_y:SetText("--")

local ela,go = 1,true
 
local coord_Update = function(self,t)
	ela = ela - t
	if ela > 0 or not(go) then return end
	local x,y = GetPlayerMapPosition("player")
	local xt,yt
	x = math.floor(100 * x)
	y = math.floor(100 * y)
	if x == 0 and y == 0 then
		m_coord_text_x:SetText("--")
		m_coord_text_y:SetText("--")
	else
		if x < 10 then
			xt = "0"..x
		else
			xt = x
		end
		if y < 10 then
			yt = "0"..y
		else
			yt = y
		end
		m_coord_text_x:SetText(xt)
		m_coord_text_y:SetText(yt)
	end
	ela = .2
end
 
coordx:SetScript("OnUpdate",coord_Update)
--m_coord_y:SetScript("OnUpdate",coord_Update)
 
local zone_Update = function()
	local pvp = GetZonePVPInfo()
	m_zone_text:SetText(GetMinimapZoneText())
	if pvp == "friendly" then
		m_zone_text:SetTextColor(0.1, 1.0, 0.1)
	elseif pvp == "sanctuary" then
		m_zone_text:SetTextColor(0.41, 0.8, 0.94)
	elseif pvp == "arena" or pvp == "hostile" then
		m_zone_text:SetTextColor(1.0, 0.1, 0.1)
	elseif pvp == "contested" then
		m_zone_text:SetTextColor(1.0, 0.7, 0.0)
	else
		m_zone_text:SetTextColor(1.0, 1.0, 1.0)
	end
end
 
m_zone:RegisterEvent("PLAYER_ENTERING_WORLD")
m_zone:RegisterEvent("ZONE_CHANGED_NEW_AREA")
m_zone:RegisterEvent("ZONE_CHANGED")
m_zone:RegisterEvent("ZONE_CHANGED_INDOORS")
m_zone:SetScript("OnEvent",zone_Update) 
 
local a,k = CreateFrame("Frame"),4
a:SetScript("OnUpdate",function(self,t)
	k = k - t
	if k > 0 then return end
	zone_Update()
end)