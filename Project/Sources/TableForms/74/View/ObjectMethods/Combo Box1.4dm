If (Form event code:C388=On Load:K2:1)
	ARRAY TEXT:C222(arrGroupNames2; 0)
	QUERY:C277([Customers:3]; [Customers:3]GroupName:90#"")
	//SELECTION TO ARRAY([Customers]GroupName;arrGroupNames)  // populate
	DISTINCT VALUES:C339([Customers:3]GroupName:90; arrGroupNames2)  // delete the dupplicates
	SORT ARRAY:C229(arrGroupNames2)
	
End if 

If (Form event code:C388=On Clicked:K2:4)
	[AMLRules:74]ignoreRuleForGroup:48:=arrGroupNames2{arrGroupNames2}
End if 