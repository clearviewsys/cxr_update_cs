//%attributes = {}
C_TEXT:C284($branchID; $0)
READ ONLY:C145([ClientPrefs:26])
QUERY:C277([ClientPrefs:26]; [ClientPrefs:26]ClientName:1=getCurrentMachineName)
LOAD RECORD:C52([ClientPrefs:26])
$branchID:=[ClientPrefs:26]BranchID:32
UNLOAD RECORD:C212([ClientPrefs:26])
$0:=$branchID
