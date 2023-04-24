//%attributes = {}
// assigns the dynamically created choice list to form object

C_LONGINT:C283($0)  // list refNum
C_TEXT:C284($1; $formObjectName)

$formObjectName:=$1

$0:=New list:C375

APPEND TO LIST:C376($0; "ALN"; 1)
APPEND TO LIST:C376($0; "DRV"; 2)
APPEND TO LIST:C376($0; "GOV"; 3)
APPEND TO LIST:C376($0; "PAS"; 4)
APPEND TO LIST:C376($0; "STA"; 5)

OBJECT SET LIST BY REFERENCE:C1266(*; $formObjectName; Choice list:K42:19; $0)

