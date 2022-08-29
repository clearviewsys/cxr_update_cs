HandleEntryFormMethod(Current form table:C627; ->[CSMRelations:89]createdByUser:17; ->[CSMRelations:89]modifiedByUser:19)

If (Form event code:C388=On Load:K2:1)
	If (Is new record:C668([CSMRelations:89]))
		[CSMRelations:89]CSMRelationID:1:=makeCSMRelationID
		
		If (getNextCustomer#"")
			[CSMRelations:89]CustomerID1:2:=getNextCustomer
			
			
			If ([Customers:3]FullName:40#"")
				[CSMRelations:89]FullName1:4:=[Customers:3]FullName:40
			Else 
				If ([Customers:3]isCompany:41)
					[CSMRelations:89]FullName1:4:=[Customers:3]CompanyName:42
				Else 
					[CSMRelations:89]FullName1:4:=makeFullName([Customers:3]FirstName:3; [Customers:3]LastName:4)
				End if 
			End if 
			
			initNextCustomer
			GOTO OBJECT:C206([CSMRelations:89]CustomerID2:3)
			[CSMRelations:89]CustomerID2:3:=""
			[CSMRelations:89]FullName2:5:=""
		End if 
		
	End if 
	
End if 

