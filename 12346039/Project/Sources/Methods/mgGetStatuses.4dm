//%attributes = {}
// returns the collection of MG transaction statuses
C_COLLECTION:C1488($0)

$0:=New collection:C1472

$0.push(New object:C1471("statusCode"; 10; "status"; "New"))

$0.push(New object:C1471("statusCode"; 20; "status"; "Deleted"))

$0.push(New object:C1471("statusCode"; 30; "status"; "Paidin"))

$0.push(New object:C1471("statusCode"; 40; "status"; "ReadyForPayout"))

$0.push(New object:C1471("statusCode"; 50; "status"; "Expired"))

$0.push(New object:C1471("statusCode"; 65; "status"; "PreparedForPayout"))

$0.push(New object:C1471("statusCode"; 70; "status"; "Canceled"))

$0.push(New object:C1471("statusCode"; 80; "status"; "Returned"))

$0.push(New object:C1471("statusCode"; 90; "status"; "Paidout"))

$0.push(New object:C1471("statusCode"; 99; "status"; "Pending"))

