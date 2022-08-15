Case of 
	: (Form event code:C388=On Load:K2:1)
		If ((getNextCustomer#"") & (getNextCustomer#getWalkInCustomerID))  // if it wasn't empty and it wasn't a walkin customer
			Self:C308->:=getNextCustomer
			initNextCustomer
			GOTO OBJECT:C206([LinkedDocs:4]DocReference:6)
			//OBJECT SET ENTERABLE(Self->;False)
		End if 
		
	: (Form event code:C388=On Data Change:K2:15)
		C_TEXT:C284(vCustomerID)
		PUSH RECORD:C176([LinkedDocs:4])  // because pickcustomer will query on the pictureIDs
		vCustomerID:=[LinkedDocs:4]CustomerID:1
		pickCustomer(->vCustomerID)
		POP RECORD:C177([LinkedDocs:4])
		[LinkedDocs:4]CustomerID:1:=vCustomerID
		RELATE ONE:C42([LinkedDocs:4]CustomerID:1)
		CLEAR VARIABLE:C89(vCustomerID)
		
		
End case 


