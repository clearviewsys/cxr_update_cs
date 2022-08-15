//%attributes = {}
// load3MPassportXMLFile (filename; ->firstNames;->lastNames;->gender;->DOB;->

C_TEXT:C284($1; $filename; $filePath; $datetimeStr; $DOBStr; $expiryDateStr; $issueDateStr)
C_POINTER:C301($datetimePtr; $passportIDPtr; $nationalityPtr; $lastNamePtr; $firstNamesPtr; $DOBPtr; $expiryDatePtr; $issueDatePtr; $personalIDPtr; $genderPtr)
C_POINTER:C301($2; $3; $4; $5; $6; $7; $8; $9; $10; $11)

$filename:=$1
$firstNamesPtr:=$2
$lastNamePtr:=$3
$genderPtr:=$4
$nationalityPtr:=$5
$DOBPtr:=$6
$passportIDPtr:=$7
$expiryDatePtr:=$8
$issueDatePtr:=$9
$personalIDPtr:=$10
$genderPtr:=$11

$filePath:=getFilePathByID("3M Scanner:ScanFolder")+$fileName+".xml"

If ($filePath#"")
	
	readPassportXMLFile($filePath; ->$datetimeStr; $passportIDPtr; $nationalityPtr; $lastNamePtr; $firstNamesPtr; ->$DOBStr; ->$expiryDateStr; ->$issueDateStr; $personalIDPtr; $genderPtr)
	$DOBPtr->:=parseYYYYMMDDdatesString($DOBStr)
	$expiryDatePtr->:=parseYYYYMMDDdatesString($expiryDateStr)
	$issueDatePtr->:=parseYYYYMMDDdatesString($issueDateStr)
	
	$genderPtr->:=Uppercase:C13(Substring:C12($genderPtr->; 1; 1))  // take the first character of the Gender (M or F)
	
Else 
	myAlert("FilePath not defined for 3M Scanner:XMLFolder")
	displayListFilePaths
End if 








