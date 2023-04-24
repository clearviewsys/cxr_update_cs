//%attributes = {}
// readFormWizardXMLFile ( ->firstNames;->lastNames;->gender;->DOB;->

C_TEXT:C284($datetimeStr; $DOBStr; $expiryDateStr; $issueDateStr; $filename; $filePath)
C_POINTER:C301($datetimePtr; $passportIDPtr; $nationalityPtr; $lastNamePtr; $firstNamesPtr; $DOBPtr; $expiryDatePtr; $issueDatePtr; $personalIDPtr; $genderPtr; $addressPtr; $statePtr; $cityPtr; $countryCodePtr)
C_POINTER:C301($1; $2; $3; $4; $5; $6; $7; $8; $9; $10; $11; $12; $13; $14; $15)

Case of 
	: (Count parameters:C259=14)
		$firstNamesPtr:=$1
		$lastNamePtr:=$2
		$genderPtr:=$3
		$nationalityPtr:=$4
		$DOBPtr:=$5
		$passportIDPtr:=$6
		$expiryDatePtr:=$7
		$issueDatePtr:=$8
		$personalIDPtr:=$9
		$genderPtr:=$10
		
		$addressPtr:=$11
		$statePtr:=$12
		$cityPtr:=$13
		$countryCodePtr:=$14
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$filePath:=getFilePathByID("WizzForms:XML")

If ($filePath#"")
	
	readFormWizard_XMLFile($filePath; ->$datetimeStr; $passportIDPtr; $nationalityPtr; $lastNamePtr; $firstNamesPtr; ->$DOBStr; ->$expiryDateStr; ->$issueDateStr; $personalIDPtr; $genderPtr; $addressPtr; $statePtr; $cityPtr; $countryCodePtr)
	$DOBPtr->:=parseYYYYMMDDdatesString($DOBStr)
	$expiryDatePtr->:=parseYYYYMMDDdatesString($expiryDateStr)
	$issueDatePtr->:=parseYYYYMMDDdatesString($issueDateStr)
	
	$genderPtr->:=Uppercase:C13(Substring:C12($genderPtr->; 1; 1))  // take the first character of the Gender (M or F)
	
Else 
	myAlert("FilePath not defined for WizzForms:XML")
	displayListFilePaths
End if 


