

Case of 
	: (Form event code:C388=On Load:K2:1)
		If (Current user:C182="designer")
			OBJECT SET VISIBLE:C603(Self:C308->; True:C214)
		Else 
			OBJECT SET VISIBLE:C603(Self:C308->; False:C215)
		End if 
	Else 
		
		C_OBJECT:C1216($iError)
		$iError:=confirmationRequestForInvoice
		
		//If ($tID#"")
		//$iStatus:=confirmationWaitForResult ($tID)  //allow user to stop this process and if skip then not approved
		
		//ALERT("The status is:"+confirmationGetStatusText ($iStatus))
		
		//Else 
		//ALERT("Error broadcasting the confirmation request")
		//End if 
End case 