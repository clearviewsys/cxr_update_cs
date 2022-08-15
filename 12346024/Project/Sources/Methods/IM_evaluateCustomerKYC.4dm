//%attributes = {}
// IM_evaluateCustomerKYC($customer;{$runEnviornment})
// Evaluate a customer using the current [Customers] record
//
// Parameters:
// $customerTablePtr (C_OBJECT of [Customers] Entity)
//     where to extract customer data 
// $logTablePtr (C_Pointer to [IM_KYCLog])
//     where to store the log data
// $runEnviornment (C_Real)
//     IdentityMind environment to use:
//      - -1 = system pick
//      -  0 = sandbox mode
//      -  1 = production mode
//      -  2 = staging mode
//
// Return:
//     Results store as IM_KYCLog Entity

// Note to IdentityMind Component Programmer:
// Most command starts with "IM_" (shared component methods) must to require run:
// - IdentityMind_init which declare all IdentityMind prefixed variables

// === PART 1: Setup ===

C_OBJECT:C1216($0; $resultLog)  // IdentityMindResponse
C_OBJECT:C1216($1; $customer)  // pointer to [Customers]
C_REAL:C285($2; $stage)  // // -1 = system pick; 0 = sandbox; 1 = production; 2 = staging

$resultLog:=Null:C1517

Case of 
	: (Count parameters:C259=1)
		$customer:=$1
		$stage:=-1
	: (Count parameters:C259=2)
		$customer:=$1
		$stage:=$2
		ASSERT:C1129(($stage>-1) & ($stage<3); "Unknown stage number: "+String:C10($stage))
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 


If (IdentityMind_init($stage))
	
	// Set IdentityMindEndpoint
	If ($customer.isCompany)
		IdentityMindEndpoint:="merchant"
	Else 
		IdentityMindEndpoint:="consumer"
	End if 
	
	// === PART 3: Load, validate and send data 
	
	// Validation components lists
	
	C_BOOLEAN:C305($pass)
	$pass:=IdentityMind_loadKYCData($customer)
	
	If ($pass)
		If (IdentityMind_sendData(IdentityMindInput))
			$resultLog:=ds:C1482.IM_KYCLog.new()
			
			$resultLog.IdentityMindID:=IdentityMindResponse.mtid
			$resultLog.CustomerID:=$Customer.CustomerID
			
			$resultLog.Endpoint:=IdentityMindEndpoint
			$resultLog.Environment:=IdentityMindStage
			
			$resultLog.Report:=JSON Stringify:C1217(IdentityMindResponse)
			$resultLog.ResponseDate:=Current date:C33(*)
			$resultLog.ResponseTime:=Current time:C178(*)
			
			$resultLog.FraudRuleNameFired:=IdentityMindResponse.frn
			$resultLog.FraudRuleDetailFired:=IdentityMindResponse.frd
			$resultLog.State:=IdentityMindResponse.state
			
			$resultLog.save()
			$0:=$resultLog
		End if 
	End if 
End if 