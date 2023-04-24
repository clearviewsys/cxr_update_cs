var $set : Boolean

$set:=False:C215

Case of 
		
	: (Form event code:C388=On Selection Change:K2:29)
		
		If (Form:C1466.selectedLocalFiles#Null:C1517)
			If (Form:C1466.selectedLocalFiles.length>0)
				$set:=True:C214
			End if 
		End if 
		
		OBJECT SET ENABLED:C1123(*; "btnUploadToCloud"; $set)
		OBJECT SET ENABLED:C1123(*; "btnShowFolder"; $set)
		
End case 
