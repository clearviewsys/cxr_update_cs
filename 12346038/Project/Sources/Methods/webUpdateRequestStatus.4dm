//%attributes = {"publishedWeb":true}

C_OBJECT:C1216($entity; $record)
C_TEXT:C284($status)
C_LONGINT:C283($i)

webSelectCustomerRecord

If (Records in selection:C76([Customers:3])=1)
	READ WRITE:C146([WebEWires:149])
	
	QUERY:C277([WebEWires:149]; [WebEWires:149]CustomerID:21=[Customers:3]CustomerID:1; *)
	QUERY:C277([WebEWires:149];  & ; [WebEWires:149]status:16=5; *)  //pending payment
	QUERY:C277([WebEWires:149];  & ; [WebEWires:149]creationDate:15>Current date:C33-30)
	
	For ($i; 1; Records in selection:C76([WebEWires:149]))
		$status:=setWebEwirePaymentStatus
		NEXT RECORD:C51([WebEWires:149])
	End for 
	
	UNLOAD RECORD:C212([WebEWires:149])
	READ ONLY:C145([WebEWires:149])
End if 