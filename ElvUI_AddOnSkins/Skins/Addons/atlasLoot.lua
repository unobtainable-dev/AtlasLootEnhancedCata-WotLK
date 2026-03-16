local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("AtlasLoot") then return end

local select = select
local unpack = unpack

S:AddCallbackForAddon("AtlasLoot", "AtlasLoot", function()
    -- Fix for Error 1: Ensure the private table exists before indexing
    if E.private.addOnSkins and E.private.addOnSkins.AtlasLoot == false then return end

    AtlasLootTooltip:HookScript("OnShow", function(self)
        self:SetTemplate("Transparent", nil, true)
        local r, g, b = self:GetBackdropColor()
        self:SetBackdropColor(r, g, b, E.db.tooltip.colorAlpha)
        local iLink = select(2, self:GetItem())
        local quality = iLink and select(3, GetItemInfo(iLink))
        if quality and quality >= 2 then
            self:SetBackdropBorderColor(GetItemQualityColor(quality))
        else
            self:SetBackdropBorderColor(unpack(E.media.bordercolor))
        end
    end)

    if AtlasLootPanel then AtlasLootPanel:StripTextures(); AtlasLootPanel:SetTemplate("Transparent") end
    if AtlasLootDefaultFrame then AtlasLootDefaultFrame:StripTextures(); AtlasLootDefaultFrame:SetTemplate("Transparent") end
    if DropDownList1 then DropDownList1:SetTemplate() end

    -- Fix for Error 4: Added existence checks for dynamic frames
    if AtlasLootDefaultFrame_ModuleSelect then
        AtlasLootDefaultFrame_ModuleSelect:StripTextures()
        S:HandleDropDownBox(AtlasLootDefaultFrame_ModuleSelect, 240)
        AtlasLootDefaultFrame_ModuleSelect:Point("TOPLEFT", 10, -50)
        if AtlasLootDefaultFrame_ModuleSelectText then AtlasLootDefaultFrame_ModuleSelectText:SetJustifyH("LEFT") end
    end

    if AtlasLootDefaultFrame_InstanceSelect then
        AtlasLootDefaultFrame_InstanceSelect:StripTextures()
        S:HandleDropDownBox(AtlasLootDefaultFrame_InstanceSelect, 240)
        AtlasLootDefaultFrame_InstanceSelect:Point("TOPLEFT", 280, -50)
        if AtlasLootDefaultFrame_InstanceSelectText then AtlasLootDefaultFrame_InstanceSelectText:SetJustifyH("RIGHT") end
    end

    if AtlasLootDefaultFrame_ModuleSelectButton then S:HandleNextPrevButton(AtlasLootDefaultFrame_ModuleSelectButton); AtlasLootDefaultFrame_ModuleSelectButton:Height(24) end
    if AtlasLootDefaultFrame_InstanceSelectButton then S:HandleNextPrevButton(AtlasLootDefaultFrame_InstanceSelectButton); AtlasLootDefaultFrame_InstanceSelectButton:Height(24) end
    if AtlasLoot_AtlasInfoFrame_ToggleALButton then S:HandleButton(AtlasLoot_AtlasInfoFrame_ToggleALButton) end
	
    --S:HandleButton(AtlasLootDefaultFrame_CompareFrame)
    S:HandleButton(AtlasLoot10Man25ManSwitch)
    S:HandleButton(AtlasLootServerQueryButton)
    S:HandleCheckBox(AtlasLootItemsFrame_Heroic)
    S:HandleNextPrevButton(AtlasLootQuickLooksButton)
    S:HandleNextPrevButton(AtlasLootItemsFrame_PREV)
    S:HandleNextPrevButton(AtlasLootItemsFrame_NEXT)
	S:HandleCloseButton(AtlasLootDefaultFrame_CloseButton)
-- Line 57: Manual lock button skin and state sync
local lockBtn = AtlasLootDefaultFrame_LockButton
if lockBtn then
    lockBtn:ClearAllPoints()
    lockBtn:SetPoint("RIGHT", AtlasLootDefaultFrame_CloseButton, "LEFT", 12, -1)
    lockBtn:SetSize(32, 32)
    lockBtn:StripTextures(false)

    local function SyncLockState()
        -- Access the module's profile directly to find the true lock state
        local mod = AtlasLoot:GetModule("DefaultFrame")
        if not mod or not mod.db or not mod.db.profile then return end
        
        local isLocked = mod.db.profile.DefaultFrameLocked
        local state = isLocked and "Locked" or "Unlocked"
        local path = "Interface\\AddOns\\AtlasLoot\\Images\\AtlasImages\\Elvui-LockButton-"
        
        -- Force the correct texture and coordinates
        lockBtn:SetNormalTexture(path..state.."-Up")
        lockBtn:SetPushedTexture(path..state.."-Down")
        
        local norm = lockBtn:GetNormalTexture()
        local push = lockBtn:GetPushedTexture()
        if norm then norm:SetTexCoord(0, 1, 0, 1); norm:SetAllPoints(lockBtn) end
        if push then push:SetTexCoord(0, 1, 0, 1); push:SetAllPoints(lockBtn) end
    end

    -- Hook OnShow (Fixes 'drag to show') and OnClick (Fixes 'state sync')
    -- We use a 0.01 delay to ensure the addon finishes its internal logic first
    lockBtn:HookScript("OnShow", function() E:Delay(0.01, SyncLockState) end)
    lockBtn:HookScript("OnClick", function() E:Delay(0.01, SyncLockState) end)
    
    SyncLockState()
end

    AtlasLoot_AtlasInfoFrame_ToggleALButton:Point("TOPRIGHT", -46, -11)
    
    AtlasLoot10Man25ManSwitch:Height(24)
    AtlasLootServerQueryButton:Height(24)
    AtlasLootItemsFrame_BACK:Height(24)
	S:HandleButton(AtlasLootItemsFrame_BACK)

    AtlasLoot10Man25ManSwitch:Point("BOTTOM", -130, 3)
    AtlasLootServerQueryButton:Point("BOTTOM", 131, 3)
    AtlasLootItemsFrame_BACK:Point("BOTTOM", 0, 3)
	AtlasLootItemsFrame_Heroic:Point("BOTTOM", -220, 28)
	
	if AtlasLootFilterCheck then
        S:HandleCheckBox(AtlasLootFilterCheck)
    end
    
    AtlasLootQuickLooksButton:Point("BOTTOM", 58, 32)

    AtlasLootItemsFrame_PREV:Point("BOTTOMLEFT", 7, 6)
    AtlasLootItemsFrame_NEXT:Point("BOTTOMRIGHT", -6, 6)
    
-- Line 133: Enhanced Panel & Filter Skinning
local function SkinAtlasPanel()
    -- Skin the main 18 Panel Buttons
    for i = 1, 18 do
        local btn = _G["AtlasLoot_PanelButton_"..i]
        if btn and not btn.isSkinned then
            S:HandleButton(btn)
            -- Anchor logic for the first row
            if i == 1 then
                btn:Point("LEFT", AtlasLootPanel, "LEFT", 7, 29)
            elseif i <= 6 then
                local prev = _G["AtlasLoot_PanelButton_"..(i-1)]
                if prev then btn:Point("LEFT", prev, "RIGHT", 2, 0) end
            end
            btn.isSkinned = true
        end
    end

    -- Fix the Filter Checkbox (specifically handled for dynamic toggle)
    if AtlasLootFilterCheck and not AtlasLootFilterCheck.isSkinned then
        S:HandleCheckBox(AtlasLootFilterCheck)
        AtlasLootFilterCheck.isSkinned = true
    end

    -- Skin Search UI elements
    local searchElements = {
        AtlasLootPanelSearch_Box,
        AtlasLootPanelSearch_SearchButton,
        AtlasLootPanelSearch_SelectModule,
        AtlasLootPanelSearch_ClearButton,
        AtlasLootPanelSearch_LastResultButton
    }

    for _, obj in pairs(searchElements) do
        if obj and not obj.isSkinned then
            if obj == AtlasLootPanelSearch_Box then
                S:HandleEditBox(obj)
            elseif obj == AtlasLootPanelSearch_SelectModule then
                S:HandleNextPrevButton(obj)
            else
                S:HandleButton(obj)
                obj:Height(22)
            end
            obj.isSkinned = true
        end
    end
end

-- Apply skinning immediately and hook into all possible refresh events
SkinAtlasPanel()
if AtlasLootPanel then
    AtlasLootPanel:HookScript("OnShow", function() SkinAtlasPanel() end)
end

-- Hook the internal AtlasLoot function that refreshes the panel layout
hooksecurefunc(AtlasLoot, "SetItemInfoFrame", function()
    E:Delay(0.01, SkinAtlasPanel)
end)

-- Specific hook for the Wishlist and Options toggle refresh
local DF = AtlasLoot:GetModule("DefaultFrame", true)
if DF and DF.UpdatePanel then
    hooksecurefunc(DF, "UpdatePanel", function()
        E:Delay(0.01, SkinAtlasPanel)
    end)
end

local function SkinAtlasLootCompareFrame()
    if not AtlasLootCompareFrame or AtlasLootCompareFrame.isSkinned then return end

    -- Main Frame
    AtlasLootCompareFrame:StripTextures()
    AtlasLootCompareFrame:SetTemplate("Transparent")

    if AtlasLootCompareFrame_ScrollFrameItemFrame then
        AtlasLootCompareFrame_ScrollFrameItemFrame:StripTextures()
    end

    if AtlasLootCompareFrame_ScrollFrameMainFilter then
        AtlasLootCompareFrame_ScrollFrameMainFilter:StripTextures()
    end

    -- Main Filter Buttons (1–15)
    for i = 1, 15 do
        local btn = _G["AtlasLootCompareFrameMainFilterButton"..i]
        if btn then
            btn:StripTextures()
        end
    end

    -- Item Boxes (1–8)
    for i = 1, 8 do
        local item = _G["AtlasLootCompareFrame_ScrollFrameItemFrame_Item"..i]
        if item then
            item:SetTemplate()
        end
    end

    -- Search Box
    if AtlasLootCompareFrameSearch_Box then
        S:HandleEditBox(AtlasLootCompareFrameSearch_Box)
        AtlasLootCompareFrameSearch_Box:Height(22)
    end

    -- Buttons
    local buttons = {
        "AtlasLootCompareFrameSearch_SearchButton",
        "AtlasLootCompareFrameSearch_ClearButton",
        "AtlasLootCompareFrameSortButton_Name",
        "AtlasLootCompareFrameSortButton_Rarity",
        "AtlasLootCompareFrameSortButton_1",
        "AtlasLootCompareFrameSortButton_2",
        "AtlasLootCompareFrameSortButton_3",
        "AtlasLootCompareFrameSortButton_4",
        "AtlasLootCompareFrameSortButton_5",
        "AtlasLootCompareFrameSortButton_6",
        "AtlasLootCompareFrameSortButton_7",
        "AtlasLootCompareFrameSortButton_8",
        "AtlasLootCompareFrameSortButton_9",
        "AtlasLootCompareFrame_WishlistButton",
        "AtlasLootCompareFrame_CloseButton2",
    }

    for _, name in pairs(buttons) do
        local btn = _G[name]
        if btn then
            S:HandleButton(btn)
        end
    end

    -- Close Button
    if AtlasLootCompareFrame_CloseButton then
        S:HandleCloseButton(AtlasLootCompareFrame_CloseButton)
    end

    -- Dropdown
    if AtlasLootCompareFrameSearch_StatsListDropDown then
        AtlasLootCompareFrameSearch_StatsListDropDown:StripTextures()
        S:HandleDropDownBox(AtlasLootCompareFrameSearch_StatsListDropDown, 225)
    end

    if AtlasLootCompareFrameSearch_StatsListDropDownButton then
        S:HandleNextPrevButton(AtlasLootCompareFrameSearch_StatsListDropDownButton)
    end

    -- Scrollbars
    if AtlasLootCompareFrame_ScrollFrameMainFilterScrollBar then
        S:HandleScrollBar(AtlasLootCompareFrame_ScrollFrameMainFilterScrollBar)
    end

    if AtlasLootCompareFrame_ScrollFrameItemFrameScrollBar then
        S:HandleScrollBar(AtlasLootCompareFrame_ScrollFrameItemFrameScrollBar)
    end

    if AtlasLootCompareFrame_ScrollFrameItemFrameScrollBarScrollUpButton then
        S:HandleNextPrevButton(AtlasLootCompareFrame_ScrollFrameItemFrameScrollBarScrollUpButton)
    end

    if AtlasLootCompareFrame_ScrollFrameItemFrameScrollBarScrollDownButton then
        S:HandleNextPrevButton(AtlasLootCompareFrame_ScrollFrameItemFrameScrollBarScrollDownButton)
    end
	
	if AtlasLootCompareFrameSearch_FilterCheck then
		S:HandleCheckBox(AtlasLootCompareFrameSearch_FilterCheck)
	end

	-- Fix Search Button position
if AtlasLootCompareFrameSearch_SearchButton and AtlasLootCompareFrameSearch_Box then
    AtlasLootCompareFrameSearch_SearchButton:ClearAllPoints()
    AtlasLootCompareFrameSearch_SearchButton:SetPoint(
        "LEFT",
        AtlasLootCompareFrameSearch_Box,
        "RIGHT",
        10, 0
    )
end

-- Fix SelectModule (was not skinned)
if AtlasLootCompareFrameSearch_SelectModuel then
    S:HandleNextPrevButton(AtlasLootCompareFrameSearch_SelectModuel)

    AtlasLootCompareFrameSearch_SelectModuel:ClearAllPoints()
    AtlasLootCompareFrameSearch_SelectModuel:SetPoint(
        "LEFT",
        AtlasLootCompareFrameSearch_SearchButton,
        "RIGHT",
        3, 0
    )
end

-- Fix Clear Button (move down 5px safely)
if AtlasLootCompareFrameSearch_ClearButton then
    AtlasLootCompareFrameSearch_ClearButton:ClearAllPoints()
    AtlasLootCompareFrameSearch_ClearButton:SetPoint(
        "LEFT",
        AtlasLootCompareFrameSearch_SelectModuel,
        "RIGHT",
        -250, -25
    )
end	

if AtlasLootCompareFrame_CloseButton2 then
	AtlasLootCompareFrame_CloseButton2:ClearAllPoints()
	AtlasLootCompareFrame_CloseButton2:SetPoint(
		"BOTTOM",
		AtlasLootCompareFrame_ScrollFrameItemFrameScrollBarScrollDownButton,
		"BOTTOM",
		-25, -25
	)
end

	
    AtlasLootCompareFrame.isSkinned = true
end

if AtlasLootCompareFrame then
    AtlasLootCompareFrame:HookScript("OnShow", SkinAtlasLootCompareFrame)
end
  	
	
-- Line 282: Binary Border Logic (Red = Query, Quality = Loaded, Hidden = Empty)
local function UpdateItemBorder(btn)
    if not btn or not btn.Frame or not btn.Frame.Icon then return end
    
    local icon = btn.Frame.Icon
    local texture = icon:GetTexture()
    
    -- 1. Create backdrop once
    if not icon.backdrop then
        local bg = CreateFrame("Frame", nil, btn.Frame)
        bg:SetTemplate("Default")
        bg:SetOutside(icon)
        icon.backdrop = bg
        icon:SetParent(bg)
        icon:SetDrawLayer("OVERLAY")
    end

    -- 2. Placeholder Check: If texture is empty or specifically a blank string, hide it
    if not texture or texture == "" or texture == 0 then
        icon.backdrop:Hide()
        return
    end

    -- 3. Show and Zoom for real icons
    icon.backdrop:Show()
    icon:SetTexCoord(0.07, 0.93, 0.07, 0.93)

    -- 4. Color Logic
    local itemID = btn.itemID or (btn.info and btn.info[2])
    local isQuerying = btn.Frame.QueryIcon and btn.Frame.QueryIcon:IsShown()
    local itemName = itemID and type(itemID) == "number" and itemID > 0 and GetItemInfo(itemID)

    if isQuerying or (itemID and itemID > 0 and not itemName) then
        icon.backdrop:SetBackdropBorderColor(1, 0, 0) -- Red: Querying/Unavailable
    else
        local quality = itemID and type(itemID) == "number" and select(3, GetItemInfo(itemID))
        if quality and quality >= 2 then
            icon.backdrop:SetBackdropBorderColor(GetItemQualityColor(quality))
        else
            icon.backdrop:SetBackdropBorderColor(unpack(E.media.bordercolor))
        end
    end
end

-- Hook SetItemTable for initial draws and real-time updates
hooksecurefunc(AtlasLoot, "SetItemTable", function()
    if not AtlasLoot.ItemFrame or not AtlasLoot.ItemFrame.ItemButtons then return end
    for i = 1, #AtlasLoot.ItemFrame.ItemButtons do
        local btn = AtlasLoot.ItemFrame.ItemButtons[i]
        if btn and btn.Frame then
            UpdateItemBorder(btn)
            if not btn.Frame.isHooked then
                btn.Frame:HookScript("OnUpdate", function() UpdateItemBorder(btn) end)
                btn.Frame.isHooked = true
            end
        end
    end
end)
	
    if AS:IsAddonEnabled("Atlas") then
        hooksecurefunc("AtlasLoot_SetupForAtlas", function()
            AtlasLootInfo:Point("TOPLEFT", 546, 15)
            AtlasLootPanel:Point("BOTTOM", "AtlasLootDefaultFrame", "BOTTOM", 0, 1)
        end)
    
        hooksecurefunc("AtlasLoot_SetItemInfoFrame", function(pFrame)
            if not pFrame or pFrame == AtlasLootDefaultFrame then
                AtlasLootItemsFrame:Point("TOPLEFT", 15, -74)
            end
        end)
    end

    AS:SkinLibrary("Dewdrop-2.0")
    AS:SkinLibrary("AceAddon-2.0")
    AS:SkinLibrary("Tablet-2.0")
end)
