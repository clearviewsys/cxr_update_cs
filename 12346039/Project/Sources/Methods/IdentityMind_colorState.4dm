//%attributes = {}
// IdentityMind_colorstate($name;$input)
// Change the text color of a response
// 
// Parameters:
// $name  (C_TEXT)
//     object name
// $input (C_Text)
//     the text to base the status on
//
// Returns: (NONE)

// === PART 1: SETUP ===

C_TEXT:C284($1; $name)  // Object name
C_TEXT:C284($2; $input)  // Response JSON value

Case of 
	: (Count parameters:C259=2)
		$name:=$1
		$input:=$2
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 

// === PART 2: Create the lists ===

ARRAY TEXT:C222($passes; 0)
APPEND TO ARRAY:C911($passes; "A")
APPEND TO ARRAY:C911($passes; "TRUSTED")
APPEND TO ARRAY:C911($passes; "SUCCESS")
APPEND TO ARRAY:C911($passes; "ACCEPT")
APPEND TO ARRAY:C911($passes; "success")
APPEND TO ARRAY:C911($passes; "Accepted")

ARRAY TEXT:C222($errors; 0)
APPEND TO ARRAY:C911($errors; "D")
APPEND TO ARRAY:C911($errors; "BAD")
APPEND TO ARRAY:C911($errors; "ERROR")
APPEND TO ARRAY:C911($errors; "FAIL")
APPEND TO ARRAY:C911($errors; "DENY")
APPEND TO ARRAY:C911($errors; "failed")
APPEND TO ARRAY:C911($errors; "Rejected")

ARRAY TEXT:C222($none; 0)
APPEND TO ARRAY:C911($none; "")
APPEND TO ARRAY:C911($none; "n/a")

// === PART 3: Match and colour the object ===
C_BOOLEAN:C305($search)
C_LONGINT:C283($i)
$search:=True:C214
For ($i; 1; Size of array:C274($passes))
	If ($passes{$i}=$input)
		$search:=False:C215
		OBJECT SET RGB COLORS:C628(*; $name; 0x004CBB17; Background color:K23:2)  //Green
		$i:=Size of array:C274($passes)
	End if 
End for 

If ($search)
	For ($i; 1; Size of array:C274($errors))
		If ($errors{$i}=$input)
			$search:=False:C215
			OBJECT SET RGB COLORS:C628(*; $name; 0x00FF0000; Background color:K23:2)  // red
			$i:=Size of array:C274($errors)
		End if 
	End for 
End if 

If ($search)
	For ($i; 1; Size of array:C274($none))
		If ($none{$i}=$input)
			$search:=False:C215
			OBJECT SET RGB COLORS:C628(*; $name; 0xA9A9A900; Background color:K23:2)  // yellow
			$i:=Size of array:C274($errors)
		End if 
	End for 
End if 

If ($search)
	OBJECT SET RGB COLORS:C628(*; $name; 0x00FFBF00; Background color:K23:2)  // gray
End if 