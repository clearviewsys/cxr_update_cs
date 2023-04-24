//%attributes = {}
// GAML_Get_Wires_Transactions
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
$maxLimitRemittance:=<>thresholdForPTRTransfers

C_OBJECT:C1216($customers; $wires)
ARRAY TEXT:C222($customersIds; 0)

$wires:=ds:C1482.Wires.query("WireTransferDate >= :1 AND WireTransferDate <= :2"; $refStartDate; $refEndDate)
$wires:=$wires.query("AmountLocal >= :1"; $maxLimitRemittance)

//$wires:=$wires.query("isOutgoingWire == :1";True)
//$wires:=$wires.query("BeneficiaryBankCountryCode != 'NZ'")

USE ENTITY SELECTION:C1513($wires)



//QUERY SELECTION([Wires];[Wires]BeneficiaryBankCountryCode#"NZ")
CREATE EMPTY SET:C140([Wires:8]; "$set1")
FIRST RECORD:C50([Wires:8])

While (Not:C34(End selection:C36([Wires:8])))
	
	QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=[Wires:8]CustomerID:2)
	
	If (([Customers:3]isInsider:102=False:C215) & ([Customers:3]isMSB:85=False:C215) & ([Customers:3]isWholesaler:87=False:C215) & ([Customers:3]AML_doNotReport:153=False:C215))
		
		If (GAML_isIntlWire)
			ADD TO SET:C119([Wires:8]; "$set1")
		End if 
		
	End if 
	
	NEXT RECORD:C51([Wires:8])
	
End while 

USE SET:C118("$set1")
CLEAR SET:C117("$set1")

CLEAR VARIABLE:C89(arrALLEFT)
SELECTION TO ARRAY:C260([Wires:8]WireNo:48; arrALLEFT)

