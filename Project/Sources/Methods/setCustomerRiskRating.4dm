//%attributes = {}
// setCustomerRiskRating (customerEntity; risk:int)
// this method assigns the risk to the customer entity. it also sets the high-risk three-state checkbox state
// to an appropriate state based on the risk.
// if risk is 4,5 it is high-risk
// if risk is 1,2,3 it is low-risk
// if risk is 0 it is unassigned

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
	
	$custEntity.AML_RiskRating:=$risk
	If ($risk>=4)  // 4 and 5 are high risk
		$custEntity.AML_HighRisk:=1  // High Risk
	Else 
		If ($risk=0)
			$custEntity.AML_HighRisk:=0  // unassigned risk
		Else 
			$custEntity.AML_HighRisk:=2  // not high risk (1,2,3)
		End if 
	End if 
End if 
