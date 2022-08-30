//%attributes = {}
// matchOFAC (companyName)
// matchOFAC (lastName; firstName)

C_BOOLEAN:C305(<>doCheckSanctionLists)

C_TEXT:C284($1; $2; $0)
setErrorTrap("matchOFAC"; "OFAC check failed.")

If (<>doCheckSanctionLists)
	Case of 
		: (Count parameters:C259=1)
			$0:=ws_matchOFACEntity(<>clientCode; <>clientKey; $1)
		: (Count parameters:C259=2)
			$0:=ws_matchOFACPerson(<>clientCode; <>clientKey; $1; $2)
		Else 
			$0:=""
	End case 
End if 
endErrorTrap