//%attributes = {}
// FJ_GetEntityAndContactInfo
// Read the config.ini file in order to get all entity and contact information to Fintrac REPORT

ARRAY TEXT:C222($arrKeys; 0)
ARRAY TEXT:C222($arrValues; 0)
C_TEXT:C284($fileName)
C_BOOLEAN:C305($isOk)


// ---------------------------------------------------------------------------------------------------------
// Get the config information from the goaml.ini file saved into Resources/config folder
// ---------------------------------------------------------------------------------------------------------

$fileName:=Get 4D folder:C485(Active 4D Folder:K5:10)+"fiji.ini"
$isOk:=FT_ReadConfigFile($fileName; ->$arrKeys; ->$arrValues)

// Report EntityID (Defined by FIU)
C_TEXT:C284(reportingEntityID)
reportingEntityID:=FT_GetConfigValue("reportingEntityID"; ->$arrKeys; ->$arrValues)
C_TEXT:C284(fiReportRef)
fiReportRef:=FT_GetConfigValue("fiReportRef"; ->$arrKeys; ->$arrValues)

// Contact's surname of the Branch Manager 
contactEntityName:=FT_GetConfigValue("contactEntityName"; ->$arrKeys; ->$arrValues)

// Contact's given name
contactEntityAddress:=FT_GetConfigValue("contactEntityAddress"; ->$arrKeys; ->$arrValues)

// Contact's Other name/Initial
contactOtherInfo:=FT_GetConfigValue("contactOtherInfo"; ->$arrKeys; ->$arrValues)

finalDate:=Date:C102(FT_GetConfigValue("finalDate"; ->$arrKeys; ->$arrValues))
initialDate:=finaldate

