//validateInvoices
C_LONGINT:C283($iError)
C_TEXT:C284($tResult)
// validateInvoices

handleSaveInvoiceButton


If (OK=0)  //8/18/16 -- this is bad it got reset
	$tResult:=" SAVE BTN clicked but OK=0: [99] invoice: "+[Invoices:5]InvoiceID:1+" "+[Invoices:5]CustomerFullName:54+" -- "+[Invoices:5]comments:43
	If (False:C215)
		$iError:=sendEmail("barclay@mac.com"; "Branch:"+<>BRANCHID+" User:"+<>USERID+" Date:"+String:C10(Current date:C33)+" "+"Invoice SAVE Btn changed OK variable"; $tResult)
	End if 
	Sync_Log(Current method name:C684; $tResult)
	
	OK:=1  //8/18/16 just in case it gets reset above
	//8/29/16 - ˆhave now recieved one of these emails... so we know that the OK var can get reset - MUST make sure the OK var is 1 here for newRecord validation to work
End if 

// SAVE RECORD([Invoices]) -- was called in handleSaveInvoiceButton