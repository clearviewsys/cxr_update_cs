//%attributes = {}
If ([Customers:3]AML_isInBusinessRelation:115=0)
	READ WRITE:C146([Customers:3])
	[Customers:3]AML_BusinessRelationStarted:119:=Current date:C33
	[Customers:3]AML_isInBusinessRelation:115:=1
	SAVE RECORD:C53([Customers:3])
	READ ONLY:C145([Customers:3])
	notifyAlert("message"; [Customers:3]FullName:40+" is in business relationship with us"+String:C10([Customers:3]AML_BusinessRelationStarted:119))
	
End if 