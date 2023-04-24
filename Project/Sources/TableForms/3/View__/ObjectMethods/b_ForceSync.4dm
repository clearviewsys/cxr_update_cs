C_LONGINT:C283($iError)


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If (Sync_Is_Status_On("enabled"))
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
		
	: (Form event code:C388=On Clicked:K2:4)
		$iError:=Sync_Sync_This_Record(Table:C252(->[Customers:3]))
		If ($iError=0)
		Else 
			myAlert("Error forcing record sync. ["+String:C10($iError)+"]")
		End if 
End case 