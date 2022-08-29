//%attributes = {}
If (True:C214)
	
	//===================== Declare Variables ==================================
	//method_parameters_declarations
	//--------------------------------------------------------------------------
	//method_wide_constants_declarations
	//--------------------------------------------------------------------------
	//local_variable_declarations
	C_LONGINT:C283($Params_L; $maxProcId_l; $countTask_l; $procNum_l; \
		$procState_l; $procUniqueID_l; $procOrigin_l)
	C_TEXT:C284($procName_t)
	C_TIME:C306($procTime_h)
	C_BOOLEAN:C305($procVisible_b)
	
End if 
//====================== Initialize and Setup ================================

$Params_L:=Count parameters:C259

// "Count tasks" returns the total number of processes open, 
// not necessarily the highest process number for a given process, so
// MAXINT is used as a number that can be reasonablly assumed greater 
// than any number of processes that would have been opened since startup
//
$maxProcId_l:=MAXINT:K35:1
$countTask_l:=0

//======================== Method Actions ==================================

For ($procNum_l; 1; $maxProcId_l)
	PROCESS PROPERTIES:C336($procNum_l; $procName_t; $procState_l; \
		$procTime_h; $procVisible_b; $procUniqueID_l; $procOrigin_l)
	If ($procState_l>=Aborted:K13:1)  // *** Process is recongnized by 4D even if it is marked as aborted
		
		// *** If the process is running and it is a user process.
		If ($procOrigin_l>=None:K36:11)
			Case of 
				: ($procState_l=Paused:K13:6)
					RESUME PROCESS:C320($procNum_l)
				: ($procState_l=Delayed:K13:2)
					// DELAY PROCESS($procNum_l;0)
					RESUME PROCESS:C320($procNum_l)  // as adviced by Kirk Brooks at https://kb.4d.com/assetid=77516
					
			End case 
			
		End if 
		$countTask_l:=$countTask_l+1
	End if 
	
	If ($countTask_l>=Count tasks:C335)  // *** Found all opened processes
		$procNum_l:=$maxProcId_l+1  // *** Time to get out of the loop
	End if 
End for 
