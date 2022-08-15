//%attributes = {}
// IM_updateKYCReport($log;{$runEnviornment})
// Get an update from IdentityMind on a Customer
//
// Parameters:
// $log (C_OBJECT to [IM_KYCLog])
//     Pointer to the log
// $runEnviornment (C_Real)
//     IdentityMind environment to use:
//      - -1 = system pick
//      -  0 = sandbox mode
//      -  1 = production mode
//      -  2 = staging mode
//
// Return: (None)

// Note to IdentityMind Component Programmer:
// Most command starts with "IM_" (shared component methods) must to require run:
// - IdentityMind_init which declare all IdentityMind prefixed variables

// === PART 1: Setup ===

C_OBJECT:C1216($1; $log)
C_REAL:C285($2; $stage)  // (optional) 0 = sandbox; 1 = production; 2 = staging
Case of 
	: (Count parameters:C259=1)
		$log:=$1
		$stage:=-1
	: (Count parameters:C259=2)
		$log:=$1
		$stage:=$2
		ASSERT:C1129(($stage>-1) & ($stage<3); "Unknown stage number: "+String:C10($stage))
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 


If (IdentityMind_init($stage))
	
	// === PART 2: Setup the fields
	
	IdentityMindID:=$log.IdentityMindID
	IdentityMindEndpoint:=$log.Endpoint
	ASSERT:C1129(IdentityMindStage=$log.Environment)
	IdentityMindResponse:=IdentityMind_parseJSON($log.Report)
	If (IdentityMindResponse=Null:C1517)
		IdentityMindResponse:=New object:C1471
	End if 
	
	// === PART 3: update the response
	If (IdentityMind_updateResponse)
		C_DATE:C307($date)
		$date:=Current date:C33(*)
		If ($date=$log.ResponseDate)
			
			$log.Report:=JSON Stringify:C1217(IdentityMindResponse)
			$log.ResponseDate:=Current date:C33(*)
			$log.ResponseTime:=Current time:C178(*)
			
			$log.FraudRuleNameFired:=IdentityMindResponse.frn
			$log.FraudRuleDetailFired:=IdentityMindResponse.frd
			$log.State:=IdentityMindResponse.state
			
			$log.save()
			$0:=$log
		Else 
			C_OBJECT:C1216($newLog)
			$newLog:=ds:C1482.IM_KYCLog.new()
			$newLog.IdentityMindID:=$log.IdentityMindID
			$newLog.CustomerID:=$log.CustomerID
			
			$newLog.Endpoint:=$log.Endpoint
			$newLog.Environment:=$log.Environment
			
			$newLog.Report:=JSON Stringify:C1217(IdentityMindResponse)
			$newLog.ResponseDate:=Current date:C33(*)
			$newLog.ResponseTime:=Current time:C178(*)
			
			$newLog.FraudRuleNameFired:=IdentityMindResponse.frn
			$newLog.FraudRuleDetailFired:=IdentityMindResponse.frd
			$newLog.State:=IdentityMindResponse.state
			
			$newLog.save()
			$0:=$newLog
		End if 
	End if 
End if 