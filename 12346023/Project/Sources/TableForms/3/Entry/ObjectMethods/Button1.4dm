// this is used for testing creating new customer using keywords shortcuts
//GOTO OBJECT(*; "vTitle")
DELAY PROCESS:C323(Current process:C322; 30)

postKeySequence("Mr."; True:C214)

//DELAY PROCESS(Current process; 30)

postKeySequence("Auto")
//postKeySequence("Tester")
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)
POST KEY:C465(Tab key:K12:28)

//postKeySequence("Tester")
addMoreCustomerInfo





POST KEY:C465(Enter key:K12:26)

