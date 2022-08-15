

// #ORDA
C_OBJECT:C1216($es)
C_COLLECTION:C1488($coll)
C_POINTER:C301($self)
C_TEXT:C284($customerID)

$self:=Self:C308

If (Form event code:C388=On Load:K2:1)
	$customerID:=[Invoices:5]CustomerID:2
	If ($customerID="")
		$customerID:=[Cheques:1]CustomerID:2
	End if 
	$es:=ds:C1482.Cheques.query("CustomerID = :1"; $customerID)  // find the cheques with the same customer ID
	If ($es.length>0)
		$coll:=$es.toCollection("PayTo").distinct("PayTo")
		COLLECTION TO ARRAY:C1562($coll; $self->)
		
		INSERT IN ARRAY:C227($self->; 1; 2)
		$self->{0}:=[Cheques:1]PayTo:15
		$self->{1}:=<>CompanyName
		$self->{2}:=[Customers:3]FullName:40
	End if 
	
End if 

If ((Form event code:C388=On Data Change:K2:15) | (Form event code:C388=On Clicked:K2:4))
	[Cheques:1]PayTo:15:=$self->{$self->}
End if 


//handleComboFromField (Self;->[Cheques]PayTo;->[Cheques]PayTo)
