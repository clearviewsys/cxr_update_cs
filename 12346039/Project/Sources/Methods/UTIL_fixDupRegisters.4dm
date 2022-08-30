//%attributes = {}
C_OBJECT:C1216($e)
C_LONGINT:C283($i)
C_TEXT:C284($registerID)
C_POINTER:C301($tablePtr; $fieldPtr)

If (False:C215)
	//[AccountInOuts]RegisterID
	//[CashTransactions]registerID
	//[Cheques]RegisterID
	//[eWires]RegisterID
	//[ItemInOuts]registerID
	//[Wires]CXR_RegisterID
	
	//[AccountInOuts]InvoiceID
	//[CashTransactions]InvoiceID
	//[Cheques]InvoiceID
	//[eWires]InvoiceNumber
	//[ItemInOuts]InvoiceID
	//[Wires]CXR_InvoiceID
End if 

READ WRITE:C146(*)

QUERY:C277([Registers:10]; [Registers:10]RegisterID:1="MBREG380514")

For ($i; 1; Records in selection:C76([Registers:10]))
	
	$registerID:=[Registers:10]RegisterID:1
	
	$e:=ds:C1482.Registers.query("RegisterID == :1"; $registerID)
	
	If ($e.length>1)  //dup
		
		$tablePtr:=Table:C252([Registers:10]InternalTableNumber:17)  //get the related table
		
		QUERY:C277($tablePtr->; Field:C253([Registers:10]InternalTableNumber:17; 1)->=[Registers:10]InternalRecordID:18)  // look for the related 
		
		
		// get pointer to the invoice number field of tablePtr
		Case of 
			: ($tablePtr=(->[eWires:13]))
				$fieldPtr:=UTIL_getFieldPointer("["+Table name:C256($tablePtr)+"]InvoiceNumber")
			: ($tablePtr=(->[Wires:8]))
				$fieldPtr:=UTIL_getFieldPointer("["+Table name:C256($tablePtr)+"]CXR_InvoiceID")
			Else 
				$fieldPtr:=UTIL_getFieldPointer("["+Table name:C256($tablePtr)+"]InvoiceID")
		End case 
		
		
		
		Case of 
			: (Records in selection:C76($tablePtr->)=1)  // should be all good
				// does the invoice number match ??
				If ($fieldPtr->=[Registers:10]InvoiceNumber:10)
					
					$fieldPtr:=UTIL_getFieldPointer("["+Table name:C256($tablePtr)+"]RegisterID")  /// get the registerID field for tablePtr
					
					[Registers:10]RegisterID:1:=[Registers:10]RegisterID:1+"x"
					$fieldPtr->:=[Registers:10]RegisterID:1
					
					SAVE RECORD:C53([Registers:10])
					SAVE RECORD:C53($tablePtr->)
					
					
				Else 
					TRACE:C157
				End if 
				
			: (Records in selection:C76($tablePtr->)>1)
				TRACE:C157  // shouldn't happen
				
				QUERY:C277($tablePtr->; $fieldPtr->=[Registers:10]InvoiceNumber:10)
				
				If (Records in selection:C76($tablePtr->)=1)
					
				Else 
					TRACE:C157
				End if 
				
			Else 
				// missing register
				TRACE:C157
		End case 
		
	End if 
	
	NEXT RECORD:C51([Registers:10])
End for 