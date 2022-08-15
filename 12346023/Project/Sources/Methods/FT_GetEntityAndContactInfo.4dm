//%attributes = {}
// FT_GetEntityAndContactInfo
// Read the config.ini file in order to get all entity and contact information to Fintrac REPORT

ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)

ARRAY TEXT:C222(LocationsNumberFT; 0)
ARRAY TEXT:C222(LocationsName; 0)

C_TEXT:C284($fileName)
C_BOOLEAN:C305($isOk)
// ---------------------------------------------------------------------------------------------------------
// Get the config information from the fintrac.ini file saved into Resources/config folder
// ---------------------------------------------------------------------------------------------------------

//$fileName:=Get 4D folder(Active 4D Folder)+"fintrac.ini"
$fileName:=getKeyValue("AML.Reporting.CA.default.config.path"; Get 4D folder:C485(Active 4D Folder:K5:10))+getKeyValue("AML.Reporting.CA.default.fileName"; "fintrac.ini")
$isOk:=FT_ReadConfigFile($fileName; ->$arrKeys; ->$arrValues)


// PKI certificate ID (Given by FINTRAC)
//reportingEntityPKI:=FT_GetConfigValue ("reportingEntityPKI";->$arrKeys;->$arrValues)
reportingEntityPKI:=getKeyValue("FT.reportingEntityPKI")

// Reporting entity's identifier number (Given by FINTRAC)
//reportingEntityCertificateID:=FT_GetConfigValue ("reportingEntityCertificateID";->$arrKeys;->$arrValues)
reportingEntityCertificateID:=getKeyValue("FT.reportingEntityCertificateID")

// Reporting entity Name 
//reportingEntityName:=FT_GetConfigValue ("reportingEntityName";->$arrKeys;->$arrValues)
reportingEntityName:=getKeyValue("FT.reportingEntityName")

// Reporting entity Location Number (Given by FINTRAC)
reportingEntityLocationNumber:=FT_GetConfigValue("reportingEntityLocationNumber"; ->$arrKeys; ->$arrValues)

// Reporting entity Location Name
reportingEntityLocationName:=FT_GetConfigValue("reportingEntityLocationName"; ->$arrKeys; ->$arrValues)


// Contact's surname
contactSurName:=FT_GetConfigValue("contactSurname"; ->$arrKeys; ->$arrValues)

// Contact's given name
contactGivenName:=FT_GetConfigValue("contactGivenName"; ->$arrKeys; ->$arrValues)

// Contact's Other name/Initial
contactOtherName:=FT_GetConfigValue("contactOtherName"; ->$arrKeys; ->$arrValues)

// Contact person telephone number
contactPhoneNumber:=FT_GetConfigValue("contactPhoneNumber"; ->$arrKeys; ->$arrValues)

// Contact person telephone extension number 
contactPhoneNumberExt:=FT_GetConfigValue("contactPhoneNumberExt"; ->$arrKeys; ->$arrValues)

// Contact person telephone extension number 
//initialDate:=Date(FT_GetConfigValue ("initialDate";->$arrKeys;->$arrValues))

initialDate:=Date:C102(getKeyValue("AML.Reporting.CA.last.report.date"; String:C10(Current date:C33(*))))
endDate:=initialDate

// Fill branches array and Location Nunbers arrays
READ ONLY:C145([Branches:70])
ALL RECORDS:C47([Branches:70])
orderByBranches


ARRAY TEXT:C222(LocationsNumberFT; 0)
ARRAY TEXT:C222(LocationsName; 0)
ARRAY TEXT:C222(BranchIds; 0)
C_TEXT:C284(reportBranchId)

SELECTION TO ARRAY:C260([Branches:70]LocationNumberFT:19; LocationsNumberFT; [Branches:70]BranchName:2; LocationsName; [Branches:70]BranchID:1; BranchIds)



APPEND TO ARRAY:C911(BranchIds; "ALL")
APPEND TO ARRAY:C911(LocationsNumberFT; "ALL")
APPEND TO ARRAY:C911(LocationsName; "ALL LOCATIONS")


LocationsName:=Size of array:C274(LocationsName)
LocationsNumberFT:=LocationsName

reportingEntityLocationName:=LocationsName{LocationsName}
reportingEntityLocationNumber:=LocationsNumberFT{LocationsName}
reportBranchId:=BranchIds{LocationsName}

