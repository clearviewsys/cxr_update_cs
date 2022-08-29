//If (False)
//ARRAY TEXT(arrAccountsFilter;0)
//End if 
C_POINTER:C301($arrPtr)
$arrPtr:=Self:C308

Case of 
	: (Form event code:C388=On Load:K2:1)
		READ ONLY:C145([Accounts:9])
		QUERY:C277([Accounts:9]; [Accounts:9]isBankAccount:7=True:C214)
		SELECTION TO ARRAY:C260([Accounts:9]AccountID:1; $arrPtr->)
		SORT ARRAY:C229($arrPtr->)
		INSERT IN ARRAY:C227($arrPtr->; 1)  // insert a row on top of the array
		$arrPtr->{1}:="Pick a bank account..."
		$arrPtr->:=1
	: (Form event code:C388=On Clicked:K2:4)
		
		C_TEXT:C284($selection)
		$selection:=$arrPtr->{$arrPtr->}
		If ($selection#"")
			READ ONLY:C145([Wires:8])
			SET QUERY DESTINATION:C396(Into current selection:K19:1)
			QUERY:C277([Wires:8]; [Wires:8]CXR_AccountID:11=$selection)
			orderByWires
		End if 
End case 