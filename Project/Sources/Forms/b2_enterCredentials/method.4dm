Case of 
		
	: (Form event code:C388=On Load:K2:1)
		
		Form:C1466.b2:=b2_getKeyValues
		Form:C1466.isModified:=False:C215
		
		OBJECT SET ENABLED:C1123(*; "b_Save"; False:C215)
		
		
	: (Form event code:C388=On Data Change:K2:15)
		
		var $enable : Boolean
		
		$enable:=False:C215
		
		Case of 
				
			: (Form:C1466.b2.keyID="")
			: (Form:C1466.b2.keyName="")
			: (Form:C1466.b2.key="")
			: (Form:C1466.b2.bucketName="")
			Else 
				If (Form:C1466.isModified)
					$enable:=True:C214
				End if 
		End case 
		
		OBJECT SET ENABLED:C1123(*; "b_Save"; $enable)
		
		
End case 
