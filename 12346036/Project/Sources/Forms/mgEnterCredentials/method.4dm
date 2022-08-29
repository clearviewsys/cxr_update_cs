C_POINTER:C301($deviceIDs_popup_ptr)

$deviceIDs_popup_ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "deviceIDs")

Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		OBJECT SET FONT:C164(*; "password"; "%Password")
		
		OBJECT SET VISIBLE:C603(*; "deviceIDs"; False:C215)
		
		ARRAY TEXT:C222($deviceIDs_popup_ptr->; 0)
		
		If (Form:C1466.credentials.deviceIDs#Null:C1517)
			If (Form:C1466.credentials.deviceIDs.length>0)
				Form:C1466.credentials.agentID:=Form:C1466.credentials.deviceIDs[0]
			End if 
			
			If (Form:C1466.credentials.deviceIDs.length>1)
				
				OBJECT SET TITLE:C194(*; "l_agentID"; "Device IDs")
				COLLECTION TO ARRAY:C1562(Form:C1466.credentials.deviceIDs; $deviceIDs_popup_ptr->)
				
				$deviceIDs_popup_ptr->:=1
				OBJECT SET VISIBLE:C603(*; "deviceIDs"; True:C214)
				OBJECT SET VISIBLE:C603(*; "agentID"; False:C215)
				
				Form:C1466.credentials.agentID:=$deviceIDs_popup_ptr->{1}
				
			End if 
		End if 
		
End case 
