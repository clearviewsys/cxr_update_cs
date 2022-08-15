//%attributes = {}
// JAM_HandleGenerateGLReport
// Valdiate and Generate the Bank of Jamaica GL Report
// Author: JA

ARRAY TEXT:C222(arrALLRegisterID; 0)
ARRAY TEXT:C222(arrALLEFT; 0)

checkInit
JAM_ValidateInfo
JAM_confirmProductionReport

If (isValidationConfirmed)
	Case of 
		: (cboGLReport=1)
			JAM_GL_Report
			
		: (cboGLReport=2)
			JAM_GL_DraftsAndWiresReport
			
	End case 
	
	
	JAM_UpdatePrefs
	FORM GOTO PAGE:C247(3)  // Report View
	
End if 

