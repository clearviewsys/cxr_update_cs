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
C_OBJECT:C1216($logTablePtr)
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
		C_TEXT:C284($postfix)
		$postfix:="im/account/"+IdentityMindEndpoint+"/"+IdentityMindID
		IdentityMindResponse:=IdentityMind_httpRequest(HTTP GET method:K71:1; $postfix)
		$log.Report:=JSON Stringify:C1217(IdentityMindResponse)
		$log.save()
	End if 
	
	ASSERT:C1129(IdentityMindID#"")
	ASSERT:C1129(IdentityMindEndpoint#"")
	ASSERT:C1129(IdentityMindStage#"")
	ASSERT:C1129(IdentityMindResponse#Null:C1517)
	
	
	// === PART 3: Show the response
	C_LONGINT:C283($winRef)
	$winRef:=Open form window:C675("IdentityMind_DetailReport"; Plain form window:K39:10; Horizontally centered:K39:1; Vertically centered:K39:4)
	DIALOG:C40("IdentityMind_DetailReport"; IdentityMindResponse)
	CLOSE WINDOW:C154($winRef)
End if 