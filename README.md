# AtlasLootEnhanced v6.05.04 (WotLK Backport)

A high-performance, optimized backport of the Cataclysm AtlasLootEnhanced engine, refined specifically for the **Wrath of the Lich King (3.3.5a)**. This version merges modern features with classic data accuracy.

## 🚀 Key Improvements & Features
- **Restored Content:** Added missing data for reworked instances like **Zul'Aman** and **Zul'Gurub**, specifically tailored for WotLK loot tables.
- **Database Cleanup:** All Glyphs, Gems, and Items have been audited to match WotLK IDs and names. No more "broken" or "non-existent" Cataclysm items that cause crashes.
- **Integrated ElvUI Skinning:** Native support for ElvUI/AddOnSkins is built-in. 
  - **Dynamic Zoom:** Icons are automatically zoomed when ElvUI skinning is active to achieve a sharp, modern look that matches the rest of the UI.
- **Visual Clarity:** Added a custom **Skull Icon** above Heroic loot sections for instant recognition.

## ⚠️ Important: Compatibility Warning
> [!CAUTION]
> **This version will overwrite and replace settings/skinning for AtlasLoot v5.11.04.**

**Clean Install Recommended:**
To avoid database conflicts, you **must** delete your old folders from `Interface/AddOns` before installing this version:
- `AtlasLoot`
- `AtlasLootFu`
- `AtlasLoot_BurningCrusade`
- `AtlasLoot_Crafting`
- `AtlasLoot_OriginalWoW`
- `AtlasLoot_WorldEvents`
- `AtlasLoot_WrathoftheLichKing`

## 🛠️ Compatibility & Recommendations
- **Standalone Power:** This addon is fully functional without the "Atlas" map addon. It provides all item and boss information natively within its own interface.
- **World Map Integration:** For entrance locations, I highly recommend using the [WDM-patch by Trimitor](https://github.com/Trimitor/WDM-patch), which integrates this data directly into the HD World Map.

## ⚠️ Known Issues & Community Support
- **Classic Item Quality:** Some item names or qualities might still reflect their post-Cata states. While server queries fix most of these automatically, I am manually auditing the database.
- **Report a Bug:** If you find an item that doesn't match the 3.3.5a database exactly, please open an issue. Your feedback helps maintain the immersion!

## 📦 How to Install
- Extract `AtlasLootEnhancedCata-WotLK-main.zip`
- Copy All of the Folders:
- `AtlasLoot`
- `AtlasLoot_BurningCrusade`
- `AtlasLoot_ClassicWoW`
- `AtlasLoot_Crafting`
- `AtlasLoot_Loader`
- `AtlasLoot_WorldEvents`
- `AtlasLoot_WrathoftheLichKing`
### If you are using ElvUI also copy: `ElvUI_AddOnSkins` - (If you are not using ElvUI you can skip this one)
- Paste All of the Folders to: `Interface/Addons`

> [!TIP]
> If you see a folder named `AtlasLootEnhancedCata-WotLK-main` inside your `AddOns` folder, **YOU DID IT WRONG.** Take the folders out of it and put them in the main AddOns directory!

---
*Source code base provided by [skyler-code](https://github.com/skyler-code/AtlasLoot_WOTLK).*
