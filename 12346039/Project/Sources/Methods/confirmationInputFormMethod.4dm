//%attributes = {}

C_POINTER:C301($ptrList)
C_LONGINT:C283($i)


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		If ([Confirmations:153]status:12=confirmationUnknown)
			OBJECT SET VISIBLE:C603(*; "Confirmed_Auth@"; False:C215)
			
			If ([Confirmations:153]confirmObject:15.attachments=Null:C1517)
			Else 
				ARRAY TEXT:C222($atPaths; 0)
				OB GET ARRAY:C1229([Confirmations:153]confirmObject:15; "attachments"; $atPaths)
				
				$ptrList:=OBJECT Get pointer:C1124(Object named:K67:5; "CONFIRM_AttachmentList")
				
				If (Is nil pointer:C315($ptrList))
				Else 
					$ptrList->:=New list:C375
					
					For ($i; 1; Size of array:C274($atPaths))
						APPEND TO LIST:C376($ptrList->; UTIL_LongNameToFileName($atPaths{$i}); $i)
						SET LIST ITEM PARAMETER:C986($ptrList->; 0; "link"; $atPaths{$i})
					End for 
				End if 
				
			End if 
			
			OBJECT SET ENABLED:C1123(*; "btn_approve"; False:C215)
			//OBJECT SET ENTERABLE(*;"btn_success";False)
			OBJECT SET RGB COLORS:C628(*; "Approve_Color"; Dark shadow color:K23:3; Dark shadow color:K23:3)
			
			
		Else 
			OBJECT SET VISIBLE:C603(*; "Confirmed_Auth@"; True:C214)
			
			OBJECT SET RGB COLORS:C628(*; "Approve_Color"; Dark shadow color:K23:3; Dark shadow color:K23:3)
			OBJECT SET RGB COLORS:C628(*; "Deny_Color"; Dark shadow color:K23:3; Dark shadow color:K23:3)
			
			OBJECT SET ENABLED:C1123(*; "@"; False:C215)
			OBJECT SET ENTERABLE:C238(*; "@"; False:C215)
			
			OBJECT SET ENABLED:C1123(*; "Cancel"; True:C214)
			OBJECT SET ENTERABLE:C238(*; "Cancel"; True:C214)
			
			Case of 
				: ([Confirmations:153]status:12=confirmationDeny)
					stampText("stamp_Status"; "DENIED")
					
				: ([Confirmations:153]status:12=confirmationApprove)
					stampText("stamp_Status"; "APPROVED"; "green")
					
				: ([Confirmations:153]status:12=confirmationInterrupted)
					stampText("stamp_Status"; "CANCELED BY USER")
					
				Else 
					
			End case 
			
		End if 
		
		
	Else 
		
		
End case 