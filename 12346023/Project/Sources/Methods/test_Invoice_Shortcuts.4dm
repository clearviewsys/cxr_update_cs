//%attributes = {}
// this is used for testing buy and sell using keywords shortcuts
//GOTO OBJECT(*; "vReceivedPaid")
DELAY PROCESS:C323(Current process:C322; 30)

POST KEY:C465(Tab key:K12:28)
//DELAY PROCESS(Current process; 30)
POST KEY:C465(Tab key:K12:28)

POST KEY:C465(Tab key:K12:28)
//DELAY PROCESS(Current process; 30)
POST KEY:C465(Tab key:K12:28)

postKeySequence("S"; True:C214)
POST KEY:C465(Tab key:K12:28)

DELAY PROCESS:C323(Current process:C322; 30)
//GOTO OBJECT(*; "vAmount")  // 
postKeySequence("500"; True:C214)
postKeySequence("EUR"; True:C214)
DELAY PROCESS:C323(Current process:C322; 30)
postKeySequence("///"; True:C214)
DELAY PROCESS:C323(Current process:C322; 30)
POST KEY:C465(Enter key:K12:26)

//postKeySequence("500\\tEUR\\t//")

//vAmount:=1000
//DELAY PROCESS(Current process; 1500)
//postKeySequence("\\tUSD\\t")
//handleInvoiceSaveButton
