//%attributes = {}
// makeCommentsForInvoiceLines

C_TEXT:C284($1)
C_TEXT:C284($0)
//READ ONLY([Registers])
RELATE ONE:C42([Registers:10]AccountID:6)  // this is to load the bank account currency

If (([Registers:10]AccountID:6#"") & ([Customers:3]FullName:40#"") & (([Registers:10]Debit:8#0) | ([Registers:10]Credit:7#0)))
	$0:=[Customers:3]FullName:40
	
	If ([Registers:10]isReceived:13)  // we received
		$0:=$0+" paid "  // customer paid
		$0:=$0+String:C10([Registers:10]Debit:8; "|Currency")+" "+[Registers:10]Currency:19
	Else 
		$0:=$0+" received "  // customer received
		$0:=$0+String:C10([Registers:10]Credit:7; "|Currency")+" "+[Registers:10]Currency:19
	End if 
	If ([Registers:10]InternalTableNumber:17>0)
		$0:=$0+" (Method: "+getElegantTableNameByNum([Registers:10]InternalTableNumber:17)+": "+[Registers:10]InternalRecordID:18+") "
	End if 
	$0:=$0+" on "+String:C10([Registers:10]RegisterDate:2)
	
	If (([Registers:10]InvoiceNumber:10#getWalkInCustomerID) & ([Registers:10]InvoiceNumber:10#""))
		$0:=$0+". Refer to invoice no. "+[Registers:10]InvoiceNumber:10
	End if 
	
End if 