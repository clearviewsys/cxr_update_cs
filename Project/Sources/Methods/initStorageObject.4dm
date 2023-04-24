//%attributes = {}
// initStorageObject
// call this method to load the initial values in the Storage object
// shall be enhanced to load all the server Preferences and other permanent static values
// called from the Startup method



var $aml : Object
$aml:=New object:C1471

$aml.countryCodes:=getHighRiskCountryCodes
$aml.occupations:=getHighRiskOccupations  // this may not be necessary if the occupation code is implemented in the rule engine
$aml.occupationCodes:=getHighRiskOccupationCodes  //todo: implement occupationCode in the rule engine instead of occupations
$aml.industryCodes:=getHighRiskIndustryCodes  // may need to refactor industries to industryCodes
$aml.SOFs:=getHighRiskSOFs
$aml.POTs:=getHighRiskPOTs

// The following code snippet is only for initializing Storage.AML_highRisk
Use (Storage:C1525)
	Storage:C1525.AML_highRisk:=New shared object:C1526
	Use (Storage:C1525.AML_highRisk)
		Storage:C1525.AML_highRisk:=OB Copy:C1225($aml; ck shared:K85:29)
	End use 
End use 
