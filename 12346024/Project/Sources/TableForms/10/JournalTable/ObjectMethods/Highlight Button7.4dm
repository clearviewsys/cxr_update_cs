C_LONGINT:C283(cbQuerySelection)
C_REAL:C285($limit)
$limit:=Num:C11(Request:C163("What is the limit for large cash?"; String:C10(<>oneIDLimit)))

If (cbQuerySelection=1)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]DebitLocal:23>=$limit; *)
	QUERY SELECTION:C341([Registers:10];  | ; [Registers:10]CreditLocal:24>=$limit)
	
Else 
	QUERY:C277([Registers:10]; [Registers:10]DebitLocal:23>=$limit; *)
	QUERY:C277([Registers:10];  | ; [Registers:10]CreditLocal:24>=$limit)
End if 
QUERY SELECTION:C341([Registers:10]; [Registers:10]CustomerID:5#getSelfCustomerID)  //  filter out internal registers

CREATE SET:C116([Registers:10]; "$LargeSet")

RELATE ONE SELECTION:C349([Registers:10]; [Accounts:9])  //  select all related accounts for these large transactions
QUERY SELECTION:C341([Accounts:9]; [Accounts:9]isCashAccount:3=True:C214)  // select the cash accounts only
RELATE MANY SELECTION:C340([Registers:10]AccountID:6)  // reflect back all the cash accounts into registers again

CREATE SET:C116([Registers:10]; "$CashSet")
CREATE EMPTY SET:C140([Registers:10]; "$LargeCashSet")
INTERSECTION:C121("$LargeSet"; "$CashSet"; "$LargeCashSet")
USE SET:C118("$LargeCashSet")

orderByRegisters
reg_fillRegistersListBox

CLEAR SET:C117("$LargeSet")
CLEAR SET:C117("$CashSet")
CLEAR SET:C117("$LargeCashSet")