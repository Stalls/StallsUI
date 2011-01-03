-- ACTION BAR PANEL
TukuiDB.buttonsize = TukuiDB.Scale(27)
TukuiDB.buttonspacing = TukuiDB.Scale(4)
TukuiDB.petbuttonsize = TukuiDB.Scale(29)
TukuiDB.petbuttonspacing = TukuiDB.Scale(4)

-- set left and right info panel width
TukuiCF["panels"] = {["tinfowidth"] = 370}

local barbg = CreateFrame("Frame", "TukuiActionBarBackground", UIParent)
TukuiDB.CreatePanel(barbg, 1, 1, "BOTTOM", UIParent, "BOTTOM", 0, TukuiDB.Scale(5))
if TukuiDB.lowversion == true then
	barbg:SetWidth((TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13))
	if TukuiCF["actionbar"].bottomrows == 2 then
		barbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	else
		barbg:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	end
else
	barbg:SetWidth((TukuiDB.buttonsize * 22) + (TukuiDB.buttonspacing * 23))
	if TukuiCF["actionbar"].bottomrows == 2 then
		barbg:SetHeight((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	else
		barbg:SetHeight(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	end
end
barbg:SetFrameStrata("BACKGROUND")
barbg:SetFrameLevel(1)
barbg:SetBackdropColor(0,0,0,0)
barbg:SetBackdropBorderColor(0,0,0,0)

-- INVISIBLE FRAME COVERING TukuiActionBarBackground
local invbarbg = CreateFrame("Frame", "InvTukuiActionBarBackground", UIParent)
invbarbg:SetSize(barbg:GetWidth(), barbg:GetHeight())
invbarbg:SetPoint("BOTTOM", 0, TukuiDB.Scale(14))

-- LEFT VERTICAL LINE
local ileftlv = CreateFrame("Frame", "TukuiInfoLeftLineVertical", barbg)
TukuiDB.CreatePanel(ileftlv, 2, 130, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", TukuiDB.Scale(22), TukuiDB.Scale(30))
ileftlv:SetAlpha(0)

-- RIGHT VERTICAL LINE
local irightlv = CreateFrame("Frame", "TukuiInfoRightLineVertical", barbg)
TukuiDB.CreatePanel(irightlv, 2, 130, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", TukuiDB.Scale(-22), TukuiDB.Scale(30))
irightlv:SetAlpha(0)

-- CUBE AT LEFT, ACT AS A BUTTON (CHAT MENU)
local cubeleft = CreateFrame("Frame", "TukuiCubeLeft", UIParent)
TukuiDB.CreatePanel(cubeleft, 10, 10, "RIGHT", TukuiActionBarBackground, "LEFT", TukuiDB.Scale(-10), 0)
cubeleft:EnableMouse(true)
cubeleft:SetScript("OnMouseDown", function(self, btn)
	if TukuiInfoLeftBattleGround then
		if btn == "RightButton" then
			if TukuiInfoLeftBattleGround:IsShown() then
				TukuiInfoLeftBattleGround:Hide()
			else
				TukuiInfoLeftBattleGround:Show()
			end
		end
	end
	
	if btn == "LeftButton" then	
		ToggleFrame(ChatMenu)
	end
end)

-- CUBE AT RIGHT, ACT AS A BUTTON (CONFIGUI or BG'S)
local cuberight = CreateFrame("Frame", "TukuiCubeRight", UIParent)
TukuiDB.CreatePanel(cuberight, 10, 10, "LEFT", TukuiActionBarBackground, "RIGHT", TukuiDB.Scale(10), 0)
if TukuiCF["bags"].enable then
	cuberight:EnableMouse(true)
	cuberight:SetScript("OnMouseDown", function(self)
		ToggleKeyRing()
	end)
end

-- HORIZONTAL LINE LEFT
local ltoabl = CreateFrame("Frame", "TukuiLineToABLeft", barbg)
TukuiDB.CreatePanel(ltoabl, 5, 2, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)
ltoabl:ClearAllPoints()
ltoabl:SetPoint("BOTTOMLEFT", ileftlv, "BOTTOMLEFT", 0, 0)
ltoabl:SetPoint("RIGHT", barbg, "BOTTOMLEFT", TukuiDB.Scale(-1), TukuiDB.Scale(17))
ltoabl:SetAlpha(0)

-- HORIZONTAL LINE RIGHT
local ltoabr = CreateFrame("Frame", "TukuiLineToABRight", barbg)
TukuiDB.CreatePanel(ltoabr, 5, 2, "BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", 0, 0)
ltoabr:ClearAllPoints()
ltoabr:SetPoint("LEFT", barbg, "BOTTOMRIGHT", TukuiDB.Scale(1), TukuiDB.Scale(17))
ltoabr:SetPoint("BOTTOMRIGHT", irightlv, "BOTTOMRIGHT", 0, 0)
ltoabr:SetAlpha(0)

-- INFO LEFT (FOR STATS)
local ileft = CreateFrame("Frame", "TukuiInfoLeft", UIParent)
TukuiDB.CreatePanel(ileft, TukuiCF["panels"].tinfowidth, 23, "LEFT", ltoabl, "LEFT", TukuiDB.Scale(14), TukuiDB.Scale(-10))
ileft:SetFrameLevel(2)
ileft:SetFrameStrata("BACKGROUND")
ileft:SetBackdropColor(TukuiCF["media"].backdropcolor[1], TukuiCF["media"].backdropcolor[2], TukuiCF["media"].backdropcolor[3], 0.7)
ileft:SetBackdropBorderColor(TukuiCF["media"].bordercolor[1], TukuiCF["media"].bordercolor[2], TukuiCF["media"].bordercolor[3], 0.7)
TukuiDB.CreateShadow(ileft)
TukuiDB.CreateGloss(ileft)


-- INFO RIGHT (FOR STATS)
local iright = CreateFrame("Frame", "TukuiInfoRight", UIParent)
TukuiDB.CreatePanel(iright, TukuiCF["panels"].tinfowidth, 23, "RIGHT", ltoabr, "RIGHT", TukuiDB.Scale(-14), TukuiDB.Scale(-10))
iright:SetFrameLevel(2)
iright:SetFrameStrata("BACKGROUND")
iright:SetBackdropColor(TukuiCF["media"].backdropcolor[1], TukuiCF["media"].backdropcolor[2], TukuiCF["media"].backdropcolor[3], 0.7)
iright:SetBackdropBorderColor(TukuiCF["media"].bordercolor[1], TukuiCF["media"].bordercolor[2], TukuiCF["media"].bordercolor[3], 0.7)
TukuiDB.CreateShadow(iright)
TukuiDB.CreateGloss(iright)

--if TukuiMinimap then
--	local minimapstatsleft = CreateFrame("Frame", "TukuiMinimapStatsLeft", TukuiMinimap)
--	TukuiDB.CreatePanel(minimapstatsleft, ((TukuiMinimap:GetWidth() + 4) / 2) - 1, 19, "TOPLEFT", TukuiMinimap, "BOTTOMLEFT", 0, TukuiDB.Scale(-2))

--	local minimapstatsright = CreateFrame("Frame", "TukuiMinimapStatsRight", TukuiMinimap)
--	TukuiDB.CreatePanel(minimapstatsright, ((TukuiMinimap:GetWidth() + 4) / 2) -1, 19, "TOPRIGHT", TukuiMinimap, "BOTTOMRIGHT", 0, TukuiDB.Scale(-2))
--end

--RIGHT BAR BACKGROUND
if TukuiCF["actionbar"].enable == true then
	local barbgr = CreateFrame("Frame", "TukuiActionBarBackgroundRight", UIParent)
	TukuiDB.CreatePanel(barbgr, 1, (TukuiDB.buttonsize * 12) + (TukuiDB.buttonspacing * 13), "RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-23), TukuiDB.Scale(-13.5))
	if TukuiCF["actionbar"].rightbars == 1 then
		barbgr:SetWidth(TukuiDB.buttonsize + (TukuiDB.buttonspacing * 2))
	elseif TukuiCF["actionbar"].rightbars == 2 then
		barbgr:SetWidth((TukuiDB.buttonsize * 2) + (TukuiDB.buttonspacing * 3))
	elseif TukuiCF["actionbar"].rightbars == 3 then
		barbgr:SetWidth((TukuiDB.buttonsize * 3) + (TukuiDB.buttonspacing * 4))
	else
		barbgr:Hide()
	end
	if TukuiCF["actionbar"].rightbars > 0 then
		local rbl = CreateFrame("Frame", "TukuiRightBarLine", barbgr)
		local crblu = CreateFrame("Frame", "TukuiCubeRightBarUP", barbgr)
		local crbld = CreateFrame("Frame", "TukuiCubeRightBarDown", barbgr)
		TukuiDB.CreatePanel(rbl, 2, (TukuiDB.buttonsize / 2 * 27) + (TukuiDB.buttonspacing * 6), "RIGHT", barbgr, "RIGHT", TukuiDB.Scale(1), 0)
		rbl:SetWidth(TukuiDB.Scale(2))
		TukuiDB.CreatePanel(crblu, 10, 10, "BOTTOM", rbl, "TOP", 0, 0)
		TukuiDB.CreatePanel(crbld, 10, 10, "TOP", rbl, "BOTTOM", 0, 0)
	end

	local petbg = CreateFrame("Frame", "TukuiPetActionBarBackground", UIParent)
	if TukuiCF["actionbar"].rightbars > 0 then
		TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "RIGHT", barbgr, "LEFT", TukuiDB.Scale(-6), 0)
	else
		TukuiDB.CreatePanel(petbg, TukuiDB.petbuttonsize + (TukuiDB.petbuttonspacing * 2), (TukuiDB.petbuttonsize * 10) + (TukuiDB.petbuttonspacing * 11), "RIGHT", UIParent, "RIGHT", TukuiDB.Scale(-6), TukuiDB.Scale(-13.5))
	end

	local ltpetbg1 = CreateFrame("Frame", "TukuiLineToPetActionBarBackground", petbg)
	TukuiDB.CreatePanel(ltpetbg1, 30, 265, "TOPLEFT", petbg, "TOPRIGHT", 0, TukuiDB.Scale(-33))
	ltpetbg1:SetFrameLevel(0)
	ltpetbg1:SetAlpha(.8)
end

--BATTLEGROUND STATS FRAME
if TukuiCF["datatext"].battleground == true then
	local bgframe = CreateFrame("Frame", "TukuiInfoLeftBattleGround", UIParent)
	TukuiDB.CreatePanel(bgframe, 1, 1, "TOPLEFT", UIParent, "BOTTOMLEFT", 0, 0)
	bgframe:SetAllPoints(ileft)
	bgframe:SetFrameStrata("LOW")
	bgframe:SetFrameLevel(0)
	bgframe:EnableMouse(true)
end

-- Chat background
local chatleft = CreateFrame("Frame", "ChatLeftBackground", UIParent)
TukuiDB.CreatePanel(chatleft, TukuiCF["panels"].tinfowidth, 120, "BOTTOMLEFT", TukuiInfoLeft, "TOPLEFT", TukuiDB.Scale(0), TukuiDB.Scale(0))
chatleft:SetFrameLevel(1)
chatleft:SetFrameStrata("BACKGROUND")
chatleft:SetBackdropColor(TukuiCF["media"].backdropcolor[1], TukuiCF["media"].backdropcolor[2], TukuiCF["media"].backdropcolor[3], 0.7)
chatleft:SetBackdropBorderColor(TukuiCF["media"].bordercolor[1], TukuiCF["media"].bordercolor[2], TukuiCF["media"].bordercolor[3], 0.7)

-- Tab background
local chattableft = CreateFrame("Frame", "ChatLeftTabsBackground", UIParent)
TukuiDB.CreatePanel(chattableft, TukuiCF["panels"].tinfowidth-44, 23, "BOTTOMLEFT", ChatLeftBackground, "TOPLEFT", TukuiDB.Scale(0), TukuiDB.Scale(0))
chattableft:SetFrameLevel(2)
chattableft:SetFrameStrata("BACKGROUND")
chattableft:SetBackdropColor(TukuiCF["media"].backdropcolor[1], TukuiCF["media"].backdropcolor[2], TukuiCF["media"].backdropcolor[3], 0.7)
chattableft:SetBackdropBorderColor(TukuiCF["media"].bordercolor[1], TukuiCF["media"].bordercolor[2], TukuiCF["media"].bordercolor[3], 0.7)
TukuiDB.CreateShadow(chattableft)
TukuiDB.CreateGloss(chattableft)

-- Top viewport
local topbar = CreateFrame("Frame", "topbar", UIParent)
TukuiDB.CreatePanel(topbar, UIParent:GetWidth() + (TukuiDB.mult * 2), 23, "TOPLEFT", UIParent, "TOPLEFT", -TukuiDB.mult, TukuiDB.Scale(3))
topbar:SetPoint("TOPRIGHT", UIParent, "TOPRIGHT", TukuiDB.mult, TukuiDB.Scale(3))
topbar:SetFrameLevel(1)
topbar:SetFrameStrata("BACKGROUND")
TukuiDB.CreateGloss(topbar)
TukuiDB.CreateShadow(topbar)
if TukuiCF.others.showviewport == false then
	topbar:SetAlpha(0)
end

-- Bottom viewport
local bottombar = CreateFrame("Frame", "bottombar", UIParent)
TukuiDB.CreatePanel(bottombar, UIParent:GetWidth() + (TukuiDB.mult * 2), 23, "BOTTOMLEFT", UIParent, "BOTTOMLEFT", -TukuiDB.mult, TukuiDB.Scale(-3))
bottombar:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", TukuiDB.mult, TukuiDB.Scale(-3))
bottombar:SetFrameLevel(1)
TukuiDB.CreateGloss(bottombar)
TukuiDB.CreateShadow(bottombar)
if TukuiCF.others.showviewport == false then
	bottombar:SetAlpha(0)
end

-- Experience statusblock
local xpbar = CreateFrame("Frame", "ExperienceStatusBar", UIParent)
TukuiDB.CreatePanel( xpbar, 130, 23, "TOPLEFT", topbar, "TOPLEFT", TukuiDB.Scale(300), TukuiDB.Scale(-13))
xpbar:SetFrameLevel(2)
xpbar:SetFrameStrata("BACKGROUND")
TukuiDB.CreateShadow(xpbar)
TukuiDB.CreateGloss(xpbar)
xpbar:SetAlpha(0.9)

-- Performance statusblock
local perfbar = CreateFrame("Frame", "PerformanceStatusBar", UIParent)
TukuiDB.CreatePanel( perfbar, 130, 23, "RIGHT", xpbar, "LEFT", TukuiDB.Scale(-8), 0)
perfbar:SetFrameLevel(2)
perfbar:SetFrameStrata("BACKGROUND")
TukuiDB.CreateShadow(perfbar)
TukuiDB.CreateGloss(perfbar)
perfbar:SetAlpha(0.9)

-- Durability statusblock
local durabar = CreateFrame("Frame", "DurabilityStatusBar", UIParent)
TukuiDB.CreatePanel( durabar, 130, 23, "LEFT", xpbar, "RIGHT", TukuiDB.Scale(8), 0)
durabar:SetFrameLevel(2)
durabar:SetFrameStrata("BACKGROUND")
TukuiDB.CreateShadow(durabar)
TukuiDB.CreateGloss(durabar)
durabar:SetAlpha(0.9)





-- Mark Bar created by Smelly
-- Credits to Hydra, Elv22, Safturento, and many more!
 
-- Config
font = TukuiCF.media.font           	-- Font to be used for button text
fontsize = 12                     		-- Size of font for button text
buttonwidth = TukuiDB.Scale(30)    -- Width of menu buttons
buttonheight = TukuiDB.Scale(30)   -- Height of menu buttons
toplayout = false

-- Default position of toggle button and background
local anchor = {}
if toplayout == true then
	anchor = {"TOPLEFT", UIParent, "TOP", 0, -3}
else
	anchor = {"BOTTOMLEFT", ChatLeftTabsBackground, "TOPLEFT", 0, 3}
end

--Background Frame
local MarkBarBG = CreateFrame("Frame", "MarkBarBackground", UIParent)
TukuiDB.CreatePanel(MarkBarBG, buttonwidth * 8 + TukuiDB.Scale(27), buttonheight + TukuiDB.Scale(6), "BOTTOMLEFT", TukuiInfoRight, "TOPLEFT", 0, TukuiDB.Scale(3))
MarkBarBG:SetBackdropColor(unpack(TukuiCF["media"].backdropcolor))
MarkBarBG:SetFrameLevel(0)
MarkBarBG:ClearAllPoints()
MarkBarBG:SetPoint(unpack(anchor))
TukuiDB.CreateShadow(MarkBarBG)
TukuiDB.CreateGloss(MarkBarBG)
MarkBarBG:Hide()
 
--Change border when mouse is inside the button
local function ButtonEnter(self)
	local color = RAID_CLASS_COLORS[TukuiDB.myclass]
	self:SetBackdropBorderColor(color.r, color.g, color.b)
end
 
--Change border back to normal when mouse leaves button
local function ButtonLeave(self)
	self:SetBackdropBorderColor(unpack(TukuiCF["media"].bordercolor))
end

-- Mark Button BG and icons
icon = CreateFrame("Button", "tmb_Icon", MarkBarBG)
mark = CreateFrame("Button", "tmb_Menu", MarkBarBG)
for i = 1, 8 do
	mark[i] = CreateFrame("Button", "tbm_Mark"..i, MarkBarBG)
	TukuiDB.CreatePanel(mark[i], buttonwidth, buttonheight, "LEFT", MarkBarBG, "LEFT", TukuiDB.Scale(3), 0)
	if i == 1 then
		mark[i]:SetPoint("LEFT", MarkBarBG, "LEFT",  TukuiDB.Scale(3), 0)
	else
		mark[i]:SetPoint("LEFT", mark[i-1], "RIGHT", TukuiDB.Scale(3), 0)
	end
	mark[i]:EnableMouse(true)
	mark[i]:SetScript("OnEnter", ButtonEnter)
	mark[i]:SetScript("OnLeave", ButtonLeave)
	mark[i]:RegisterForClicks("AnyUp")
	
	icon[i] = CreateFrame("Button", "icon"..i, MarkBarBG)
	icon[i]:SetNormalTexture("Interface\\TargetingFrame\\UI-RaidTargetingIcons")
	icon[i]:SetSize(25, 25)
	icon[i]:SetPoint("CENTER", mark[i])
	
	-- Set up each button
	if i == 1 then -- Skull
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 8) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.75,1,0.25,0.5)
	elseif i == 2 then -- Cross
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 7) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.5,0.75,0.25,0.5)
	elseif i == 3 then -- Square
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 6) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.25,0.5,0.25,0.5)
	elseif i == 4 then -- Moon
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 5) end)
		icon[i]:GetNormalTexture():SetTexCoord(0,0.25,0.25,0.5)
	elseif i == 5 then -- Triangle
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 4) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.75,1,0,0.25)
	elseif i == 6 then -- Diamond
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 3) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.5,0.75,0,0.25)
	elseif i == 7 then -- Circle
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 2) end)
		icon[i]:GetNormalTexture():SetTexCoord(0.25,0.5,0,0.25)
	elseif i == 8 then -- Star
		mark[i]:SetScript("OnMouseUp", function() SetRaidTarget("target", 1) end)
		icon[i]:GetNormalTexture():SetTexCoord(0,0.25,0,0.25)
	end
end
 
--Create button for when frame is hidden
local HiddenToggleButton = CreateFrame("Button", "tmb_HiddenToggleButton", UIParent)
TukuiDB.CreatePanel(HiddenToggleButton, 70, 18, "BOTTOMLEFT", TukuiInfoRight, "TOPLEFT", 0, TukuiDB.Scale(3))
TukuiDB.CreateShadow(HiddenToggleButton)
TukuiDB.CreateGloss(HiddenToggleButton)
HiddenToggleButton:SetAlpha(0.8)
HiddenToggleButton:ClearAllPoints()
tmb_HiddenToggleButton:SetPoint(unpack(anchor))
HiddenToggleButton:SetScript("OnEnter", ButtonEnter)
HiddenToggleButton:SetScript("OnLeave", ButtonLeave)
HiddenToggleButton:SetScript("OnMouseUp", function(self)
	MarkBarBackground:Show()
	HiddenToggleButton:Hide()
end)
 
local HiddenToggleButtonText = HiddenToggleButton:CreateFontString("tmb_HiddenToggleButtonText","OVERLAY",HiddenToggleButton)
HiddenToggleButtonText:SetFont(TukuiCF.media.font,fontsize,"OUTLINE")
HiddenToggleButtonText:SetText(MarkBarLocal.button_MarkBar)
HiddenToggleButtonText:SetPoint("CENTER")
HiddenToggleButtonText:SetJustifyH("CENTER")
 
--Create button for when frame is shown
local ShownToggleButton = CreateFrame("Button", "tmb_ShownToggleButton", MarkBarBackground)
TukuiDB.CreatePanel(ShownToggleButton, 18, 18, "BOTTOMLEFT", MarkBarBackground, "TOPLEFT", 0, TukuiDB.Scale(3))
ShownToggleButton:ClearAllPoints()
if toplayout == true then 
	tmb_ShownToggleButton:SetPoint("TOPLEFT", MarkBarBackground, "BOTTOMLEFT", 0, TukuiDB.Scale(-3))
else
	tmb_ShownToggleButton:SetPoint("BOTTOMLEFT", MarkBarBackground, "TOPLEFT", 0, TukuiDB.Scale(3))
end
ShownToggleButton:SetScript("OnEnter", ButtonEnter)
ShownToggleButton:SetScript("OnLeave", ButtonLeave)
ShownToggleButton:SetScript("OnMouseUp", function(self)
	MarkBarBackground:Hide()
	RaidUitilityPanel:Hide()
	HiddenToggleButton:Show()
end)
 
local ShownToggleButtonText = ShownToggleButton:CreateFontString("tmb_ShownToggleButtonText","OVERLAY",ShownToggleButton)
ShownToggleButtonText:SetFont(TukuiCF.media.font,fontsize,"OUTLINE")
ShownToggleButtonText:SetText("X")
ShownToggleButtonText:SetPoint("CENTER", ShownToggleButton, "CENTER")
ShownToggleButtonText:SetJustifyH("CENTER")
 
 -- Create Button for clear target
local ClearTargetButton = CreateFrame("Button", "ClearTargetButton", MarkBarBackground)
TukuiDB.CreatePanel(ClearTargetButton, 77, 18, "LEFT", ShownToggleButton, "RIGHT", TukuiDB.Scale(3), 0)
ClearTargetButton:SetScript("OnEnter", ButtonEnter)
ClearTargetButton:SetScript("OnLeave", ButtonLeave)
ClearTargetButton:SetScript("OnMouseUp", function() SetRaidTarget("target", 0) end)

local ClearTargetButtonText = ClearTargetButton:CreateFontString("ClearTargetButtonText","OVERLAY", ClearTargetButton)
ClearTargetButtonText:SetFont(TukuiCF.media.font,fontsize,"OUTLINE")
ClearTargetButtonText:SetText(MarkBarLocal.button_Clear)
ClearTargetButtonText:SetPoint("CENTER")
ClearTargetButtonText:SetJustifyH("CENTER", 1, 0)
	
------------------------------------------------------------------------
-- Raid utility---------------------------------------------------------
------------------------------------------------------------------------

local panel_height = ((TukuiDB.Scale(5)*4) + (TukuiDB.Scale(20)*4))
tukuilocal.core_raidutil_blue = "Blue"
tukuilocal.core_raidutil_green = "Green"
tukuilocal.core_raidutil_purple = "Purple"
tukuilocal.core_raidutil_red = "Red"
tukuilocal.core_raidutil_white = "White"
tukuilocal.core_raidutil_clear = "Clear"
 
--Create main frame
local RaidUtilityPanel = CreateFrame("Frame", "RaidUtilityPanel", UIParent)
TukuiDB.CreatePanel(RaidUtilityPanel, TukuiDB.Scale(165), panel_height, "BOTTOMRIGHT", MarkBarBackground, "TOPRIGHT", 0, 3)
RaidUtilityPanel:ClearAllPoints()
if toplayout == true then 
	RaidUtilityPanel:SetPoint("TOPRIGHT", MarkBarBackground, "BOTTOMRIGHT", 0, TukuiDB.Scale(-3))
else
	RaidUtilityPanel:SetPoint("BOTTOMRIGHT", MarkBarBackground, "TOPRIGHT", 0, TukuiDB.Scale(3))
end
local r,g,b,_ = TukuiCF["media"].backdropcolor
RaidUtilityPanel:Hide()

--Create button for when frame is hidden
local HiddenToggleButton = CreateFrame("Button", HiddenToggleButton, UIParent)
TukuiDB.CreatePanel(HiddenToggleButton, TukuiDB.Scale(RaidUtilityPanel:GetWidth()), 18, "BOTTOMRIGHT", MarkBarBackground, "TOPRIGHT", TukuiDB.Scale(0), TukuiDB.Scale(3))
HiddenToggleButton:ClearAllPoints()
if toplayout == true then 
	HiddenToggleButton:SetPoint("TOPRIGHT", MarkBarBackground, "BOTTOMRIGHT", 0, TukuiDB.Scale(-3))
else
	HiddenToggleButton:SetPoint("BOTTOMRIGHT", MarkBarBackground, "TOPRIGHT", 0, TukuiDB.Scale(3))
end
HiddenToggleButton:SetScript("OnEnter", ButtonEnter)
HiddenToggleButton:SetScript("OnLeave", ButtonLeave)
HiddenToggleButton:SetScript("OnMouseUp", function(self)
	RaidUtilityPanel:Show()
	HiddenToggleButton:Hide()
end)

local HiddenToggleButtonText = HiddenToggleButton:CreateFontString(nil,"OVERLAY",HiddenToggleButton)
HiddenToggleButtonText:SetFont(TukuiCF.media.font,12,"OUTLINE")
HiddenToggleButtonText:SetText(MarkBarLocal.button_RaidUtility)
HiddenToggleButtonText:SetPoint("CENTER")
HiddenToggleButtonText:SetJustifyH("CENTER")
 
--Create button for when frame is shown
local ShownToggleButton = CreateFrame("Button", ShownToggleButton, RaidUtilityPanel)
TukuiDB.CreatePanel(ShownToggleButton, TukuiDB.Scale(RaidUtilityPanel:GetWidth() / 2.5), 18, "BOTTOM", RaidUtilityPanel, "TOP", TukuiDB.Scale(0), TukuiDB.Scale(3))
ShownToggleButton:ClearAllPoints()
if toplayout == true then 
	ShownToggleButton:SetPoint("TOP", RaidUtilityPanel, "BOTTOM", 0, TukuiDB.Scale(-3))
else
	ShownToggleButton:SetPoint("BOTTOM", RaidUtilityPanel, "TOP", TukuiDB.Scale(0), TukuiDB.Scale(3))
end
ShownToggleButton:SetScript("OnEnter", ButtonEnter)
ShownToggleButton:SetScript("OnLeave", ButtonLeave)
ShownToggleButton:SetScript("OnMouseUp", function(self)
	RaidUtilityPanel:Hide()
	tmb_HiddenToggleButton:Hide()
	HiddenToggleButton:Show()
	MarkBarBackground:Show()
end)
 
local ShownToggleButtonText = ShownToggleButton:CreateFontString(nil,"OVERLAY",ShownToggleButton)
ShownToggleButtonText:SetFont(TukuiCF.media.font,12,"OUTLINE")
ShownToggleButtonText:SetText(CLOSE)
ShownToggleButtonText:SetPoint("CENTER")
ShownToggleButtonText:SetJustifyH("CENTER")
 
-- Function to create buttons in this module
local function CreateButton(name, parent, template, width, height, point, relativeto, point2, xOfs, yOfs, text, texture)
	local b = CreateFrame("Button", name, parent, template)
	b:SetWidth(width)
	b:SetHeight(height)
	b:SetPoint(point, relativeto, point2, xOfs, yOfs)
	b:HookScript("OnEnter", ButtonEnter)
	b:HookScript("OnLeave", ButtonLeave)
	b:EnableMouse(true)
	TukuiDB.SetTemplate(b)
	if text then
		local t = b:CreateFontString(nil,"OVERLAY",b)
		t:SetFont(TukuiCF.media.font,12,"OUTLINE")
		t:SetPoint("CENTER")
		t:SetJustifyH("CENTER")
		t:SetText(text)
	elseif texture then
		local t = b:CreateTexture(nil,"OVERLAY",nil)
		t:SetTexture(texture)
		t:SetPoint("TOPLEFT", b, "TOPLEFT", TukuiDB.mult, -TukuiDB.mult)
		t:SetPoint("BOTTOMRIGHT", b, "BOTTOMRIGHT", -TukuiDB.mult, TukuiDB.mult)
	end
end

--Check if we are Raid Leader or Raid Officer
local function CheckRaidStatus()
	local inInstance, instanceType = IsInInstance()
	local partyMembers = GetNumPartyMembers()
 
	if not UnitInRaid("player") and partyMembers >= 1 then return true
	elseif UnitIsRaidOfficer("player") then return true
	elseif not inInstance or instanceType == "pvp" or instanceType == "arena" then return false
	end
end

--Automatically show/hide the frame if we have RaidLeader or RaidOfficer
local LeadershipCheck = CreateFrame("Frame")
LeadershipCheck:RegisterEvent("RAID_ROSTER_UPDATE")
LeadershipCheck:RegisterEvent("PARTY_MEMBERS_CHANGED")
LeadershipCheck:RegisterEvent("PLAYER_ENTERING_WORLD")
LeadershipCheck:SetScript("OnEvent", function(self, event)
	if CheckRaidStatus() then
		tmb_HiddenToggleButton:Show()
		MarkBarBackground:Hide()
		RaidUtilityPanel:Hide()
	else
		--Hide Everything..
		HiddenToggleButton:Hide()
		MarkBarBackground:Hide()
		tmb_HiddenToggleButton:Hide()
		RaidUtilityPanel:Hide()
	end
end)
 
--Disband Raid button
CreateButton("DisbandRaidButton", RaidUtilityPanel, nil, RaidUtilityPanel:GetWidth() * 0.8, TukuiDB.Scale(18), "TOP", RaidUtilityPanel, "TOP", 0, TukuiDB.Scale(-5), MarkBarLocal.button_Disband, nil)
DisbandRaidButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		StaticPopup_Show("DISBAND_RAID")
	end
end)
 
--Role Check button
CreateButton("RoleCheckButton", RaidUtilityPanel, nil, RaidUtilityPanel:GetWidth() * 0.8, TukuiDB.Scale(18), "TOP", DisbandRaidButton, "BOTTOM", 0, TukuiDB.Scale(-5), ROLE_POLL, nil)
RoleCheckButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		InitiateRolePoll()
	end
end)
 
--MainTank Button
CreateButton("MainTankButton", RaidUtilityPanel, "SecureActionButtonTemplate", (DisbandRaidButton:GetWidth() / 2) - TukuiDB.Scale(2), TukuiDB.Scale(18), "TOPLEFT", RoleCheckButton, "BOTTOMLEFT", 0, TukuiDB.Scale(-5), MAIN_TANK, nil)
MainTankButton:SetAttribute("type", "maintank")
MainTankButton:SetAttribute("unit", "target")
MainTankButton:SetAttribute("action", "set")
 
--MainAssist Button
CreateButton("MainAssistButton", RaidUtilityPanel, "SecureActionButtonTemplate", (DisbandRaidButton:GetWidth() / 2) - TukuiDB.Scale(2), TukuiDB.Scale(18), "TOPRIGHT", RoleCheckButton, "BOTTOMRIGHT", 0, TukuiDB.Scale(-5),MAIN_ASSIST, nil)
MainAssistButton:SetAttribute("type", "mainassist")
MainAssistButton:SetAttribute("unit", "target")
MainAssistButton:SetAttribute("action", "set")
 
--Ready Check button
CreateButton("ReadyCheckButton", RaidUtilityPanel, nil, RoleCheckButton:GetWidth() * 0.75, TukuiDB.Scale(18), "TOPLEFT", MainTankButton, "BOTTOMLEFT", 0, TukuiDB.Scale(-5), READY_CHECK, nil)
ReadyCheckButton:SetScript("OnMouseUp", function(self)
	if CheckRaidStatus() then
		DoReadyCheck()
	end
end)
 
--World Marker button
CreateButton("WorldMarkerButton", RaidUtilityPanel, "SecureHandlerClickTemplate", RoleCheckButton:GetWidth() * 0.2, TukuiDB.Scale(18), "TOPRIGHT", MainAssistButton, "BOTTOMRIGHT", 0, TukuiDB.Scale(-5), nil, "Interface\\RaidFrame\\Raid-WorldPing")
WorldMarkerButton:SetAttribute("_onclick", [=[
 if self:GetChildren():IsShown() then
	self:GetChildren():Hide()
 else
	self:GetChildren():Show()
 end
]=])
 
-- Marker Buttons
local function CreateMarkerButton(name, text, point, relativeto, point2)
	local f = CreateFrame("Button", name, MarkerFrame, "SecureActionButtonTemplate")
	f:SetPoint(point, relativeto, point2, 0, TukuiDB.Scale(-5))
	f:SetWidth(MarkerFrame:GetWidth())
	f:SetHeight((MarkerFrame:GetHeight() / 6) + TukuiDB.Scale(-5))
	f:SetFrameLevel(MarkerFrame:GetFrameLevel() + 1)
	f:SetHighlightTexture("Interface\\QuestFrame\\UI-QuestTitleHighlight")
 
	local t = f:CreateFontString(nil,"OVERLAY",f)
	t:SetFont(TukuiCF.media.font,12,"OUTLINE")
	t:SetText(text)
	t:SetPoint("CENTER")
	t:SetJustifyH("CENTER")	
 
	f:SetAttribute("type", "macro")
end
 
--Marker Holder Frame
local MarkerFrame = CreateFrame("Frame", "MarkerFrame", WorldMarkerButton)
TukuiDB.SetTemplate(MarkerFrame)
MarkerFrame:SetBackdropColor(r,g,b,0.6)
MarkerFrame:SetWidth(RaidUtilityPanel:GetWidth() * 0.4)
MarkerFrame:SetHeight(RaidUtilityPanel:GetHeight()* 1.2)
MarkerFrame:SetPoint("TOPLEFT", RaidUtilityPanel, "TOPRIGHT", TukuiDB.Scale(3), TukuiDB.Scale(0))
MarkerFrame:Hide()
 
--Setup Secure Buttons
CreateMarkerButton("BlueFlare", "|cff519AE8"..tukuilocal.core_raidutil_blue.."|r", "TOPLEFT", MarkerFrame, "TOPLEFT")
BlueFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button1
]])
CreateMarkerButton("GreenFlare", "|cff24B358"..tukuilocal.core_raidutil_green.."|r", "TOPLEFT", BlueFlare, "BOTTOMLEFT")
GreenFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button2
]])
CreateMarkerButton("PurpleFlare", "|cff852096"..tukuilocal.core_raidutil_purple.."|r", "TOPLEFT", GreenFlare, "BOTTOMLEFT")
PurpleFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button3
]])
CreateMarkerButton("RedFlare", "|cffD60629"..tukuilocal.core_raidutil_red.."|r", "TOPLEFT", PurpleFlare, "BOTTOMLEFT")
RedFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button4
]])
CreateMarkerButton("WhiteFlare", tukuilocal.core_raidutil_white, "TOPLEFT", RedFlare, "BOTTOMLEFT")
WhiteFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button5
]])
CreateMarkerButton("ClearFlare", tukuilocal.core_raidutil_clear, "TOPLEFT", WhiteFlare, "BOTTOMLEFT")
ClearFlare:SetAttribute("macrotext", [[
/click CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton
/click DropDownList1Button6
]])
MarkerFrame:SetHeight(MarkerFrame:GetHeight() + TukuiDB.Scale(4))


--------------------------------------------------------------------
-- Animation functions-------------------------------------------
--------------------------------------------------------------------

-- Set Anim func
local set_anim = function (self,k,x,y)
	self.anim = self:CreateAnimationGroup("Move_In")
	self.anim.in_a = self.anim:CreateAnimation("Translation")
	self.anim.in_a:SetDuration(0)
	self.anim.in_a:SetOrder(1)
	self.anim.in_b = self.anim:CreateAnimation("Translation")
	self.anim.in_b:SetDuration(.3)
	self.anim.in_b:SetOrder(2)
	self.anim.in_b:SetSmoothing("OUT")
	self.anim_o = self:CreateAnimationGroup("Move_Out")
	self.anim_o.b = self.anim_o:CreateAnimation("Translation")
	self.anim_o.b:SetDuration(.3)
	self.anim_o.b:SetOrder(1)
	self.anim_o.b:SetSmoothing("IN")
	self.anim.in_a:SetOffset(x,y)
	self.anim.in_b:SetOffset(-x,-y)
	self.anim_o.b:SetOffset(x,y)
	if k then self.anim_o:SetScript("OnFinished",function() self:Hide() end) end
end
if toplayout == true then
	set_anim(tmb_HiddenToggleButton,true, -100, 30)
	tmb_HiddenToggleButton:Hide()

	set_anim(MarkBarBackground,true, 100, 30)
	MarkBarBackground:Hide()

	set_anim(HiddenToggleButton,true, 100, 30)
	HiddenToggleButton:Hide()

	set_anim(HiddenToggleButton,true, 100, 30)
	RaidUtilityPanel:Hide()
	
else
	set_anim(tmb_HiddenToggleButton,true, 0, -60)

	set_anim(MarkBarBackground,true, 320, 0)
	MarkBarBackground:Hide()

	set_anim(HiddenToggleButton,true, 220, 0)
	HiddenToggleButton:Hide()

	set_anim(HiddenToggleButton,true, 220, 0)
	RaidUtilityPanel:Hide()
end

-- Set Scripts
tmb_HiddenToggleButton:SetScript("OnMouseUp",function()
	MarkBarBackground.anim_o:Stop()
	HiddenToggleButton.anim_o:Stop()
	MarkBarBackground:Show()
	HiddenToggleButton:Show()
	RaidUtilityPanel:Hide()
	HiddenToggleButton.anim:Play()
	MarkBarBackground.anim:Play()
	tmb_HiddenToggleButton.anim_o:Play()
end)
 
tmb_ShownToggleButton:SetScript("OnMouseUp",function()
	MarkBarBackground.anim:Stop()
	MarkBarBackground.anim_o:Play()
	RaidUtilityPanel:Hide()
	HiddenToggleButton.anim_o:Play()
	tmb_HiddenToggleButton:Show()
	tmb_HiddenToggleButton.anim:Play()
end)
