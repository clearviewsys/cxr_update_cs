//%attributes = {}
checkUniqueKey(->[ClientPrefs:26]; ->[ClientPrefs:26]ClientName:1; "Client Name")
checkIfNullString(->[ClientPrefs:26]ComputerAlias:33; "Computer Alias")
checkIfNullString(->[ClientPrefs:26]BranchID:32; "Branch ID"; "WARN")
