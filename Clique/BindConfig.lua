local addonName, addon = ...
local L = addon.L

local MAX_ROWS = 12

function CliqueConfig:OnShow()
    if not self.initialized then
        self:SetupGUI()
        self:HijackSpellbook()
        self.initialized = true
    end

    CliqueSpellTab:SetChecked(true)
    self:UpdateList()
    self:EnableSpellbookButtons()
end

function CliqueConfig:OnHide()
    CliqueSpellTab:SetChecked(false)
end

function CliqueConfig:SetupGUI()
    self.rows = {}
    for i = 1, MAX_ROWS do
        self.rows[i] = CreateFrame("Button", "CliqueRow" .. i, self.page1, "CliqueRowTemplate")
    end

    self.rows[1]:ClearAllPoints()
    self.rows[1]:SetPoint("TOPLEFT", "CliqueConfigPage1Column1", "BOTTOMLEFT", 0, -3)
    self.rows[1]:SetPoint("RIGHT", CliqueConfigPage1Column2, "RIGHT", 0, 0)

    for i = 2, MAX_ROWS do
        self.rows[i]:ClearAllPoints()
        self.rows[i]:SetPoint("TOPLEFT", self.rows[i - 1], "BOTTOMLEFT")
        self.rows[i]:SetPoint("RIGHT", CliqueConfigPage1Column2, "RIGHT", 0, 0)
    end

    _G[self:GetName() .. "TitleText"]:SetText(L["Clique Binding Configuration"])
    
    self.dialog = _G["CliqueDialog"]
    self.dialog.title = _G["CliqueDialogTitleText"]
    self.dialog:SetUserPlaced(false)
    self.dialog:ClearAllPoints()
    self.dialog:SetPoint("CENTER", self, "CENTER", 30, 0)

    self.dialog.title:SetText(L["Set binding"])
    self.dialog.button_accept:SetText(L["Accept"])

    self.dialog.button_binding:SetText(L["Set binding"])
    local desc = L["In order to specify a binding, move your mouse over the button labelled 'Set binding' and either click with your mouse or press a key on your keyboard. You can modify the binding by holding down a combination of the alt, control and shift keys on your keyboard."]
    self.dialog.desc:SetText(desc)

    self.page1.column1:SetText(L["Action"])
    self.page1.column2:SetText(L["Binding"])

    -- Set columns up to handle sorting
    self.page1.column1.sortType = "name"
    self.page1.column2.sortType = "key"
    self.page1.sortType = self.page1.column2.sortType

    self.page1.button_spell:SetText(L["Bind spell"])
    self.page1.button_other:SetText(L["Bind other"])
    self.page1.button_options:SetText(L["Options"])
  
    self.page2.button_binding:SetText(L["Set binding"])
    self.page2.button_save:SetText(L["Save"])
    self.page2.button_cancel:SetText(L["Cancel"])
    local desc = L["You can use this page to create a custom macro to be run when activating a binding on a unit. When creating this macro you should keep in mind that you will need to specify the target of any actions in the macro by using the 'mouseover' unit, which is the unit you are clicking on. For example, you can do any of the following:\n\n/cast [target=mouseover] Regrowth\n/cast [@mouseover] Regrowth\n/cast [@mouseovertarget] Taunt\n\nHover over the 'Set binding' button below and either click or press a key with any modifiers you would like included. Then edit the box below to contain the macro you would like to have run when this binding is activated."]
    
    self.page2.desc:SetText(desc)
    self.page2.editbox = CliqueScrollFrameEditBox

    self.page1:Show()
end

function CliqueConfig:Column_OnClick(frame, button)
    self.page1.sortType = frame.sortType
    self:UpdateList()
end

function CliqueConfig:HijackSpellbook()
    self.spellbookButtons = {}

    for idx = 1, 12 do
        local parent = getglobal("SpellButton" .. idx)
        local button = CreateFrame("Button", "CliqueSpellbookButton" .. idx, parent, "CliqueSpellbookButtonTemplate")
        button.spellbutton = parent
        button:EnableKeyboard(false)
        button:EnableMouseWheel(true)
        button:RegisterForClicks("AnyDown")
        button:SetID(parent:GetID())
        self.spellbookButtons[idx] = button
    end

    local function showHideHandler(frame)
        self:EnableSpellbookButtons()
    end
    SpellBookFrame:HookScript("OnShow", showHideHandler)
    SpellBookFrame:HookScript("OnHide", showHideHandler)

    -- TODO: This isn't a great way to do this, but for now
    hooksecurefunc("SpellBookSkillLineTab_OnClick", showHideHandler)
    self:EnableSpellbookButtons()
end

function CliqueConfig:EnableSpellbookButtons()
    local enabled;

    if self.page1:IsVisible() and SpellBookFrame:IsVisible() then
        enabled = true
    end

    if self.spellbookButtons then
        for idx, button in ipairs(self.spellbookButtons) do
            if enabled and button.spellbutton:IsEnabled() == 1 then
                button:Show()
            else
                button:Hide()
            end
        end
    end
end

-- Spellbook button functions
function CliqueConfig:Spellbook_EnableKeyboard(button, motion)
    button:EnableKeyboard(true)
end

function CliqueConfig:Spellbook_DisableKeyboard(button, motion)
    button:EnableKeyboard(false)
end

function CliqueConfig:Spellbook_OnBinding(button, key)
    if key == "ESCAPE" then
        HideUIPanel(CliqueConfig) 
        return
    end

    local slot = SpellBook_GetSpellBookSlot(button:GetParent());
    local name, subtype = GetSpellBookItemName(slot, SpellBookFrame.bookType)
    local texture = GetSpellBookItemTexture(slot, SpellBookFrame.bookType)
    
    local key = addon:GetCapturedKey(key)
    if not key then
        return
    end

    local succ, err = addon:AddBinding{
        key = key,
        type = "spell",
        spell = name,
        icon = texture
    }

    if not succ then
        CliqueConfig:SetNotification(err)
    else
        CliqueConfig:UpdateList()
    end
end

function CliqueConfig:Button_OnClick(button)
    -- Click handler for "Bind spell" button
    if button == self.page1.button_spell then
        if SpellBookFrame and not SpellBookFrame:IsVisible() then
            ShowUIPanel(SpellBookFrame)
        end

    -- Click handler for "Bind other" button
    elseif button == self.page1.button_other then
        local config = CliqueConfig
        local menu = {
            { 
                text = L["Select a binding type"], 
                isTitle = true,
                notCheckable = true,
            },
            { 
                text = L["Target clicked unit"],
                func = function()
                    self:SetupCaptureDialog("target")
                end,
                notCheckable = true,
            },
            {
                text = L["Open unit menu"],
                func = function()
                    self:SetupCaptureDialog("menu")
                end,
                notCheckable = true,
            },
            {
                text = L["Run custom macro"],
                func = function()
                    config.page1:Hide()
                    config.page2.bindType = "macro"
                    -- Clear out the entries
                    config.page2.bindText:SetText("")
                    config.page2.editbox:SetText("")
                    config.page2:Show()
                end,
                notCheckable = true,
            },
        }
        UIDropDownMenu_SetAnchor(self.dropdown, 0, 0, "BOTTOMLEFT", self.page1.button_other, "TOP")
        EasyMenu(menu, self.dropdown, nil, 0, 0, nil, nil) 

    -- Click handler for "Edit" button
    elseif button == self.page1.button_options then
        InterfaceOptionsFrame_OpenToCategory("Clique") 
    elseif button == self.page2.button_save then
        -- Check the input
        local key = self.page2.key
        local macrotext = self.page2.editbox:GetText()
        local succ, err = addon:AddBinding{
            key = key,
            type = "macro",
            macrotext = macrotext,
        }
        self:UpdateList()
        self.page2:Hide()
        self.page1:Show()
    elseif button == self.page2.button_cancel then
        self.page2:Hide()
        self.page1:Show()
    end
end

function CliqueConfig:SetNotification(text)
end

function CliqueConfig:ClearNotification()
end

local memoizeBindings = setmetatable({}, {__index = function(t, k, v)
    local binbits = addon:GetBinaryBindingKey(k)
    rawset(t, k, binbits)
    return binbits
end})

local compareFunctions;
compareFunctions = {
    name = function(a, b)
        local texta = addon:GetBindingActionText(a.type, a)
        local textb = addon:GetBindingActionText(b.type, b)
        if texta == textb then
            return compareFunctions.key(a, b)
        end
        return texta < textb
    end,
    key = function(a, b)
        local keya = addon:GetBindingKey(a)
        local keyb = addon:GetBindingKey(b)
        if keya == keyb then
            return memoizeBindings[a] < memoizeBindings[b]
        else
            return keya < keyb
        end
    end,
    binding = function(a, b)
        local mem = memoizeBindings
        return mem[a] < mem[b]
    end,
}

-- Mapping between binding entry and index in profile
function CliqueConfig:UpdateList()
    local page = self.page1
    local binds = addon.bindings

    -- GUI not created yet
    if not self.initialized then
        return
    end

    -- Sort the bindings
    local sort = {}
    for idx, entry in pairs(binds) do
        sort[#sort + 1] = entry
    end

    if page.sortType then
        table.sort(sort, compareFunctions[page.sortType]) 
    else
        table.sort(sort, compareFunctions.key)
    end

    -- Enable or disable the scroll bar
    if #sort > MAX_ROWS - 1 then
        -- Set up the scrollbar for the item list
        page.slider:SetMinMaxValues(0, #sort - MAX_ROWS)

        -- Adjust and show
        if not page.slider:IsShown() then
            -- Adjust column positions
            for idx, row in ipairs(self.rows) do
                row.bind:SetWidth(90)
            end
            page.slider:SetValue(0)
            page.slider:Show()
        end
    elseif page.slider:IsShown() then
        -- Move column positions back and hide the slider
        for idx, row in ipairs(self.rows) do
            row.bind:SetWidth(105)
        end
        page.slider:Hide()
    end

    -- Update the rows in the list
    local offset = page.slider:GetValue() or 0
    for idx, row in ipairs(self.rows) do
        local offsetIndex = offset + idx
        if sort[offsetIndex] then
            local bind = sort[offsetIndex]
            row.icon:SetTexture(addon:GetBindingIcon(bind))
            row.name:SetText(addon:GetBindingActionText(bind.type, bind))
            row.info:SetText(addon:GetBindingInfoText(bind))
            row.bind:SetText(addon:GetBindingKeyComboText(bind))
            row.binding = bind 
            row:Show()
        else 
            row:Hide()
        end
    end
end

function CliqueConfig:ClearEditPage()
end

function CliqueConfig:ShowEditPage()
    self:ClearEditPage()
    self.page1:Hide()
    self.page3:Show()
end

function CliqueConfig:Save_OnClick(button, down)
end

function CliqueConfig:Cancel_OnClick(button, down)
    self:ClearEditPage()
    self.page3:Hide()
    self.page1:Show()
end

function CliqueConfig:SetupCaptureDialog(type, binding)
    self.dialog.bindType = type
    self.dialog.binding = binding

    if not binding then
        local actionText = addon:GetBindingActionText(type, binding)
        self.dialog.title:SetText(L["Set binding: %s"]:format(actionText))
    else
        -- This is a change to an existing binding
        local actionText = addon:GetBindingActionText(type, binding)
        self.dialog.title:SetText(L["Change binding: %s"]:format(actionText))
    end

    self.dialog.bindText:SetText("")
    self.dialog:Show()
end

function CliqueConfig:BindingButton_OnClick(button, key)
    local dialog = CliqueDialog
    dialog.key = addon:GetCapturedKey(key)
    if dialog.key then
        CliqueDialog.bindText:SetText(addon:GetBindingKeyComboText(dialog.key))
    end
end

function CliqueConfig:MacroBindingButton_OnClick(button, key)
    local key = addon:GetCapturedKey(key)
    if key then
        self.page2.key = key 
        self.page2.bindText:SetText(addon:GetBindingKeyComboText(key))
    end
end

function CliqueConfig:AcceptSetBinding()
    local dialog = CliqueDialog
    local key = dialog.key

    if dialog.binding then
        -- This was a CHANGE binding instead of a SET binding
        dialog.binding.key = key
        dialog.binding = nil
        self:UpdateList()
    else
        local succ, err = addon:AddBinding{
            key = key,
            type = dialog.bindType,
        }
        if succ then
            self:UpdateList()
        end
    end
    dialog:Hide()
end

local function toggleSet(binding, set)
    return function()
        if not binding.sets then
            binding.sets = {}
        end
        if binding.sets[set] then
            binding.sets[set] = nil
        else
            binding.sets[set] = true
        end
        addon:UpdateAttributes()
        CliqueConfig:UpdateList()
    end
end

function CliqueConfig:Row_OnClick(frame, button)
    local binding = frame.binding
    local actionText = addon:GetBindingActionText(binding.type, binding)

    local menu = {
        {
            text = L["Configure binding: '%s'"]:format(actionText),
            notCheckable = true,
            isTitle = true,
        },
        { 
            text = L["Change binding"],
            func = function()
                local binding = frame.binding
                self:SetupCaptureDialog(binding.type, binding)
            end,
            notCheckable = true,
        },
        {
            text = L["Delete binding"],
            func = function()
                addon:DeleteBinding(frame.binding)
                self:UpdateList()
            end,
            notCheckable = true,
        },
    }

    local submenu = {
        text = L["Enable/Disable click-sets"],
        hasArrow = true,
        notCheckable = true,
        menuList = {},
    }
    table.insert(menu, submenu)
 
    table.insert(submenu.menuList, {
        text = L["Default"],
        checked = function() return binding.sets["default"] end,
        func = toggleSet(binding, "default"),
        tooltipTitle = L["Clique: 'default' click-set"],
        tooltipText = L["A binding that belongs to the 'default' click-set will always be active on your unit frames, unless you override it with another binding."],
        keepShownOnClick = true,
    })

    table.insert(submenu.menuList, {
        text = L["Friend"],
        checked = function() return binding.sets["friend"] end,
        func = toggleSet(binding, "friend"),
        tooltipTitle = L["Clique: 'friend' click-set"],
        tooltipText = L["A binding that belongs to the 'frield' click-set will only be active when clicking on unit frames that display friendly units, i.e. those you can heal and assist. If you click on a unit that you cannot heal or assist, nothing will happen."],
        keepShownOnClick = true,
    })

    table.insert(submenu.menuList, {
        text = L["Enemy"],
        checked = function() return binding.sets["enemy"] end,
        func = toggleSet(binding, "enemy"),
        tooltipTitle = L["Clique: 'enemy' click-set"],
        tooltipText = L["A binding that belongs to the 'enemy' click-set will always be active when clicking on unit frames that display enemy units, i.e. those you can attack. If you click on a unit that you cannot attack, nothing will happen."],
        keepShownOnClick = true,
    })

    table.insert(submenu.menuList, {
        text = L["Out-of-combat only"],
        checked = function() return binding.sets["ooc"] end,
        func = toggleSet(binding, "ooc"),
        tooltipTitle = L["Clique: 'ooc' click-set"],
        tooltipText = L["A binding that belongs to the 'ooc' click-set will only be active when the player is out-of-combat. As soon as the player enters combat, these bindings will no longer be active, so be careful when choosing this click-set for any spells you use frequently."],
        keepShownOnClick = true,
    })

    table.insert(submenu.menuList, {
        text = L["Global bindings"],
        checked = function() return binding.sets["global"] end,
        func = toggleSet(binding, "global"),
        tooltipTitle = L["Clique: 'global' click-set"],
        tooltipText = L["A binding that belongs to the 'global' click-set is always active, regardless of whether the mouse is over a unit frame or not. This click-set allows you to bind spells to keys that can then be used over the 3-D game world, to enable 'hovercasting', where you hover over a unit in the world and press a key to cast a spell on them. These bindings are also active over unit frames."],
        keepShownOnClick = true,
    })
    
    EasyMenu(menu, self.dropdown, "cursor", 0, 0, nil, nil)
end

