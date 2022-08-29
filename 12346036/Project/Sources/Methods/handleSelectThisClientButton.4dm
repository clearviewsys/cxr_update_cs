//%attributes = {}
//
//READ ONLY([ClientPrefs])
//CREATE EMPTY SET([ClientPrefs];"$thisClient")
//SET QUERY DESTINATION(Into set ;"$thisClient")
//QUERY([ClientPrefs];[ClientPrefs]ClientName=getcurrentMachineName)
//SET QUERY DESTINATION(Into current selection )
//If (Records in set("$thisClient")>0)
//HIGHLIGHT RECORDS([ClientPrefs];"$thisClient")
//End if 
//  `highlightRecords (Current form table)

QUERY:C277([ClientPrefs:26]; [ClientPrefs:26]ClientName:1=getCurrentMachineName)
highlightRecords(->[ClientPrefs:26])