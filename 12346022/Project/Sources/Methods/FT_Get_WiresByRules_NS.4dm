//%attributes = {}
// FT_Get_WiresByRules_NS ($dateref;->$invoicesPtr;->$invoices24hIndPtr)
// Set the 24Hours insidcator for the transactions according to the FINTRAC Specifications

C_DATE:C307($1; $refDate)
C_POINTER:C301($2; $arrRecordsPtr; $3; $records24hIndPtr)
C_TEXT:C284($4; $branch)

Case of 
		
		
	: (Count parameters:C259=3)
		$refDate:=$1
		$arrRecordsPtr:=$2
		$records24hIndPtr:=$3
		$branch:="ALL"
		
	: (Count parameters:C259=4)
		$refDate:=$1
		$arrRecordsPtr:=$2
		$records24hIndPtr:=$3
		$branch:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ARRAY TEXT:C222($records; 0)
ARRAY REAL:C219($acum; 0)
ARRAY TEXT:C222($acumCustID; 0)
ARRAY TEXT:C222($acumxCust; 0)

READ ONLY:C145([ServerPrefs:27])
ALL RECORDS:C47([ServerPrefs:27])
C_DATE:C307($fromDate)

C_LONGINT:C283($i; $p)

$fromDate:=Add to date:C393($refDate; 0; 0; -1)

FT_Get_EFT_InvoicesByRules($refDate; $arrRecordsPtr; $records24hIndPtr)
QUERY WITH ARRAY:C644([Wires:8]CXR_InvoiceID:12; $arrRecordsPtr->)

CREATE SET:C116([Wires:8]; "efto")
USE SET:C118("efto")
FIRST RECORD:C50([Wires:8])

ORDER BY:C49([Wires:8]; [Wires:8]WireTransferDate:17; >)
