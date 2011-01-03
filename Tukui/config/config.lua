﻿TukuiCF["general"] = {
	["autoscale"] = true,                  -- mainly enabled for users that don't want to mess with the config file
	["uiscale"] = 0.71,                    -- set your value (between 0.64 and 1) of your uiscale if autoscale is off
	["overridelowtohigh"] = false,         -- EXPERIMENTAL ONLY! override lower version to higher version on a lower reso.
	["multisampleprotect"] = true,         -- i don't recommend this because of shitty border but, voila! 
}

TukuiCF["unitframes"] = {
	-- general options
	["enable"] = true,                     -- do i really need to explain this?
	["enemyhcolor"] = false,               -- enemy target (players) color by hostility, very useful for healer.
	["unitcastbar"] = true,                -- enable tukui castbar
	["cblatency"] = true,                 -- enable castbar latency
	["cbicons"] = true,                    -- enable icons on castbar
	["auratimer"] = true,                  -- enable timers on buffs/debuffs
	["auratextscale"] = 11,                -- the font size of buffs/debuffs timers on unitframes
	["playerauras"] = false,               -- enable auras
	["targetauras"] = true,                -- enable auras on target unit frame
	["highThreshold"] = 80,                -- hunter high threshold
	["lowThreshold"] = 20,                 -- global low threshold, for low mana warning.
	["targetpowerpvponly"] = true,         -- enable power text on pvp target only
	["totdebuffs"] = false,                -- enable tot debuffs (high reso only)
	["focusdebuffs"] = false,              -- enable focus debuffs 
	["showfocustarget"] = false,           -- show focus target
	["showtotalhpmp"] = false,             -- change the display of info text on player and target with XXXX/Total.
	["showsmooth"] = true,                 -- enable smooth bar
	["showthreat"] = true,                 -- enable the threat bar anchored to info left panel.
	["charportrait"] = true,              -- do i really need to explain this?
	["maintank"] = true,  								-- enable maintank
	["mainassist"] = true,								-- enable mainassist
	["unicolor"] = true,                  -- enable unicolor theme
	["combatfeedback"] = true,             -- enable combattext on player and target.
	["playeraggro"] = true,                -- color player border to red if you have aggro on current target.
	["positionbychar"] = true,             -- save X, Y position with /uf (movable frame) per character instead of per account.
	["healcomm"] = false,                  -- enable healprediction support.

	-- raid layout
	["showrange"] = true,                  -- show range opacity on raidframes
	["raidalphaoor"] = 0.3,                -- alpha of unitframes when unit is out of range
	["gridonly"] = true,                  -- enable grid only mode for all healer mode raid layout.
	["showsymbols"] = true,	               -- show symbol.
	["aggro"] = true,                      -- show aggro on all raids layouts
	["raidunitdebuffwatch"] = true,        -- track important spell to watch in pve for grid mode.
	["gridhealthvertical"] = true,         -- enable vertical grow on health bar for grid mode.
	["showplayerinparty"] = true,         -- show my player frame in party
	["gridscale"] = 1,                     -- set the healing grid scaling
	
	-- boss frames
	["showboss"] = true,                   -- enable boss unit frames for PVELOL encounters.

	-- priest only plugin
	["ws_show_time"] = false,              -- show time on weakened soul bar
	["ws_show_player"] = true,             -- show weakened soul bar on player unit
	["ws_show_target"] = true,             -- show weakened soul bar on target unit
	
	-- death knight only plugin
	["runebar"] = true,                    -- enable tukui runebar plugin
	
	-- shaman only plugin
	["totemtimer"] = true,                 -- enable tukui totem timer plugin
}

TukuiCF["arena"] = {
	["unitframes"] = true,                 -- enable tukz arena unitframes (requirement : tukui unitframes enabled)
	["spelltracker"] = true,               -- enable tukz enemy spell tracker (an afflicted3 or interruptbar alternative)
}

TukuiCF["actionbar"] = {
	["enable"] = true,                     -- enable tukz action bars
	["hotkey"] = true,                     -- enable hotkey display because it was a lot requested
	["hideshapeshift"] = false,            -- hide shapeshift or totembar because it was a lot requested.
	["bottomrows"] = 2,                    -- numbers of row you want to show at the bottom (select between 1 and 2 only)
	["rightbars"] = 0,                     -- numbers of right bar you want
	["showgrid"] = true,                   -- show grid on empty button
}

TukuiCF["nameplate"] = {
	["enable"] = true,                     -- enable nice skinned nameplates that fit into tukui
		["showhealth"] = true,					-- show health text on nameplate
		["enhancethreat"] = true,				-- threat features based on if your a tank or not
		["overlap"] = false,				--allow nameplates to overlap
		["combat"] = false,					--only show enemy nameplates in-combat.
		["goodcolor"] = {0, 1, 0},			--good threat color (tank shows this with threat, everyone else without)
		["badcolor"] = {1, 0, 0},			--bad threat color (opposite of above)
		["transitioncolor"] = {242/255, 161/255, 10/255},	--threat color when gaining threat
}

TukuiCF["bags"] = {
	["enable"] = true,                     -- enable an all in one bag mod that fit tukui perfectly
}

TukuiCF["map"] = {
	["enable"] = true,                     -- reskin the map to fit tukui
}

TukuiCF["loot"] = {
	["lootframe"] = true,                  -- reskin the loot frame to fit tukui
	["rolllootframe"] = true,              -- reskin the roll frame to fit tukui
	["autogreed"] = true,                  -- auto-dez or auto-greed item at max level, auto-greed Frozen orb
}

TukuiCF["cooldown"] = {
	["enable"] = true,                     -- do i really need to explain this?
	["treshold"] = 8,                      -- show decimal under X seconds and text turn red
}

TukuiCF["datatext"] = {
	["fps_ms"] = 4,                        -- show fps and ms on panels
	["mem"] = 5,                           -- show total memory on panels
	["bags"] = 0,                          -- show space used in bags on panels
	["gold"] = 1,                          -- show your current gold on panels
	["wowtime"] = 4,                       -- show time on panels
	["guild"] = 2,                         -- show number on guildmate connected on panels
	["dur"] = 2,                           -- show your equipment durability on panels.
	["friends"] = 3,                       -- show number of friends connected.
	["dps_text"] = 6,                      -- show a dps meter on panels
	["hps_text"] = 0,                      -- show a heal meter on panels
	["power"] = 0,                         -- show your attackpower/spellpower/healpower/rangedattackpower whatever stat is higher gets displayed
	["haste"] = 0,                         -- show your haste rating on panels.
	["crit"] = 0,                          -- show your crit rating on panels.
	["avd"] = 0,                           -- show your current avoidance against the level of the mob your targeting
	["armor"] = 0,                         -- show your armor value against the level mob you are currently targeting
	["currency"] = 0,                      -- show your tracked currency on panels

	["battleground"] = true,               -- enable 3 stats in battleground only that replace stat1,stat2,stat3.
	["time24"] = false,                     -- set time to 24h format.
	["localtime"] = false,                 -- set time to local time instead of server time.
	["fontsize"] = 8,                     -- font size for panels.
}

TukuiCF["chat"] = {
	["enable"] = true,                     -- blah
	["whispersound"] = true,               -- play a sound when receiving whisper
}

TukuiCF["tooltip"] = {
	["enable"] = true,                     -- true to enable this mod, false to disable
	["hidecombat"] = false,                -- hide bottom-right tooltip when in combat
	["hidebuttons"] = false,               -- always hide action bar buttons tooltip.
	["hideuf"] = false,                    -- hide tooltip on unitframes
	["cursor"] = false,                    -- tooltip via cursor only
}

TukuiCF["merchant"] = {
	["sellgrays"] = true,                  -- automaticly sell grays?
	["autorepair"] = true,                 -- automaticly repair?
}

TukuiCF["error"] = {
	["enable"] = true,                     -- true to enable this mod, false to disable
	filter = {                             -- what messages to not hide
		["Inventory is full."] = true,     -- inventory is full will not be hidden by default
	},
}

TukuiCF["invite"] = { 
	["autoaccept"] = true,                 -- auto-accept invite from guildmate and friends.
}

TukuiCF["buffreminder"] = {
	["enable"] = true,                     -- this is now the new innerfire warning script for all armor/aspect class.
	["sound"] = true,                      -- enable warning sound notification for reminder.
}

TukuiCF["others"] = {
	["pvpautorelease"] = true,             -- enable auto-release in bg or wintergrasp. (not working for shaman, sorry)
	["showviewport"] = false,			   -- enable the top and bottom viewport bars
}

----------------------------------------------------------------------------
-- Per Class Config (overwrite general)
-- Class need to be UPPERCASE
----------------------------------------------------------------------------

if TukuiDB.myclass == "PRIEST" then
	-- do some config!
end

----------------------------------------------------------------------------
-- Per Character Name Config (overwrite general and class)
-- Name need to be case sensitive
----------------------------------------------------------------------------

if TukuiDB.myname == "Tukz" then
	-- yeah my default config is not really like default tukui.
	TukuiCF.actionbar.rightbars = 0
	TukuiCF.actionbar.bottomrows = 1
	TukuiCF.actionbar.hotkey = false
	TukuiCF.actionbar.hideshapeshift = true
	TukuiCF.others.pvpautorelease = true
	TukuiCF.unitframes.enemyhcolor = true
end





PlateBlacklist = {
	--Gundrak
	["Fanged Pit Viper"] = true,
	["Crafty Snake"] = true,

	--Shaman Totems
	["Earth Elemental Totem"] = true,
	["Fire Elemental Totem"] = true,
	["Fire Resistance Totem"] = true,
	["Flametongue Totem"] = true,
	["Frost Resistance Totem"] = true,
	["Healing Stream Totem"] = true,
	["Magma Totem"] = true,
	["Mana Spring Totem"] = true,
	["Nature Resistance Totem"] = true,
	["Searing Totem"] = true,
	["Stoneclaw Totem"] = true,
	["Stoneskin Totem"] = true,
	["Strength of Earth Totem"] = true,
	["Windfury Totem"] = true,
	["Totem of Wrath"] = true,
	["Wrath of Air Totem"] = true,

	--Army of the Dead
	["Army of the Dead Ghoul"] = true,

	--Hunter Trap
	["Venomous Snake"] = true,
	["Viper"] = true,

	--Test
	--["Unbound Seer"] = true,
}

MarkBarLocal = { }

MarkBarLocal.button_Disband =    "Disband Group"
MarkBarLocal.button_Clear =      "Clear Target"
MarkBarLocal.button_MarkBar = "Mark Bar"
MarkBarLocal.button_RaidUtility = "Raid Utility"