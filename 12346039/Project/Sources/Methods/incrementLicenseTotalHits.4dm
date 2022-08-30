//%attributes = {}
// incrementLicenseTotalHits (License; {Value (int)};{set (boolean)})
// Purpose: Method to set the total hits of a License
//If just license passed, increments by one
//If license and value passed, increments by value
//If license and value passed and set=true, sets to value
// Returns: The value set, 0 if not found
// PRE: License#""

C_TEXT:C284($license; $1)
C_LONGINT:C283($value; $current; $2; $0)
C_BOOLEAN:C305($set; $3)
C_LONGINT:C283($found)
Case of 
	: (Count parameters:C259=1)
		$license:=$1
	: (Count parameters:C259=2)
		$license:=$1
		$value:=$2
	: (Count parameters:C259=3)
		$license:=$1
		$value:=$2
		$set:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ASSERT:C1129($license#""; "License cannot be null")

SET QUERY DESTINATION:C396(Into current selection:K19:1)
QUERY:C277([Licenses:160]; [Licenses:160]LicenseID:2=$license)
$found:=Records in selection:C76([Licenses:160])
READ WRITE:C146([Licenses:160])

If ($found=1)  // found
	LOAD RECORD:C52([Licenses:160])
	$current:=[Licenses:160]TotalHit:7
	If ($set)
		[Licenses:160]TotalHit:7:=$value
		$0:=$value
	Else 
		If ($value>0)
			[Licenses:160]TotalHit:7:=$current+$value
			$0:=$current+$value
		Else 
			[Licenses:160]TotalHit:7:=$current+1
			$0:=$current+1
		End if 
	End if 
	SAVE RECORD:C53([Licenses:160])
	UNLOAD RECORD:C212([Licenses:160])
	
End if 


READ ONLY:C145([Licenses:160])
