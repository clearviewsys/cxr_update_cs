//%attributes = {}
Case of 
		
	: (Form event code:C388=On Window Opening Denied:K2:51)
		
		C_TEXT:C284($url)
		
		$url:=WA Get last filtered URL:C1035(*; Form:C1466.mywa)
		
		If ($url#"")
			
			mgOpenDeniedURL(New object:C1471("URL"; $url; "credentials"; Form:C1466.credentials))
			
		End if 
		
		
	: (Form event code:C388=On End URL Loading:K2:47)
		
		If (Form:C1466.status#Null:C1517)
			
			Case of 
					
				: (Form:C1466.status="OPENAFTERFORM")
					
					Form:C1466.status:="DONEAFTERFORM"
					
					
				: (Form:C1466.status="START")
					
					
				: (Form:C1466.status="SUBMITLOGINFORM")
					
					Form:C1466.status:="LOADTRANSACTIONFORM"
					
					
				: (Form:C1466.status="SUBMITFORM")
					
					Form:C1466.status:="OPENAFTERFORM"
					
					OBJECT SET VISIBLE:C603(*; Form:C1466.mywa; True:C214)
					
					
					
				: (Form:C1466.status="WAIT02")
					
					Form:C1466.status:="WAITEND"
					
					
			End case 
			
			
			
		Else 
			
			Form:C1466.status:="START"
			
		End if 
		
		
End case 
