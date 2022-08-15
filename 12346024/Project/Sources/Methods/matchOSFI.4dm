//%attributes = {}
// matchOSFI (companyName)
// matchOSFI (lastName; firstName)

C_BOOLEAN:C305(<>doCheckOSFI)

C_TEXT:C284($1; $2; $0)
setErrorTrap("matchOSFI"; "OSFI check failed.")

If (<>doCheckOSFI)
	Case of 
		: (Count parameters:C259=1)
			$0:=ws_matchOSFIEntity(<>clientCode; <>clientKey; $1)
		: (Count parameters:C259=2)
			$0:=ws_matchOSFIPerson(<>clientCode; <>clientKey; $1; $2)
		Else 
			$0:=""
	End case 
End if 
endErrorTrap