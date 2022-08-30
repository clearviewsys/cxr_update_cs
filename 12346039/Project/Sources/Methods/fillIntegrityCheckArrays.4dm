//%attributes = {}
C_LONGINT:C283($n)
$n:=13
ARRAY BOOLEAN:C223(arrToCheck; $n)
ARRAY TEXT:C222(arrCheckID; $n)
ARRAY TEXT:C222(arrDescription; $n)
ARRAY TEXT:C222(arrStatus; $n)

//For ($i;1;$n)
//arrToCheck{$i}:=True
//End for 

// arrCheckID : include the method name without the IC_ prefix


arrCheckID{1}:="AccountCurrencies"
arrDescription{1}:="Check the currency of journal registers with their respective account currency"

arrCheckID{2}:="ChequeCurrencies"
arrDescription{2}:="Check to see if cheques are handled in the right account currency"

arrCheckID{3}:="InvalidMainAccounts"
arrDescription{3}:="Check to see if accounts are linked to the right main account"

arrCheckID{4}:="InvoiceCustomers"
arrDescription{4}:="Check if journal customers are consistent with invoice customer"

arrCheckID{5}:="LinkAgents"
arrDescription{5}:="Check if links are connected to the right agent"

arrCheckID{6}:="RegisterRates"
arrDescription{6}:="Check if all rates are within the allowed treshhold"

arrCheckID{7}:="UnbalancedInvoices"
arrDescription{7}:="Check if there are any unbalanced invoices"

arrCheckID{8}:="eWireInvoiceID"
arrDescription{8}:="Check if eWires Invoice ID match with registers Invoice ID"

arrCheckID{9}:="eWireAccounts"
arrDescription{9}:="Check if eWires Account ID match with Journal registers"

arrCheckID{10}:="eWireCustomerID"
arrDescription{10}:="Check if eWires CustomerID is same as related  Link Customer ID"

arrCheckID{11}:="ChequeAccounts"
arrDescription{11}:="Check if cheque accounts are consistent with the registers accounts"

arrCheckID{12}:="InvalidAccounts"
arrDescription{12}:="Check if journal records are linked to corresponding accounts"

arrCheckID{13}:="OrphanRegisters"
arrDescription{13}:="Check if journal records are orphaned (lost their parent invoices)"


SORT ARRAY:C229(arrCheckID; arrDescription)
