//%attributes = {}

// ------------------------------------------------------------------------------
// Method: readPassportXMLFile: 
//         Read an XML file and parse elements
// ------------------------------------------------------------------------------
// Jaime Alvarez, November 2/2015
// Modified: Tiran Behrouz: Jan 29, 2019
// ------------------------------------------------------------------------------

C_TEXT:C284($1)
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8; $9; $10; $11)

C_TEXT:C284(xmlData; $filePath; $xmlRef; $xmlRootPath; $element)
C_LONGINT:C283($count)
C_POINTER:C301($datetime; $passportid; $nationality; $surname; $forenames; $birthdate; $expirydate; $issuedate; $personalID; $gender)

// FilePath
$filePath:=$1

$datetime:=$2
$passportid:=$3
$nationality:=$4

$surname:=$5
$forenames:=$6
$birthdate:=$7

$expirydate:=$8
$issueDate:=$9
$personalID:=$10
$gender:=$11

If ($filePath#"")
	xmlData:=readXMLFile($filePath)
Else 
	xmlData:=readXMLFile
End if 

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
			DOM GET XML ELEMENT VALUE:C731($element; $datetime->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/PassportId")
			DOM GET XML ELEMENT VALUE:C731($element; $passportid->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Nationality")
			DOM GET XML ELEMENT VALUE:C731($element; $nationality->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Surname")
			DOM GET XML ELEMENT VALUE:C731($element; $surname->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Forenames")
			DOM GET XML ELEMENT VALUE:C731($element; $forenames->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Birthdate")
			DOM GET XML ELEMENT VALUE:C731($element; $birthdate->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/ExpiryDate")
			DOM GET XML ELEMENT VALUE:C731($element; $expirydate->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/IssueDate")
			DOM GET XML ELEMENT VALUE:C731($element; $issuedate->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/PersonalId")
			DOM GET XML ELEMENT VALUE:C731($element; $personalID->)
			
			$element:=DOM Find XML element:C864($xmlRef; $xmlRootPath+"/Gender")
			DOM GET XML ELEMENT VALUE:C731($element; $gender->)
			
	End case 
	
	// Memory clean
	DOM CLOSE XML:C722($xmlRef)
	
Else 
	myAlert("The XML File is empty")
End if 
