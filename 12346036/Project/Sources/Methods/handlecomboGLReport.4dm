//%attributes = {}
// handlecomboGLReport
// Initialize Combo for GL Reports


Case of 
	: (Form event code:C388=On Load:K2:1)
		
		ARRAY TEXT:C222(cboGLReport; 2)
		CLEAR VARIABLE:C89(cboGLReport)
		
		APPEND TO ARRAY:C911(cboGLReport; "GL Report")
		APPEND TO ARRAY:C911(cboGLReport; "Drafs and Wires Report")
		cboGLReport:=1
End case 

