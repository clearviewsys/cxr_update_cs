// this is used for testing adding new currency using keywords shortcuts

DELAY PROCESS:C323(Current process:C322; 30)
GOTO OBJECT:C206(*; "Ticker1")


postKeySequence("MXN"; True:C214)
POST KEY:C465(Tab key:K12:28)
postKeySequence("MXN"; True:C214)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)

//GOTO OBJECT(*; "b_validate")

POST KEY:C465(Enter key:K12:26)
