//%attributes = {}
checkInit
C_TEXT:C284($str)
C_DATE:C307($date)

$str:=Request:C163("enter the string ")

checkIfValidDOB(!1980-01-01!; "Date of Birth")
checkifStringsEqual(->$str; "String"; "I agree")


If (isValidationConfirmed)
	myAlert("Success"+"- Warnings:"+<>CHECKWARNINGS)
Else 
	myAlert("Error "+<>CHECKERRORS)
End if 