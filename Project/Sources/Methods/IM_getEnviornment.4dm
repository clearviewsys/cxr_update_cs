//%attributes = {}
// IM_getEnvironment
// Gets the available IdentityMind Environment
//
// Return
//    The of environment being using if stage parameter = -1 or not given


// Note to IdentityMind Component Programmer:
// Most command starts with "IM_" (shared component methods) must to require run:
// - IdentityMind_init prefixed command as this:
//   declare all IdentityMind prefixed variables

C_TEXT:C284($0)  // IdentityMind Environment
Case of 
	: (Count parameters:C259=0)
		
	Else 
		EXECUTE METHOD:C1007("assertInvalidNumberOfParams"; *; Current method name:C684; Count parameters:C259)
End case 

If (IdentityMind_init)
	$0:=IdentityMindStage
Else 
	$0:=""
End if 