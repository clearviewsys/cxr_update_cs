//%attributes = {}
// Form Handler View ( »table )


C_POINTER:C301($tablePtr)
C_LONGINT:C283($event)
C_BOOLEAN:C305(DataChanged)
$tablePtr:=Current form table:C627
$event:=Form event code:C388

Case of 
	: ($event=On Load:K2:1)
		SET MENU BAR:C67(1)
		
		
	: ($event=On Unload:K2:2)
		
		
	: ($event=On Close Box:K2:21)
		CANCEL:C270
		
		
		
End case 
