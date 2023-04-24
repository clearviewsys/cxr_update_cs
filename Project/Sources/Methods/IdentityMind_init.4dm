//%attributes = {}
// IdentityMind_init({$stage})
// Setup the declare most upper camel case process variables
//
// Parameters:
// $runEnviornment (C_Real)
//     IdentityMind environment to use:
//      - -1 = system pick
//      -  0 = sandbox mode
//      -  1 = production mode
//      -  2 = staging mode
//
// Return:
//      success/ fail

// === PART 1: Setup ===

C_REAL:C285($1; $stage)  // (optional) 0 = sandbox; 1 = production; 2 = staging
C_BOOLEAN:C305($0)  // success / fail
Case of 
	: (Count parameters:C259=0)
		$stage:=-1
	: (Count parameters:C259=1)
		$stage:=$1
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 
$0:=False:C215

// === PART 2: Activiation Check ===
C_TEXT:C284($activated)
EXECUTE METHOD:C1007("getKeyValue"; $activated; "identityMind.activated"; "false")
C_TEXT:C284($msg)
If ($activated#"true")
	$msg:="IdentityMind is not activiated. Please contact support to setup activiation."
	myAlert($msg)
	
Else 
	
	// === PART 3: Declare empty proccess variables ===
	
	C_TEXT:C284(IdentityMindEndpoint; IdentityMindID)
	C_OBJECT:C1216(IdentityMindResponse; IdentityMindInput)
	IdentityMindEndpoint:=""
	IdentityMindID:=""
	IdentityMindResponse:=Null:C1517
	IdentityMindInput:=New object:C1471
	
	// === PART 5: Creditials variables setup ===
	
	C_TEXT:C284(IdentityMindPass; IdentityMindStage; IdentityMindUser)
	C_BOOLEAN:C305($allowChange)
	$allowChange:=True:C214
	
	If ($stage=-1)
		$stage:=1
	Else 
		$allowChange:=False:C215
	End if 
	
	If ($stage=1)
		IdentityMindStage:="edna"
		EXECUTE METHOD:C1007("getKeyValue"; IdentityMindUser; "identityMind.production.user")
		EXECUTE METHOD:C1007("getKeyValue"; IdentityMindPass; "identityMind.production.pass")
		If ((IdentityMindPass="") | (IdentityMindUser=""))
			If ($allowChange)
				$stage:=2
			End if 
		End if 
	End if 
	
	If ($stage=2)
		IdentityMindStage:="staging"
		EXECUTE METHOD:C1007("getKeyValue"; IdentityMindUser; "identityMind.staging.user")
		EXECUTE METHOD:C1007("getKeyValue"; IdentityMindPass; "identityMind.staging.pass")
		If ((IdentityMindPass="") | (IdentityMindUser=""))
			If ($allowChange)
				$stage:=0
			End if 
		End if 
	End if 
	
	If ($stage=0)
		IdentityMindStage:="sandbox"
		EXECUTE METHOD:C1007("getKeyValue"; IdentityMindUser; "identityMind.sandbox.user")
		EXECUTE METHOD:C1007("getKeyValue"; IdentityMindPass; "identityMind.sandbox.pass")
	End if 
	
	If ((IdentityMindPass="") | (IdentityMindUser=""))
		ALERT:C41("Missing IdentityMind credentials.")
	Else 
		$0:=True:C214
	End if 
End if 