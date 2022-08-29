
//C_TEXT($result; $name)
//C_LONGINT($match)

//$name:=makeFullName([Customers]FirstName; [Customers]LastName)
//C_POINTER($null)

sl_handleCustomerScreening(sl_CustomerPerson+sl_ForPEPButton)
//If (Length($name)>3)
//$match:=sl_handlePersonNameCompliance(True; $name; ->[Customers]CustomerID; \
New object("options"; New object("list"; "PEP"))\
)
//End if

SET TIMER:C645(-1)  // refresh the query
