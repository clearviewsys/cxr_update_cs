C_LONGINT:C283($pid)
Case of 
	: (Form event code:C388=On Load:K2:1)
		
		//Pointer to dropdown menu
		C_POINTER:C301($pDrop)
		$pDrop:=->drop_CCwireSend
		
		//Set drop down menu item
		ARRAY TEXT:C222(drop_CCwireSend; 1)
		drop_CCwireSend{1}:="Loading accounts"
		drop_CCwireSend:=1
		
		bPriority:=1
		bRegular:=0
		
		//Process will update dropdown with account currencies
		$pid:=New process:C317("CC_getAccounts"; 0; "CC_getAccounts"; $pDrop)
End case 