//PUSH RECORD([eWires])

setNextCustomer([eWires:13]CustomerID:15)

newRecordLinks

//POP RECORD([eWires])
If (OK=1)
	selectLinksByCustIDnCountry
End if 