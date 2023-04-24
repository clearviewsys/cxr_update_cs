//%attributes = {}
// JAM_GetGLTransactions
// Query Transactions for GL Report

C_BOOLEAN:C305($1; $useBaseCurr; $2; $exported)
C_OBJECT:C1216($0; $registers; $r)
ARRAY TEXT:C222($arrRegID; 0)

Case of 
		
	: (Count parameters:C259=0)
		$useBaseCurr:=False:C215
		$exported:=False:C215
		
	: (Count parameters:C259=1)
		$useBaseCurr:=$1
		$exported:=False:C215
		
	: (Count parameters:C259=2)
		$useBaseCurr:=$1
		$exported:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_TEXT:C284($query)

$query:=""
$query:=$query+"RegisterDate >= :1 AND "
$query:=$query+"RegisterDate <= :2 AND "

If ($useBaseCurr)
	$query:=$query+"Currency == :3 AND "
Else 
	$query:=$query+"Currency != :3 AND "
	
End if 
//$query:=$query+"RegisterType='Buy' AND " )
$query:=$query+"isExported = :4 AND "
$query:=$query+"isCash = true AND "
$query:=$query+"isCancelled = false AND "
$query:=$query+"isTransfer = false  AND "

// Filter only "Sell" Transactions
$query:=$query+"RegisterType = 'Sell' AND "
$query:=$query+" ( CreditLocal >0 OR DebitLocal > 0 ) "

$registers:=ds:C1482.Registers.query($query; fromDate; toDate; <>baseCurrency; $exported)
$registers:=$registers.orderBy("RegisterID")

$0:=$registers


If (Not:C34($exported))
	REDUCE SELECTION:C351([Registers:10]; 0)
	
	For each ($r; $registers)
		APPEND TO ARRAY:C911($arrRegID; $r.RegisterID)
	End for each 
	
	READ ONLY:C145([Registers:10])
	QUERY WITH ARRAY:C644([Registers:10]RegisterID:1; $arrRegID)
	
End if 
