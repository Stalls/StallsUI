--------------------------------------------------------------------
-- FPS
--------------------------------------------------------------------

if TukuiCF["datatext"].fps_ms and TukuiCF["datatext"].fps_ms > 0 then
	local idealFPS = 60
	local badPing = 1000
	local Stat = CreateFrame("Frame")
	Stat:SetFrameStrata("BACKGROUND")
	Stat:SetFrameLevel(3)

	local Text  = PerformanceStatusBar:CreateFontString(nil, "OVERLAY")
	Text:SetFont(TukuiCF.media.pixelfont, TukuiCF["datatext"].fontsize, "MONOCHROMEOUTLINE")
	Text:SetHeight(PerformanceStatusBar:GetHeight())
	Text:SetPoint('TOP', PerformanceStatusBar)
	Text:SetPoint('BOTTOM', PerformanceStatusBar)
	
	local function colorize(value)
		value = min(1,max(0,value))
		if value < .5 then
			return 1,value/.5,0,1
		elseif value > .5 then
			return 1-(value-.5)/.5,1,0,1
		else
			return 1,1,0,1
		end
	end
	
	local cooldown = 1
	local perfProgBar = CreateFrame("StatusBar", "PerformanceProgressBar", PerformanceStatusBar)
	
	local function Update(self, elapsed)
		cooldown = cooldown - elapsed
		if cooldown < 0 then
			cooldown = 1
			local lat = select(3, GetNetStats())
			local fps = floor(GetFramerate())
			Text:SetText(lat..tukuilocal.datatext_ms..fps..tukuilocal.datatext_fps)
			
			local perfScore = (1 - (lat/badPing))*(fps/idealFPS)
			local perfProgBarWidth = floor(math.min(1,math.max(0,perfScore))*100)
			perfProgBar:SetStatusBarTexture(TukuiCF["media"].empath3)
			perfProgBar:SetStatusBarColor(colorize(perfScore))
			perfProgBar:SetBackdrop(backdrop)
			perfProgBar:SetBackdropColor(colorize(perfScore))
			perfProgBar:SetWidth(perfProgBarWidth -6)
			perfProgBar:SetHeight(PerformanceStatusBar:GetHeight() -4)
			perfProgBar:SetPoint("TOPLEFT", PerformanceStatusBar, TukuiDB.Scale(2), TukuiDB.Scale(-2))
			perfProgBar:SetFrameLevel(2)
		end
	end

	Stat:SetScript("OnUpdate", Update) 
	Update(Stat, 10)
end