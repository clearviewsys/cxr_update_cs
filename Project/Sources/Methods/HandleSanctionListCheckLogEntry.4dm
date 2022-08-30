//%attributes = {}
HandleEntryFormMethod

If (Form event code:C388=On Load:K2:1)
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[SanctionCheckLog:111]InternalRecordID:2)
End if 