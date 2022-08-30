//handleListBoxFormMethod
C_OBJECT:C1216($obj)
C_TEXT:C284($tableName; $fieldName)

If (Form event code:C388=On Load:K2:1)
	Form:C1466.adds:=ds:C1482.Addresses.query("RecordID = :1 AND TableNo = :2"; Form:C1466.recordID; Form:C1466.tableNo)
	//If (Form.recordIDFieldptr#Null)
	
	//$tableName:=Table name(Form.recordIDFieldptr->)
	//$fieldName:=Field name(Form.recordIDFieldptr->)
	
	//If (Form.recordID#Null)
	
	//$obj:=ds[$tableName].query($fieldName+" = "+Form.recordID).first()
	
	//  // Form.adds:=ds.Addresses.query("City = 'Vancouver' ")  // ??? How to access recordID of current form?
	
	//Form.adds:=$obj
	
	//End if 
	
	//End if 
End if 

If (Form event code:C388=On Close Box:K2:21)
	CLOSE WINDOW:C154(Frontmost window:C447)
	CANCEL:C270
End if 

