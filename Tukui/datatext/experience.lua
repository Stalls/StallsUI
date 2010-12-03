local Stat = CreateFrame("Frame")
ExperienceStatusBar:EnableMouse(true)
Stat:SetFrameStrata("BACKGROUND")
Stat:SetFrameLevel(1)

local Text = ExperienceStatusBar:CreateFontString(nil, "OVERLAY")
Text:SetFont(TukuiCF.media.pixelfont, TukuiCF["datatext"].fontsize, "MONOCHROMEOUTLINE")
Text:SetHeight(ExperienceStatusBar:GetHeight())
Text:SetPoint('TOP', ExperienceStatusBar)
Text:SetPoint('BOTTOM', ExperienceStatusBar)
local expProgBar = CreateFrame("StatusBar", "ExperienceProgressBar", ExperienceStatusBar)

local function Update(self)
	local backdrop = {
		bgFile = TukuiCF["media"].blank,
		insets = {top = -TukuiDB.mult, left = -TukuiDB.mult, bottom = -TukuiDB.mult, right = -TukuiDB.mult},
	}
	
	if TukuiDB.level ~= MAX_PLAYER_LEVEL then
		local playerXP = UnitXP("player")
		local levelXP = UnitXPMax("player")
		local levelPerc = floor((playerXP / levelXP)*100)
		
		Text:SetText(playerXP.." / "..levelXP.." ("..levelPerc.."%)")
		self:SetAllPoints(text)
		
		local expProgBarWidth = floor((ExperienceStatusBar:GetWidth() * (levelPerc / 100)))
		expProgBar:SetStatusBarTexture(TukuiCF["media"].empath3)
		expProgBar:SetStatusBarColor(0, 0.4, 1, .8)
		expProgBar:SetBackdrop(backdrop)
		expProgBar:SetBackdropColor(0, 0.4, 1, .8)
		expProgBar:SetWidth(expProgBarWidth -6)
		expProgBar:SetHeight(ExperienceStatusBar:GetHeight() - TukuiDB.Scale(6))
		expProgBar:SetPoint("TOPLEFT", ExperienceStatusBar, TukuiDB.Scale(3), TukuiDB.Scale(-3))
		expProgBar:SetFrameLevel(2)
	else
		local COLORS = {
			[1] = {r = 0.55, g = 0, b = 0},			-- hated
			[2] = {r = 1, g = 0, b = 0},			-- hostile
			[3] = {r = 1, g = 0.55, b = 0},			-- unfriendly
			[4] = {r = 0.75, g = 0.75, b = 0.75},	-- neutral
			[5] = {r = 1, g = 1, b = 1},			-- friendly
			[6] = {r = 0, g = 1, b = 0},			-- honored
			[7] = {r = 0.25, g = 0.4, b = 0.9},		-- reverted
			[8] = {r = 0.6, g = 0.2, b = 0.8},		-- exalted
		}
		
		local name, standing, minRep, maxRep, currRep = GetWatchedFactionInfo()
		
		if not name then
			Text:SetText("No Faction Watched")
		else
			currRep = currRep - minRep;
			maxRep = maxRep - minRep;
			local color = COLORS[standing]
			ExperienceStatusBar:SetWidth(160)
			Text:SetText(name)
			local expProgBarWidth = floor((ExperienceStatusBar:GetWidth() * (currRep / maxRep)))
			
			expProgBar:SetStatusBarTexture(TukuiCF["media"].empath3)
			expProgBar:SetStatusBarColor(color.r, color.g, color.b, .8)
			expProgBar:SetBackdrop(backdrop)
			expProgBar:SetBackdropColor(color.r, color.g, color.b, .8)
			expProgBar:SetWidth(expProgBarWidth -6)
			expProgBar:SetHeight(ExperienceStatusBar:GetHeight() - TukuiDB.Scale(6))
			expProgBar:SetPoint("TOPLEFT", ExperienceStatusBar, TukuiDB.Scale(3), TukuiDB.Scale(-3))
			expProgBar:SetFrameLevel(2)
		end
	end
end

Stat:RegisterEvent('UPDATE_FACTION')
Stat:RegisterEvent("PLAYER_XP_UPDATE")
Stat:RegisterEvent("PLAYER_LEVEL_UP")
Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
if TukuiDB.level ~= MAX_PLAYER_LEVEL then
	ExperienceStatusBar:SetScript("OnMouseDown", function() if not PlayerTalentFrame then LoadAddOn("Blizzard_TalentUI") end PlayerTalentFrame_Toggle() end)
else
	ExperienceStatusBar:SetScript("OnMouseDown", function() ToggleCharacter("ReputationFrame") end)
end
Stat:SetScript("OnEvent", Update)
ExperienceStatusBar:SetScript("OnEnter", function(self)
	if not InCombatLockdown() then
		GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, TukuiDB.Scale(-3))
		GameTooltip:ClearAllPoints()
		GameTooltip:SetPoint("TOP", self, "BOTTOM", 0, TukuiDB.mult)
		GameTooltip:ClearLines()
		GameTooltip:AddLine("XP: "..UnitXP("player").." / "..UnitXPMax("player").." ("..floor((UnitXP("player") / UnitXPMax("player"))*100).."%)")
		GameTooltip:AddLine("Remaining: "..(UnitXPMax("player") - UnitXP("player")).." (".. 100 - floor((UnitXP("player") / UnitXPMax("player"))*100).."%)")
		GameTooltip:Show()
	end
end)
ExperienceStatusBar:SetScript("OnLeave", function() GameTooltip:Hide() end)