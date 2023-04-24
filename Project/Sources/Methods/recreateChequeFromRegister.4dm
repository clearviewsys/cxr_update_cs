//%attributes = {}

C_OBJECT:C1216($es; $cheque; $status)

If ([Registers:10]InternalTableNumber:17=Table:C252(->[Cheques:1]))
	
	$es:=ds:C1482.Cheques.query("ChequeID == :1"; [Registers:10]InternalRecordID:18)
	
	If ($es.length=0)
		
		$cheque:=ds:C1482.Cheques.new()
		$cheque.ChequeID:=[Registers:10]InternalRecordID:18
		$cheque.CustomerID:=[Registers:10]CustomerID:5
		$cheque.InvoiceID:=[Registers:10]InvoiceNumber:10
		$cheque.RegisterID:=[Registers:10]RegisterID:1
		$cheque.AccountID:=[Registers:10]AccountID:6
		$cheque.BranchID:=[Registers:10]BranchID:39
		If ([Registers:10]DebitLocal:23=0)
			$cheque.Amount:=[Registers:10]Credit:7
			$cheque.amountLocal:=[Registers:10]CreditLocal:24
		Else 
			$cheque.Amount:=[Registers:10]Debit:8
			$cheque.amountLocal:=[Registers:10]DebitLocal:23
		End if 
		$cheque.Currency:=[Registers:10]Currency:19
		$cheque.IssueDate:=[Registers:10]RegisterDate:2
		$cheque.SubAccountID:=[Registers:10]SubAccountID:58
		$cheque.modBrandID:=[Registers:10]modBranchID:63
		$cheque.feeLocal:=[Registers:10]feeLocal:29
		$cheque.spotRate:=[Registers:10]SpotRate:26
		$cheque.ourRate:=[Registers:10]OurRate:25
		$cheque.PercentFee:=[Registers:10]percentFee:28
		$status:=$cheque.save()
		
		If ($status.success=False:C215)
			TRACE:C157
		End if 
		
	End if 
	
End if 