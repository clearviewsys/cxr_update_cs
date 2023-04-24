//%attributes = {}
checkIfRelatedManyRecordExist(->[Registers:10]; ->[Registers:10]CustomerID:5; " journal registers"; "WARN")
checkIfRelatedManyRecordExist(->[LinkedDocs:4]; ->[LinkedDocs:4]CustomerID:1; "picture IDs"; "warn")
checkIfRelatedManyRecordExist(->[Links:17]; ->[Links:17]CustomerID:14; "Links (beneficiaries)"; "warn")
checkIfRelatedManyRecordExist(->[eWires:13]; ->[eWires:13]CustomerID:15; "eWires"; "W")
checkifRelatedOneExist(->[Customers:3]; ->[Customers:3]CustomerID:1; ->[WebUsers:14]; ->[WebUsers:14]webUsername:1; "Login ID"; "W")