//%attributes = {}
// stringHasMinimumLength ($inputString; length)
// Check if string length is greatest than N 
// i.e: stringHasMinimumLength ("Ahmed";2)

C_TEXT:C284($1; $inputString)
C_LONGINT:C283($2; $length)
C_BOOLEAN:C305($0)


Case of 
	: (Count parameters:C259=2)
		
		$inputString:=$1
		$length:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

checkInit
checkIfStringLengthIsGT(->$inputString; $length; True:C214; "String")
If (<>CheckErrors="")
	$0:=True:C214
Else 
	$0:=False:C215
End if 

