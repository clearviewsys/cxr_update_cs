C_TEXT:C284(vExternalTableName)

HandleEntryForm
setApplicationUserForTable(->[Registers:10]; ->[Registers:10]CreatedByUserID:16; ->[Registers:10]ModifiedByUserID:22)

If ([Registers:10]AutoComments:12=True:C214)
	If (getRegisterTypeEnum([Registers:10]RegisterType:4)>0)  // not transfer and not null
		[Registers:10]Comments:9:=makeCommentsForInvoiceLines
	End if 
End if 

vExternalTableName:=getElegantTableNameByNum([Registers:10]InternalTableNumber:17)


//moved the followign to "HandleEntryForm"

//Case of 
//: (Form event=On Load)
//OBJECT SET ENABLED(bUpdate;False)
//
//: (Form event=On Outside Call) |
//If (Modified record(Current form table->))
//OBJECT SET ENABLED(bUpdate;True)
//Else 
//OBJECT SET ENABLED(bUpdate;False)
//End if 
//
//: (Form event=On After Keystroke) | (Form event=On Clicked)
//If (Modified record(Current form table->))
//OBJECT SET ENABLED(bUpdate;True)
//End if 
//End case 