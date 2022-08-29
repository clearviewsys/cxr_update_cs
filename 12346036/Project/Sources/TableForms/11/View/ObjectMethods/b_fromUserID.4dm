
QUERY:C277([WebUsers:14]; [WebUsers:14]webUsername:1=[MESSAGES:11]FromUserID:5)
If ([WebUsers:14]relatedTable:8>0)
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[WebUsers:14]webUsername:1)
	displayCurrentRecord(->[Customers:3])
Else 
	QUERY:C277([Agents:22]; [Agents:22]AgentID:1=[WebUsers:14]webUsername:1)
	displayCurrentRecord(->[Agents:22])
End if 
