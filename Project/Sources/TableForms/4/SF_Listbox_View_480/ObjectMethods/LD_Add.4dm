C_POINTER:C301($ptrTable; $ptrField)
C_TEXT:C284($fileName)

$ptrTable:=Current default table:C363

If (Is nil pointer:C315($ptrTable))
Else 
	$ptrTable:=->[Invoices:5]
End if 

Case of 
	: (Form event code:C388=On Load:K2:1)
		
		
	: (Form event code:C388=On Clicked:K2:4)
		
		If (True:C214)
			$fileName:=Select document:C905(System folder:C487(Documents folder:K41:18); "*"; "Select a document to attach"; 0)
			
			If (OK=1)
				DEFAULT TABLE:C46([Invoices:5])  //need this for the on load method of [LinkedDocs] to get related info
				
				REDUCE SELECTION:C351([LinkedDocs:4]; 0)
				
				createLinkedDoc($ptrTable; document)
				PUSH RECORD:C176($ptrTable->)
				modifyRecordLinkedDocs("Entry_Lite")
				POP RECORD:C177($ptrTable->)
				
				$ptrField:=getPrimaryKeyFieldPtr($ptrTable; True:C214)
				If ($ptrField#Null:C1517)  // fix for Daniels CQT-147 Error when adding attachment docs to due diligence
					QUERY:C277([LinkedDocs:4]; [LinkedDocs:4]RelatedTableNum:23=Table:C252($ptrTable); *)
					QUERY:C277([LinkedDocs:4];  & ; [LinkedDocs:4]RelatedTableID:24=$ptrField->)
				Else 
					myAlert("Couldn't find related field!")
				End if 
				
				
				
				DEFAULT TABLE:C46($ptrTable->)
				
			End if 
			
		Else 
			C_TEXT:C284($menu; $item)
			
			$menu:=Create menu:C408
			
			APPEND MENU ITEM:C411($menu; "Add Image")
			SET MENU ITEM PARAMETER:C1004($menu; -1; "image")
			APPEND MENU ITEM:C411($menu; "Add PDF")
			SET MENU ITEM PARAMETER:C1004($menu; -1; "pdf")
			
			$item:=Dynamic pop up menu:C1006($menu)
			
			If ($item="")
			Else 
				
				
				Case of 
					: ($item="image")
						If ([Customers:3]CustomerID:1=[Invoices:5]CustomerID:2)  //all good
						Else 
							RELATE ONE:C42([Invoices:5]CustomerID:2)  // load the customer record if it's not already loaded. 
						End if 
						
						setNextCustomer([Customers:3]CustomerID:1)  //set the global
						DEFAULT TABLE:C46([Invoices:5])  //need this for the on load method of [LinkedDocs] to get related info
						
						PUSH RECORD:C176([Invoices:5])
						newRecordLinkedDocs("Entry_Lite")
						POP RECORD:C177([Invoices:5])
						
						
						
					: ($item="pdf")
						$fileName:=Select document:C905(System folder:C487(Documents folder:K41:18); "pdf"; "Select a pdf file to attach"; 0)
						
						If (OK=1)
							createLinkedDoc(->[Invoices:5]; document)
							modifyRecordLinkedDocs
						End if 
					Else 
						
				End case 
				
				$ptrField:=getPrimaryKeyFieldPtr($ptrTable; True:C214)
				If ($ptrField#Null:C1517)  // fix for Daniels CQT-147 Error when adding attachment docs to due diligence
					QUERY:C277([LinkedDocs:4]; [LinkedDocs:4]RelatedTableNum:23=Table:C252($ptrTable); *)
					QUERY:C277([LinkedDocs:4];  & ; [LinkedDocs:4]RelatedTableID:24=$ptrField->)
				Else 
					myAlert("Couldn't find related field !")
				End if 
				
				DEFAULT TABLE:C46($ptrTable->)
				
			End if 
		End if 
	Else 
		
End case 
