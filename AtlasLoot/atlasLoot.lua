local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")
local AS = E:GetModule("AddOnSkins")

if not AS:IsAddonLODorEnabled("AtlasLoot") then return end

local select = select
local unpack = unpack

S:AddCallbackForAddon("AtlasLoot", "AtlasLoot", function()
    if not E.private.addOnSkins.AtlasLoot then return end

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
    
    AtlasLootPanel:StripTextures()
    AtlasLootPanel:SetTemplate("Transparent")
    
    AtlasLootDefaultFrame:StripTextures()
    AtlasLootDefaultFrame:SetTemplate("Transparent")
	
	DropDownList1:SetTemplate()

    AtlasLootDefaultFrame_ModuleSelect:StripTextures()
	AtlasLootDefaultFrame_InstanceSelect:StripTextures()
	S:HandleDropDownBox(AtlasLootDefaultFrame_ModuleSelect, 225)
	S:HandleDropDownBox(AtlasLootDefaultFrame_InstanceSelect, 225)
	-- Static Anchoring: Anchor to the Main Frame, not to each other
	AtlasLootDefaultFrame_ModuleSelect:ClearAllPoints()
	AtlasLootDefaultFrame_ModuleSelect:Point("TOPLEFT", AtlasLootDefaultFrame, "TOPLEFT", 10, -45)
	
	AtlasLootDefaultFrame_InstanceSelect:ClearAllPoints()
	-- Anchor the second box to a fixed X offset (240) so it never moves
	AtlasLootDefaultFrame_InstanceSelect:Point("TOPLEFT", AtlasLootDefaultFrame, "TOPLEFT", 240, -45)
	
	-- 3. Center the text inside the dropdowns
	AtlasLootDefaultFrame_ModuleSelectText:SetJustifyH("CENTER")
	AtlasLootDefaultFrame_InstanceSelectText:SetJustifyH("CENTER")
	

	S:HandleNextPrevButton(AtlasLootDefaultFrame_ModuleSelectButton)
	AtlasLootDefaultFrame_ModuleSelectButton:Height(24)
	S:HandleNextPrevButton(AtlasLootDefaultFrame_InstanceSelectButton)
	AtlasLootDefaultFrame_InstanceSelectButton:Height(24)
    S:HandleButton(AtlasLoot_AtlasInfoFrame_ToggleALButton)
    S:HandleButton(AtlasLootDefaultFrame_CompareFrame)
    S:HandleButton(AtlasLoot10Man25ManSwitch)
    S:HandleButton(AtlasLootServerQueryButton)
    S:HandleCheckBox(AtlasLootItemsFrame_Heroic)
    S:HandleCheckBox(AtlasLootFilterCheck)
    S:HandleButton(AtlasLootItemsFrame_BACK)
    S:HandleNextPrevButton(AtlasLootQuickLooksButton)
    S:HandleNextPrevButton(AtlasLootItemsFrame_PREV)
    S:HandleNextPrevButton(AtlasLootItemsFrame_NEXT)
	S:HandleCloseButton(AtlasLootDefaultFrame_CloseButton)
	
	S:HandleButton(AtlasLootDefaultFrame_LockButton)
	AtlasLootDefaultFrame_LockButton:ClearAllPoints()
	do
		local tex = AtlasLootDefaultFrame_LockButton:GetNormalTexture()
		if tex then
			tex:ClearAllPoints()
			tex:SetPoint("TOPLEFT", 2, -2)
			tex:SetPoint("BOTTOMRIGHT", -2, 2)
		end
		tex = AtlasLootDefaultFrame_LockButton:GetCheckedTexture()
		if tex then
			tex:ClearAllPoints()
			tex:SetPoint("TOPLEFT", 2, -2)
			tex:SetPoint("BOTTOMRIGHT", -2, 2)
		end
	end
	AtlasLootDefaultFrame_LockButton:Point("RIGHT", AtlasLootDefaultFrame_CloseButton, "LEFT", -4, 0)
	AtlasLootDefaultFrame_LockButton:Size(22)

    AtlasLoot_AtlasInfoFrame_ToggleALButton:Point("RIGHT", AtlasLootDefaultFrame_LockButton, "LEFT", -4, 0)
    AtlasLootDefaultFrame_CompareFrame:Point("TOPRIGHT", -42, -35)
    
    AtlasLoot10Man25ManSwitch:Height(24)
    AtlasLootServerQueryButton:Height(24)
    AtlasLootItemsFrame_BACK:Height(24)

    AtlasLoot10Man25ManSwitch:Point("BOTTOM", -130, 3)
    AtlasLootServerQueryButton:Point("BOTTOM", 131, 3)
    AtlasLootItemsFrame_BACK:Point("BOTTOM", 0, 3)

    AtlasLootItemsFrame_Heroic:Point("BOTTOM", -185, 28)
    AtlasLootFilterCheck:Point("BOTTOM", 115, 28)
    AtlasLootQuickLooksButton:Point("BOTTOM", 58, 32)

    AtlasLootItemsFrame_PREV:Point("BOTTOMLEFT", 7, 6)
    AtlasLootItemsFrame_NEXT:Point("BOTTOMRIGHT", -6, 6)
    
    S:HandleButton(AtlasLoot_PanelButton_1)
    AtlasLoot_PanelButton_1:Point("LEFT", AtlasLootPanel, "LEFT", 7, 29)
    S:HandleButton(AtlasLoot_PanelButton_2)
    AtlasLoot_PanelButton_2:Point("LEFT", AtlasLoot_PanelButton_1, "RIGHT", 2, 0)
    S:HandleButton(AtlasLoot_PanelButton_3)
    AtlasLoot_PanelButton_3:Point("LEFT", AtlasLoot_PanelButton_2, "RIGHT", 2, 0)
    S:HandleButton(AtlasLoot_PanelButton_4)
    AtlasLoot_PanelButton_4:Point("LEFT", AtlasLoot_PanelButton_3, "RIGHT", 2, 0)
    S:HandleButton(AtlasLoot_PanelButton_5)
    AtlasLoot_PanelButton_5:Point("LEFT", AtlasLoot_PanelButton_4, "RIGHT", 2, 0)
    S:HandleButton(AtlasLoot_PanelButton_6)
    AtlasLoot_PanelButton_6:Point("LEFT", AtlasLoot_PanelButton_5, "RIGHT", 2, 0)
    S:HandleButton(AtlasLoot_PanelButton_7)
    S:HandleButton(AtlasLoot_PanelButton_8)
    S:HandleButton(AtlasLoot_PanelButton_9)
    S:HandleButton(AtlasLoot_PanelButton_10)
    S:HandleButton(AtlasLoot_PanelButton_11)
    S:HandleButton(AtlasLoot_PanelButton_12)
    S:HandleEditBox(AtlasLootPanelSearch_Box)
    
    -- Handle the last 4 buttons
    S:HandleButton(AtlasLootPanelSearch_SearchButton)
    AtlasLootPanelSearch_SearchButton:Height(22)
    AtlasLootPanelSearch_SearchButton:Point("LEFT", AtlasLootPanelSearch_Box, "RIGHT", 3, 0)
    S:HandleNextPrevButton(AtlasLootPanelSearch_SelectModule)
    AtlasLootPanelSearch_SelectModule:Point("LEFT", AtlasLootPanelSearch_SearchButton, "RIGHT", 2, 0)
    S:HandleButton(AtlasLootPanelSearch_ClearButton)
    AtlasLootPanelSearch_ClearButton:Height(22)
    AtlasLootPanelSearch_ClearButton:Point("LEFT", AtlasLootPanelSearch_SelectModule, "RIGHT", 2, 0)
    S:HandleButton(AtlasLootPanelSearch_LastResultButton)
    AtlasLootPanelSearch_LastResultButton:Height(22)
    AtlasLootPanelSearch_LastResultButton:Point("LEFT", AtlasLootPanelSearch_ClearButton, "RIGHT", 2, 0)

    AtlasLootCompareFrame:SetTemplate()
	AtlasLootCompareFrame:StripTextures()
	


   -- if AS:IsAddonEnabled("Atlas") then
   --     hooksecurefunc("AtlasLoot_SetupForAtlas", function()
   --         AtlasLootInfo:Point("TOPLEFT", 546, 15)
   --         AtlasLootPanel:Point("BOTTOM", "AtlasLootDefaultFrame", "BOTTOM", 0, 1)
   --     end)
   -- 
   --     hooksecurefunc("AtlasLoot_SetItemInfoFrame", function(pFrame)
   --         if not pFrame or pFrame == AtlasLootDefaultFrame then
   --             AtlasLootItemsFrame:Point("TOPLEFT", 15, -74)
   --         end
   --     end)
   -- end

    AS:SkinLibrary("Dewdrop-2.0")
    AS:SkinLibrary("AceAddon-2.0")
    AS:SkinLibrary("Tablet-2.0")
end)
