//%attributes = {}
// FJ_Get_Wires_Transactions
// Gets all transactions from Register Table required to report according to the Remittance goAML Requirements

// Define transaction arrays
C_DATE:C307($1; $refStartDate; $2; $refEndDate)
C_BOOLEAN:C305($exported)
C_REAL:C285($maxLimitRemittance)
ARRAY TEXT:C222($arrWiresId; 0)



Case of 
	: (Count parameters:C259=0)
		$refStartDate:=Current date:C33(*)
		$refEndDate:=Current date:C33(*)
		$exported:=False:C215
		
	: (Count parameters:C259=1)
		$refStartDate:=$1
		$refEndDate:=$1
		$exported:=False:C215
		
	: (Count parameters:C259=2)
		$refStartDate:=$1
		$refEndDate:=$2
		$exported:=False:C215
		
	: (Count parameters:C259=3)
		$refStartDate:=$1
		$refEndDate:=$2
		$exported:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


READ ONLY:C145([Wires:8])
$maxLimitRemittance:=0

QUERY:C277([Customers:3]; [Customers:3]isInsider:102=False:C215)  // we don't want insider
QUERY SELECTION:C341([Customers:3]; [Customers:3]isMSB:85=False:C215)
QUERY SELECTION:C341([Customers:3]; [Customers:3]isWholesaler:87=False:C215)

RELATE MANY SELECTION:C340([Wires:8]CustomerID:2)  // select all Wires belonging to non-insiders

QUERY SELECTION:C341([Wires:8]; [Wires:8]WireTransferDate:17>=$refStartDate; *)
QUERY SELECTION:C341([Wires:8];  & ; [Wires:8]WireTransferDate:17<=$refEndDate)
QUERY SELECTION:C341([Wires:8]; [Wires:8]isOutgoingWire:16=True:C214)

QUERY SELECTION:C341([Wires:8]; [Wires:8]AmountLocal:25>=$maxLimitRemittance)

QUERY SELECTION:C341([Wires:8]; [Wires:8]wasReported:76=False:C215)


//
ORDER BY:C49([Wires:8]; [Wires:8]CXR_WireID:1)

//While (Not(End selection([Wires])))
//APPEND TO ARRAY(arrALLEFT;[Wires]CXR_WireID)
//NEXT RECORD([Wires])
//End while 

SELECTION TO ARRAY:C260([Wires:8]CXR_WireID:1; arrALLEFT)

