C_POINTER:C301($ptrTable)
C_TEXT:C284($fileName)

checkInit
validateCustomers
If (isValidationConfirmed)
	
	If (True:C214)  // 1/15/23 @ibb
		
		$ptrTable:=->[Customers:3]
		
		$fileName:=Select document:C905(System folder:C487(Documents folder:K41:18); "*"; "Select a document to attach"; 0)
		
		If (OK=1)
			//DEFAULT TABLE([Customers])  //need this for the on load method of [LinkedDocs] to get related info
			
			REDUCE SELECTION:C351([LinkedDocs:4]; 0)
			
			createLinkedDoc($ptrTable; document)
			PUSH RECORD:C176($ptrTable->)
			modifyRecordLinkedDocs("Entry")
			POP RECORD:C177($ptrTable->)
			
			//DEFAULT TABLE($ptrTable->)
			
		End if 
		
		
	Else   // old code
		setNextCustomer([Customers:3]CustomerID:1)
		PUSH RECORD:C176([Customers:3])
		newRecordLinkedDocs
		POP RECORD:C177([Customers:3])
	End if 
	
	relateManyLinkedDocs
End if 


//  NEED TO MAKE THE NEW LINKEDDOC SET THESE FEILDS
// [LinkedDocs]RelatedTableID
// [LinkedDocs]RelatedTableNum