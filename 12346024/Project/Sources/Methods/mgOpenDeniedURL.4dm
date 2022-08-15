//%attributes = {}
// opens the print receipt URL from MoneyGram that was blocked in Web area because Profix ttries to open popup window
// which is blocked by default in Chromium/Blink
// we catch this in WebArea object method traping the On Window Blocked form event

C_OBJECT:C1216($1; $obj)
C_LONGINT:C283($winref)

$obj:=$1

If (($obj.URL#Null:C1517) & ($obj.credentials#Null:C1517))
	
	If ($obj.URL#"")
		
		If (False:C215)
			
			$winref:=Open form window:C675("mgConfirmationWebArea")
			
			DIALOG:C40("mgConfirmationWebArea"; $obj)
			
			CLOSE WINDOW:C154
			
		Else 
			
			SET WINDOW TITLE:C213("Print your receipt ...")
			
			WA OPEN URL:C1020(*; Form:C1466.mywa; $obj.URL)
			
		End if 
		
	End if 
	
End if 
