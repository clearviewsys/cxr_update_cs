//%attributes = {}
// This_GreyIf

C_BOOLEAN:C305($isInactive; $1)
C_LONGINT:C283($0)

If (Count parameters:C259=1)
	$isInactive:=$1
Else 
	$isInactive:=[Users:25]isInactive:18
End if 

If ($isInactive)
	$0:=(130 << 16)+(130 << 8)+130
Else 
	Case of 
		: ([Users:25]isAdministrator:33)
			$0:=(240 << 16)
			
	End case 
End if 