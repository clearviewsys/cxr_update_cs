//%attributes = {}
// loadRelatedRegisters
C_POINTER:C301($tablePtr; $1)
C_POINTER:C301($foreignKey; $2)
Case of 
	: (Count parameters:C259=0)
		$tablePtr:=->[Invoices:5]
		$foreignKey:=->[Registers:10]InvoiceNumber:10
		
	: (Count parameters:C259=2)
		$tablePtr:=$1
		$foreignKey:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// the following code can be made to be generic getBuild
C_LONGINT:C283($row)

C_TEXT:C284($namedSelection; $selected; $rowSelection)
$namedSelection:="$Invoice_NS"
$selected:="$Invoices_LBSet"
$rowSelection:="$registers"
$row:=Selected record number:C246($tablePtr->)
COPY NAMED SELECTION:C331($tablePtr->; $namedSelection)  // store the original selection of records

If (Records in set:C195("$Invoices_LBSet")>0)
	USE SET:C118($selected)  // will only selection the highlighted rows
	RELATE MANY SELECTION:C340($foreignKey->)  // map all registers that are connected to the current seelction of records in the invoice table
	USE NAMED SELECTION:C332($namedSelection)  // restore the records as before with same order
	LISTBOX SELECT ROW:C912(*; "LB_Customers_Invoices"; $row)
Else 
	RELATE MANY SELECTION:C340($foreignKey->)
End if 

CLEAR NAMED SELECTION:C333($namedSelection)