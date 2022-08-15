//%attributes = {}
// FT_Get_LCTR_InvoicesByRules ($dateref;->$invoicesPtr;->$invoices24hIndPtr)
// Set the 24Hours insidcator for the transactions according to the FINTRAC Specifications

C_DATE:C307($1; $refDate)
C_POINTER:C301($2; $invoicesPtr; $3; $invoices24hIndPtr)
C_TEXT:C284($4; $branch)
C_REAL:C285($totMarketRate)
C_DATE:C307($dayBefore)
C_LONGINT:C283($p; $i)

Case of 
		
		
	: (Count parameters:C259=3)
		$refDate:=$1
		$invoicesPtr:=$2
		$invoices24hIndPtr:=$3
		$branch:="ALL"
		
	: (Count parameters:C259=4)
		$refDate:=$1
		$invoicesPtr:=$2
		$invoices24hIndPtr:=$3
		$branch:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($inv; 0)
ARRAY REAL:C219($acum; 0)
ARRAY TEXT:C222($acumCustID; 0)
ARRAY TEXT:C222($acumInvxCust; 0)
ARRAY TEXT:C222($arrCustomersInv; 0)
ARRAY TEXT:C222($arrCustomersInvNoRep; 0)


READ ONLY:C145([ServerPrefs:27])
ALL RECORDS:C47([ServerPrefs:27])

READ ONLY:C145([Customers:3])

$dayBefore:=Add to date:C393($refDate; 0; 0; -1)

QUERY:C277([Invoices:5]; [Invoices:5]invoiceDate:44>=$refDate; *)
QUERY:C277([Invoices:5];  & ; [Invoices:5]isCancelled:84=False:C215; *)
QUERY:C277([Invoices:5];  & ; [Invoices:5]isAMLReported:45=False:C215; *)
QUERY:C277([Invoices:5];  & ; [Invoices:5]isLCT:76=True:C214)

If ($branch#"ALL")
	QUERY SELECTION:C341([Invoices:5]; [Invoices:5]BranchID:53=reportBranchId)
End if 

ORDER BY:C49([Invoices:5]; [Invoices:5]invoiceDate:44; >)

While (Not:C34(End selection:C36([Invoices:5])))
	
	// 24H Flag
	
	APPEND TO ARRAY:C911($invoicesPtr->; [Invoices:5]InvoiceID:1)
	
	If (Position:C15("24H"; [Invoices:5]AMLReportName:75)>0)
		APPEND TO ARRAY:C911($invoices24hIndPtr->; True:C214)
	Else 
		APPEND TO ARRAY:C911($invoices24hIndPtr->; False:C215)
	End if 
	
	NEXT RECORD:C51([Invoices:5])
	
End while 

SORT ARRAY:C229($invoicesPtr->; $invoices24hIndPtr->)





