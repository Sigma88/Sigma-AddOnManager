local _, SAOM = ...;

-- Create the Button
SAOM.DeleteProfile = CreateFrame("Button", nil, AddonList, "MagicButtonTemplate");

function SAOM.DeleteProfile:OnLoad()
	-- Hide Separators
	SAOM.DeleteProfile.LeftSeparator:Hide();
	SAOM.DeleteProfile.RightSeparator:Hide();
	-- Set size and position
	SAOM.DeleteProfile:SetWidth(32);
	SAOM.DeleteProfile:SetHeight(19);
	SAOM.DeleteProfile:SetPoint("LEFT", SigmaAddOnManager_ProfilesListButton, "RIGHT", 0, -1);
	-- Set text and font
	SAOM.DeleteProfile:SetText(SAOM.L["DEL"]);
	local font, size = SAOM.DeleteProfile:GetFontString():GetFont();
	SAOM.DeleteProfile:GetFontString():SetFont(font, 10);
	-- Set Scripts
	SAOM.DeleteProfile:SetScript("OnClick", SAOM.DeleteProfile.OnClick);
end

function SAOM.DeleteProfile:OnClick()
	-- Check if a valid profile is selected
	local i = UIDropDownMenu_GetSelectedID(SAOM.ProfilesList) - 1;
	if SigmaAddOnManager and SigmaAddOnManager[i] then
		-- Remove the profile from the table
		table.remove(SigmaAddOnManager, i);
	end
	-- Update the DropDown menu
	SAOM.ProfilesList:OnShow();
end

SAOM.DeleteProfile:OnLoad();
