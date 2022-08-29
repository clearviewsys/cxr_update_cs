//%attributes = {}
C_BOOLEAN:C305($isInBlackList)

If (([Customers:3]FirstName:3#"") & ([Customers:3]LastName:4#""))
	SET QUERY DESTINATION:C396(Into current selection:K19:1)
	QUERY:C277([Occupations:2]; [Occupations:2]Code:2=[Customers:3]LastName:4)
	QUERY SELECTION:C341([Occupations:2]; [Occupations:2]Occupation:3=[Customers:3]FirstName:3; *)
	QUERY SELECTION:C341([Occupations:2];  | ; [Occupations:2]Description:4=[Customers:3]FirstName:3; *)
	QUERY SELECTION:C341([Occupations:2];  | ; [Occupations:2]Category:5=[Customers:3]FirstName:3; *)
	QUERY SELECTION:C341([Occupations:2];  | ; [Occupations:2]AML_Risk:6=[Customers:3]FirstName:3)
	
	If (Records in selection:C76([Occupations:2])>=1)
		displayCurrentRecord(->[Occupations:2])
		[Customers:3]AML_isSuspicious:49:=True:C214
		[Customers:3]isOnHold:52:=True:C214
	End if 
End if 