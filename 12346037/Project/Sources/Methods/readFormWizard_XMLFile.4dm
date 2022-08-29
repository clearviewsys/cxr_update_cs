//%attributes = {}
//____________________________________________________________
// readFormWizard_XMLFile

C_TEXT:C284($1)
C_POINTER:C301($2; $datetimePtr; $3; $passportIDPtr; $4; $nationality)
C_POINTER:C301($5; $lastNamePtr; $6; $firstNamePtr; $7; $birthdatePtr; $8; $expiryDatePtr)
C_POINTER:C301($9; $issueDatePtr; $10; $personalID; $11; $genderPtr)
C_POINTER:C301($12; $addressPtr; $13; $statePtr; $14; $cityPtr; $15; $countryCodePtr)

C_TEXT:C284(xmlData; $filePath)
C_TEXT:C284($middleName; $nationalityCode; $countryCode)
C_POINTER:C301($datetimePtr; $passportIDPtr; $nationality; $lastNamePtr; $firstNamePtr; $birthdatePtr; $expiryDatePtr; $issueDatePtr; $personalID; $genderPtr)

// FilePath
If (Count parameters:C259=15)
	$filePath:=$1
	
	$datetimePtr:=$2
	$passportIDPtr:=$3
	$nationality:=$4
	
	$lastNamePtr:=$5
	$firstNamePtr:=$6
	$birthdatePtr:=$7
	
	$expiryDatePtr:=$8
	$issueDatePtr:=$9
	$personalID:=$10
	$genderPtr:=$11
	
	$addressPtr:=$12
	$statePtr:=$13
	$cityPtr:=$14
	$countryCodePtr:=$15
Else 
	assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End if 
C_TEXT:C284($element)

If ($filePath#"")
	xmlData:=readXMLFile($filePath)
Else 
	xmlData:=readXMLFile
End if 
C_TEXT:C284($xmlRef; $xmlRootPath)

If (xmlData#"")
	
	//SET TEXT TO PASTEBOARD(xmlData)
	
	$xmlRef:=DOM Parse XML variable:C720(xmlData)
	
	// Ask for branch details in results
	$xmlRootPath:="/ScanResult"
	$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Time")
	
	Case of 
			
		: (OK=1)
			
			// Parse results
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Time")
			DOM GET XML ELEMENT VALUE:C731($element; $datetimePtr->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/PassportId")
			DOM GET XML ELEMENT VALUE:C731($element; $passportIDPtr->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Nationality")
			DOM GET XML ELEMENT VALUE:C731($element; $nationalityCode)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Surname")
			DOM GET XML ELEMENT VALUE:C731($element; $lastNamePtr->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Middle_Name")
			DOM GET XML ELEMENT VALUE:C731($element; $middleName)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/First_Name")
			DOM GET XML ELEMENT VALUE:C731($element; $firstNamePtr->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Birthdate")
			DOM GET XML ELEMENT VALUE:C731($element; $birthdatePtr->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/ExpiryDate")
			DOM GET XML ELEMENT VALUE:C731($element; $expiryDatePtr->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Issue_Date")
			DOM GET XML ELEMENT VALUE:C731($element; $issueDatePtr->)
			
			//$element:=DOM Find XML element($xmlRef;$xmlRootPath+"/PersonalId")
			//DOM GET XML ELEMENT VALUE($element;$personalID->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Gender")
			DOM GET XML ELEMENT VALUE:C731($element; $genderPtr->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Address")
			DOM GET XML ELEMENT VALUE:C731($element; $addressPtr->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Issue_State")
			DOM GET XML ELEMENT VALUE:C731($element; $statePtr->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Issue_City")
			DOM GET XML ELEMENT VALUE:C731($element; $cityPtr->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Issue_Country_Code")
			DOM GET XML ELEMENT VALUE:C731($element; $countryCode)
			
			
			$firstNamePtr->:=$firstNamePtr->+" "+$middleName
			$nationality->:=getCountryCodeBy3charCode($nationalityCode)
			$countryCodePtr->:=getCountryCodeBy3charCode($countryCode)
	End case 
	
	// Memory clean
	DOM CLOSE XML:C722($xmlRef)
	
Else 
	myAlert("The XML File is empty")
End if 

