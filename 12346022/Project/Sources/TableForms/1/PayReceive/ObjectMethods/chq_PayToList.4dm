If (False:C215)
	
	If (Form event code:C388=On Load:K2:1)
		ARRAY TEXT:C222(arrPayTo; 0)
		
		PUSH RECORD:C176([Cheques:1])
		SET QUERY DESTINATION:C396(Into current selection:K19:1)
		QUERY:C277([Cheques:1]; [Cheques:1]CustomerID:2=[Invoices:5]CustomerID:2)
		If (Records in selection:C76([Cheques:1])>0)
			SELECTION TO ARRAY:C260([Cheques:1]PayTo:15; arrPayTo)
			
		End if 
		POP RECORD:C177([Cheques:1])
	End if 
	
	
	If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
		[Cheques:1]PayTo:15:=arrPayTo{arrPayTo}
	End if 
	
End if 
//handleComboFromField (Self;->[Cheques]PayTo;->[Cheques]PayTo)
