
C_OBJECT:C1216($iError)
$iError:=confirmationRequestForInvoice

//If ($tID#"")
//$iStatus:=confirmationWaitForResult ($tID)  //allow user to stop this process and if skip then not approved

//ALERT("The status is:"+confirmationGetStatusText ($iStatus))

//Else 
//ALERT("Error broadcasting the confirmation request")
//End if 