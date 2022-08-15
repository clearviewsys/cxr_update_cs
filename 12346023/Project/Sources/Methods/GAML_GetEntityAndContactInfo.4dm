//%attributes = {}
// GAML_GetEntityAndContactInfo
// Read the config.ini file in order to get all entity and contact information to Fintrac REPORT

ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)

C_TEXT:C284($fileName)
C_BOOLEAN:C305($isOk)

// ---------------------------------------------------------------------------------------------------------
// Get the config information from the goaml.ini file saved into Resources/config folder
// ---------------------------------------------------------------------------------------------------------

$fileName:=Get 4D folder:C485(Active 4D Folder:K5:10)+"goaml.ini"
$isOk:=FT_ReadConfigFile($fileName; ->$arrKeys; ->$arrValues)

// Report EntityID (Defined by FIU)
reportingEntityID:=FT_GetConfigValue("reportingEntityID"; ->$arrKeys; ->$arrValues)
reportingEntityName:=FT_GetConfigValue("reportingEntityName"; ->$arrKeys; ->$arrValues)
reportingBranchName:=FT_GetConfigValue("reportingBranchName"; ->$arrKeys; ->$arrValues)

// Contact's title
contactTitle:=FT_GetConfigValue("contactTitle"; ->$arrKeys; ->$arrValues)

// Contact's given name
contactGivenName:=FT_GetConfigValue("contactGivenName"; ->$arrKeys; ->$arrValues)

// Contact's Other name/Initial
contactOtherName:=FT_GetConfigValue("contactOtherName"; ->$arrKeys; ->$arrValues)

// Contact's surname of the Branch Manager 
contactSurName:=FT_GetConfigValue("contactSurname"; ->$arrKeys; ->$arrValues)

// Contact's eMail
contactEmail:=FT_GetConfigValue("contactEmail"; ->$arrKeys; ->$arrValues)

// Contact's Occupation
contactOccupation:=FT_GetConfigValue("contactOccupation"; ->$arrKeys; ->$arrValues)

// Contact's contact Natonality
contactNationality:=FT_GetConfigValue("contactNationality"; ->$arrKeys; ->$arrValues)


finalDate:=Date:C102(FT_GetConfigValue("finalDate"; ->$arrKeys; ->$arrValues))
initialDate:=finaldate

