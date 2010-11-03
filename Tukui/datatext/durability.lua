--------------------------------------------------------------------
-- DURABILITY
--------------------------------------------------------------------
	
if TukuiCF["datatext"].dur and TukuiCF["datatext"].dur > 0 then
	local Stat = CreateFrame("Frame")
	Stat:EnableMouse(true)
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = DurabilityStatusBar:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.pixelfont, TukuiCF["datatext"].fontsize, "MONOCHROMEOUTLINE")
	Text:SetHeight(DurabilityStatusBar:GetHeight())
	Text:SetPoint('TOP', DurabilityStatusBar)
	Text:SetPoint('BOTTOM', DurabilityStatusBar)

	local Total = 0
	local current, max
	local durProgBar = CreateFrame("StatusBar", "DurabilityProgressBar", DurabilityStatusBar)
	
	local function OnEvent(self)
		for i = 1, 11 do
			if GetInventoryItemLink("player", tukuilocal.Slots[i][1]) ~= nil then
				current, max = GetInventoryItemDurability(tukuilocal.Slots[i][1])
				if current then 
					tukuilocal.Slots[i][3] = current/max
					Total = Total + 1
				end
			end
		end
		table.sort(tukuilocal.Slots, function(a, b) return a[3] < b[3] end)
		
		if Total > 0 then
			Text:SetText(floor(tukuilocal.Slots[1][3]*100).."% "..tukuilocal.datatext_armor)
		else
			Text:SetText("100% "..tukuilocal.datatext_armor)
		end
		
		local backdrop = {
			bgFile = TukuiCF["media"].blank,
			insets = {top = -TukuiDB.mult, left = -TukuiDB.mult, bottom = -TukuiDB.mult, right = -TukuiDB.mult},
		}
		green = tukuilocal.Slots[1][3]*2
		red = 1 - green
		local durProgBarWidth = floor((DurabilityStatusBar:GetWidth() * (floor(tukuilocal.Slots[1][3]*100) / 100)))
		durProgBar:SetStatusBarTexture(TukuiCF["media"].empath3)
		durProgBar:SetStatusBarColor(red + 1, green, 0, .8)
		durProgBar:SetBackdrop(backdrop)
		durProgBar:SetBackdropColor(red + 1, green, 0, .8)
		durProgBar:SetWidth(durProgBarWidth -6)
		durProgBar:SetHeight(DurabilityStatusBar:GetHeight() - TukuiDB.Scale(6))
		durProgBar:SetPoint("TOPLEFT", DurabilityStatusBar, TukuiDB.Scale(3), TukuiDB.Scale(-3))
		durProgBar:SetFrameLevel(2)
		-- Setup Durability Tooltip
		self:SetAllPoints(Text)
		Total = 0
	end

	Stat:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
	Stat:RegisterEvent("MERCHANT_SHOW")
	Stat:RegisterEvent("PLAYER_ENTERING_WORLD")
	Stat:SetScript("OnMouseDown", function() ToggleCharacter("PaperDollFrame") end)
	Stat:SetScript("OnEvent", OnEvent)
	Stat:SetScript("OnEnter", function(self)
		if not InCombatLockdown() then
			GameTooltip:SetOwner(self, "ANCHOR_BOTTOM", 0, TukuiDB.Scale(-3));
			GameTooltip:ClearAllPoints()
			GameTooltip:SetPoint("BOTTOM", self, "TOP", 0, TukuiDB.mult)
			GameTooltip:ClearLines()
			for i = 1, 11 do
				if tukuilocal.Slots[i][3] ~= 1000 then
					green = tukuilocal.Slots[i][3]*2
					red = 1 - green
					GameTooltip:AddDoubleLine(tukuilocal.Slots[i][2], floor(tukuilocal.Slots[i][3]*100).."%",1 ,1 , 1, red + 1, green, 0)
				end
			end
			GameTooltip:Show()
		end
	end)
	Stat:SetScript("OnLeave", function() GameTooltip:Hide() end)
end