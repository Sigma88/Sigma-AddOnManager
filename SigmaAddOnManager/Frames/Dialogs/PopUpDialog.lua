local _, SAOM = ...;

-- Create an empty table for the dialog
SAOM.PopUpDialog = {};

function SAOM.PopUpDialog:TextBoxOnText()
	-- Store the text into dialog.data
	self:GetParent().data = self:GetText();
end

function SAOM.PopUpDialog:TextBoxOnEscape()
	-- Pressing escape will cancel the save
	self:GetParent():Hide();
end

function SAOM.PopUpDialog:TextBoxOnEnter()
	-- Pressing enter will confirm the save
	local parent = self:GetParent();
	SAOM.PopUpDialog.OnAccept(parent, parent.data, parent.data2);
	parent:Hide();
end

function SAOM.PopUpDialog:OnAccept(data, data2)
	
	-- If there is no table create one
	if not SigmaAddOnManager then
		SigmaAddOnManager = {};
	end
	
	-- Get the profile name from dialog.data
	local profileName = data;
	
	-- If the name is not valid create a default one
	if not(data and #data > 0) then
		profileName = "Unnamed Profile";
	end
	
	-- If a profile with the same name already exist, override it
	local addons = {};
	for i,profile in ipairs(SigmaAddOnManager) do
		if profileName == profile.name then
			SAOM:SaveAddOnProfile(SigmaAddOnManager[i].addons);
			SAOM.ProfilesList:OnShow();
			return;
		end
	end
	
	-- Otherwise create a new profile
	table.insert(SigmaAddOnManager, { name = profileName, addons = SAOM:SaveAddOnProfile() });
	
	-- Update the DropDown menu
	SAOM.ProfilesList:OnShow();
end

-- Add the static information for the dialog
StaticPopupDialogs["SigmaAddOnManager_SaveProfile"] = {
	text = SAOM.L["INPUT_NAME"],
	button1 = SAOM.L["ACCEPT"],
	button2 = SAOM.L["CANCEL"],
	OnAccept = SAOM.PopUpDialog.OnAccept,
	timeout = 0,
	whileDead = true,
	enterClicksFirstButton = true,
	hideOnEscape = true,
	hasEditBox = true,
	EditBoxOnEnterPressed = SAOM.PopUpDialog.TextBoxOnEnter,
	EditBoxOnEscapePressed = SAOM.PopUpDialog.TextBoxOnEscape,
	EditBoxOnTextChanged = SAOM.PopUpDialog.TextBoxOnText,
}
