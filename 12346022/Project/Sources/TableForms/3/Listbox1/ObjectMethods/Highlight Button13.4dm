C_LONGINT:C283($n)
$n:=6

QUERY:C277([Customers:3]; [Customers:3]AML_LastSanctionListCheckDate:99<=(Add to date:C393(Current date:C33; 0; -$n; 0)))

orderbyCustomers