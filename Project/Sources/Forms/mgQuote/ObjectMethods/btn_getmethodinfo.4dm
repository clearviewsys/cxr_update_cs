C_OBJECT:C1216($methodInfo)

If (Form event code:C388=On Clicked:K2:4)
	
	If (Form:C1466.currDeliveryOption#Null:C1517)
		
		TRACE:C157
		
		mgLOG_Start
		
		$methodInfo:=mgGetSendRequestMethodInfo(Form:C1466.currDeliveryOption)
		
		If ($methodInfo.success)
			
			TRACE:C157
			
		End if 
		
		mgLOG_Save(False:C215)  // do not clear log
		
	End if 
	
End if 
