HandleEntryForm(->[Users:25]; ->[Users:25]createdBy:20; ->[Users:25]modifiedByUser:21; ->[Users:25]BranchID:17)

If (Form event code:C388=On Load:K2:1)
	//starttransaction
	READ WRITE:C146([Privileges:24])
	ARRAY TEXT:C222(arrTableNames; 0)
	ARRAY INTEGER:C220(arrTableNumbers; 0)
	fillArrayTableNamesAndNumbers(->arrTableNumbers; ->arrTableNames)
	RELATE MANY:C262([Users:25]UserID:1)
	
End if 

If (onNewRecordEvent)
	[Users:25]UserID:1:=makeUsersID
	createPrivilegeRecord([Users:25]UserID:1; 0; False:C215; False:C215; False:C215; False:C215; False:C215; False:C215; False:C215)
	RELATE MANY:C262([Users:25]UserID:1)
	LOAD RECORD:C52([Privileges:24])
End if 

If (Form event code:C388=On Clicked:K2:4)
	relateOne(->[Branches:70]; ->[Users:25]BranchID:17; ->[Branches:70]BranchID:1)
End if 