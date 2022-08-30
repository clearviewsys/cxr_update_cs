//%attributes = {}


//REDUCE SELECTION([Registers];1)
READ WRITE:C146([Registers:10])
LOAD RECORD:C52([Registers:10])
If (Record number:C243([Registers:10])<0)
	myAlert("Please select a record first.")
Else 
	
	// FOR SOME STRANGE REASON THE RECORD IS LOST AFTER THE CONFIRM DIALOG IS DISPLAYED
	// THEREFORE I HAD TO USE THE PUSH RECORD
	PUSH RECORD:C176([Registers:10])
	CONFIRM:C162("Are you sure you want to delete the selected record?"+[Registers:10]Comments:9)
	POP RECORD:C177([Registers:10])
	//
	
	If (OK=1)
		C_POINTER:C301($tablePtr)
		If ([Registers:10]InternalTableNumber:17>0)
			$tablePtr:=Table:C252([Registers:10]InternalTableNumber:17)
			If ((Table:C252($tablePtr)#Table:C252(->[Registers:10])) & (Table:C252($tablePtr)#Table:C252(->[Invoices:5])) & (Table:C252($tablePtr)#Table:C252(->[eWires:13])))  // DO NOT DELETE THE REGISTER ITSELF OR THE INVOICE (TRANSFERS) or eWires
				READ WRITE:C146($tablePtr->)  // delete the related wire or other table
				QUERY:C277($tablePtr->; Field:C253([Registers:10]InternalTableNumber:17; 1)->=[Registers:10]InternalRecordID:18)  // find the related ewire
				
				DELETE RECORD:C58($tablePtr->)
				//myAlert("Record "+[Registers]externalReference+" deleted from "+getElegantTableName ($tablePtr))
				READ ONLY:C145($tablePtr->)
			End if 
			If (Table:C252($tablePtr)=Table:C252(->[eWires:13]))
				READ WRITE:C146([eWires:13])
				QUERY:C277([eWires:13]; [eWires:13]eWireID:1=[Registers:10]InternalRecordID:18)
				If (Records in selection:C76([eWires:13])>0)  // found an ewire
					Repeat 
						GOTO XY:C161(10; 10)
						MESSAGE:C88("Waiting for record to be released.")
					Until (Locked:C147([eWires:13])=False:C215)
					LOAD RECORD:C52([eWires:13])
					[eWires:13]isCancelled:34:=True:C214
					[eWires:13]comments_Private:47:=[eWires:13]comments_Private:47+" Cancelled from within invoice"
					SAVE RECORD:C53([eWires:13])
					myAlert("The eWire "+[Registers:10]InternalRecordID:18+"is now cancelled.")
				End if 
			End if 
		End if 
		
		//  //update the <>applicationuser on the server
		//While (Semaphore("ServerAppUser"))
		//DELAY PROCESS(Current process;30)
		//End while 
		//
		//SET PROCESS VARIABLE(-1;<>APPLICATIONUSER;<>APPLICATIONUSER)
		DELETE RECORD:C58([Registers:10])
		//SET PROCESS VARIABLE(-1;<>APPLICATIONUSER;"")  //remove user from server
		//CLEAR SEMAPHORE("ServerAppUser")
		
		
		//relatemanyregisters
		relateManyRegistersForInvoice
	End if 
End if 


