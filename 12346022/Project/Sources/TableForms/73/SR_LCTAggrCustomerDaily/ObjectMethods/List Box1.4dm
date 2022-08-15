C_LONGINT:C283($row)
C_POINTER:C301($columnPtr)
C_TEXT:C284($CustomerID; $vBranchID; $customerName)
C_DATE:C307($date)

If (Form event code:C388=On Double Clicked:K2:5)
	$ColumnPtr:=Focus object:C278
	// $Column contains a pointer to col2
	$Row:=$ColumnPtr->  //$Row equals 5
	If ($row>0)
		$CustomerID:=ARRCUSTOMERIDS{$row}
		$date:=arrDates{$row}
		$customerName:=ARRCUSTOMERNAMES{$row}
		FORM GOTO PAGE:C247(2)
		
		selectRegistersByCustomerID($CustomerID; $date; $date; True:C214; False:C215; False:C215; VBRANCHID)
		QUERY SELECTION:C341([Registers:10]; [Registers:10]isCash:40=True:C214)  // cash only
		If ($customerName="")  //finding customer name, in case it was left blank for faster speed
			RELATE ONE:C42([Registers:10]CustomerID:5)
		End if 
		OBJECT SET TITLE:C194(*; "CustomerName"; [Customers:3]FullName:40)
	End if 
End if 