C_LONGINT:C283($0)
Form:C1466.hello:="Hello"
Case of 
		
	: (Form event code:C388=On Drag Over:K2:13)
		// Accept On Drop event only if the pasteboard contains files, reject otherwise.
		If (Get file from pasteboard:C976(1)="")  //no file in pasteboard
			$0:=-1  //reject drop
		End if 
		
	: (Form event code:C388=On Drop:K2:12)  //Requires Droppable action enabled from Property List
		C_TEXT:C284($path_t; newAttchmentfilePath)
		C_OBJECT:C1216($path_o)
		newAttchmentfilePath:=""
		$path_t:=Get file from pasteboard:C976(1)
		If ($path_t#"")
			$path_o:=Path to object:C1547($path_t)
			If ($path_o.isFolder=False:C215)
				newAttchmentfilePath:=$path_o.parentFolder+$path_o.name+$path_o.extension
				checkInit
				validateCustomers
				If (isValidationConfirmed)
					setNextCustomer([Customers:3]CustomerID:1)
					PUSH RECORD:C176([Customers:3])
					newRecordLinkedDocs
					POP RECORD:C177([Customers:3])
					relateManyLinkedDocs
				End if 
			Else 
				myAlert("You cannot attach Folders, please choose a document instead")
			End if 
		End if 
		
End case 




//  NEED TO MAKE THE NEW LINKEDDOC SET THESE FEILDS
// [LinkedDocs]RelatedTableID
// [LinkedDocs]RelatedTableNum