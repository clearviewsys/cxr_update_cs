//%attributes = {}
// searchAccounts ({searchString})

//Case of 
//: (Count parameters=0)
//C_TEXT(vSearchString)
//vSearchString:=$1
//
//End case 
READ ONLY:C145([Accounts:9])
searchTable(->[Accounts:9]; ->[Accounts:9]AccountID:1; ->[Accounts:9]AccountCode:4; ->[Accounts:9]MainAccountID:2; ->[Accounts:9]AccountType:5; ->[Accounts:9]Currency:6; ->[Accounts:9]AccountDescription:17)
QUERY SELECTION:C341([Accounts:9]; [Accounts:9]isHidden:21=False:C215)
orderByAccounts
