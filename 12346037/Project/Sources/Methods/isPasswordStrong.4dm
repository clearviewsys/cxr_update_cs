//%attributes = {}
// isPasswordStrong (text; ->errorText) : boolean
// returns true if the password is not strong

C_TEXT:C284($1; $source; $error)
C_POINTER:C301($2; $errorPtr)

C_BOOLEAN:C305($0; $isStrong; $containsCapital; $containsLowercase; $containsNum; $containsSymbol)

$source:="okidAoki!2"
$error:=""
$errorPtr:=->$error

Case of 
	: (Count parameters:C259=0)
	: (Count parameters:C259=1)
		$source:=$1
	: (Count parameters:C259=2)
		$source:=$1
		$errorPtr:=$2
	Else 
		ASSERT:C1129(False:C215; "Invalid number of params")
End case 

C_BOOLEAN:C305($isLong)

$containsCapital:=True:C214
$containsLowercase:=True:C214
$containsNum:=True:C214
$containsSymbol:=True:C214

$isLong:=Length:C16($source)>8  //getKeyValue ("web.configuration.password.numCharacters";"9")
checkAddErrorIf(Not:C34($isLong); "Password must be longer than 8 characters")

If (getKeyValue("web.configuration.password.useNumbers"; "true")="true")
	$containsNum:=stringContainsAnyCharFrom($source; "1234567890")  // contains a number
	checkAddErrorIf(Not:C34($containsNum); "Password must contain at least one Number")
End if 
If (getKeyValue("web.configuration.password.useUppercase"; "false")="true")
	$containsCapital:=stringContainsAnyCharFrom($source; "ABCDEFGHIJKLMNOPQRSTUVWXYZ")  // contains a capial
	checkAddErrorIf(Not:C34($containsCapital); "Password must contain at least one Capital letter")
End if 
If (getKeyValue("web.configuration.password.useLowercase"; "true")="true")
	$containsLowercase:=stringContainsAnyCharFrom($source; "abcdefghijklmnopqrstuvwxyz")  // contains a capial
	checkAddErrorIf(Not:C34($containsLowercase); "Password must contain at least one lowercase letter")
End if 
If (getKeyValue("web.configuration.password.useSpecial"; "true")="true")
	$containsSymbol:=stringContainsAnyCharFrom($source; "!@#$%^&*()_+-=[]\\{}|;':,./<>?`~")  // contains a symbol
	checkAddErrorIf(Not:C34($containsSymbol); "Password must contain at least one Symbol")
End if 

//Removed July 11, 2019. Clearing earlier errors in password change, 
//causing bug where current password did not need to be correct
//checkInit 

$error:=checkGetErrorString
$errorPtr->:=$error
$isStrong:=$isLong & $containsLowercase & $containsSymbol & $containsNum

$0:=$isStrong
