//%attributes = {}
// setCustomer[Accounts]RiskRating (cusotmerEntity; int)
C_OBJECT:C1216($custEntity; $1)
C_LONGINT:C283($risk; $2)

Case of 
	: (Count parameters:C259=2)
		$custEntity:=$1
		$risk:=$2
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_OBJECT:C1216($status; $customerES)
//$customerES:=ds.query("CustomerID = :1";$customerID)

If ($custEntity#Null:C1517)
	ASSERT:C1129($custEntity#Null:C1517; "customer entity is null")
	
	$custEntity.RiskRating:=$risk
	If ($risk>=3)
		$custEntity.AML_HighRisk:=1
	Else 
		$custEntity.AML_HighRisk:=2
	End if 
End if 
