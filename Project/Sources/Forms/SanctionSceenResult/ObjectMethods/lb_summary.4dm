Case of 
	: (Form event code:C388=On Selection Change:K2:29)
		var $col; $row : Integer
		LISTBOX GET CELL POSITION:C971(OBJECT Get pointer:C1124(Object current:K67:2)->; $col; $row)
		$row:=$row-1
		var $server : Text
		$server:=$row=-1 ? "" : Form:C1466.summary.server[$row]
		Case of 
			: ($server=sl_useLocalBlacklist)
				Form:C1466.localBlackList:=Form:C1466.lists[$row]
				FORM GOTO PAGE:C247(4)
				
			: ($server=sl_useOpenSanctions)
				If (Form:C1466.lists[$row]#Null:C1517)
					Form:C1466.openSanctions:=Form:C1466.lists[$row]
					EXECUTE METHOD IN SUBFORM:C1085("sf_openSanctions"; "sl_handleOpenSanctionResult")
					FORM GOTO PAGE:C247(3)
				End if 
				
			: ($server=sl_useKYC2020)
				If (Form:C1466.lists[$row]#Null:C1517)
					Form:C1466.KYC2020:=Form:C1466.lists[$row]
					FORM GOTO PAGE:C247(2)
				End if 
				
			Else 
				FORM GOTO PAGE:C247(1)
		End case 
End case 