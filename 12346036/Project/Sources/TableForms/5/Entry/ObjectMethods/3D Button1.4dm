// this is used for testing sell ewire using keywords shortcuts
//GOTO OBJECT(*; "vReceivedPaid")
DELAY PROCESS:C323(Current process:C322; 120)
postKeySequence("Tiran Behrouz"; True:C214)

//acceptSelectedCustomer
POST KEY:C465(Enter key:K12:26)
POST KEY:C465(Tab key:K12:28)

postKeySequence("s"; True:C214)
POST KEY:C465(Tab key:K12:28)
C_POINTER:C301($Ptr)
$Ptr:=OBJECT Get pointer:C1124(Object named:K67:5; "vPaymentMethod")
//Get menu item("vPaymentMethod"; 6)
//OBJECT SET VALUE($Ptr->; "e_Wire")
//$Ptr->:=vecPaymentMethod{6}
//postKeySequence(Ptr->{6}; True)
//Focus object(vecPaymentMethod)
//postKeySequence("c_eWire"; True)
//REDRAW
//DELAY PROCESS(Current process; 30)
//GOTO OBJECT(*; "vAmount")  // 
postKeySequence("500"; True:C214)

postKeySequence("EUR"; True:C214)
//DELAY PROCESS(Current process; 30)
postKeySequence("///"; True:C214)
DELAY PROCESS:C323(Current process:C322; 30)
POST KEY:C465(Enter key:K12:26)

//postKeySequence("500\\tEUR\\t//")

//vAmount:=1000
//DELAY PROCESS(Current process; 1500)
//postKeySequence("\\tUSD\\t")
//handleInvoiceSaveButton
