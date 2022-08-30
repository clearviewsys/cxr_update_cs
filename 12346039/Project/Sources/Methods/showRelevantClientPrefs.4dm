//%attributes = {}
QUERY:C277([ClientPrefs:26]; [ClientPrefs:26]ClientName:1=getCurrentMachineName)
If (Records in selection:C76([ClientPrefs:26])=0)
	allRecordsClientPrefs
End if 