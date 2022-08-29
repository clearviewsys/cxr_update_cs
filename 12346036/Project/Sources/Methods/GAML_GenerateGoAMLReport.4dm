//%attributes = {}
// ------------------------------------------------------------------------------
// Method: GAML_GenerateGoAMLReport ({$fileName})
// Generate the XML Report for goAML Platform
//
// Parameters: 
//   $1: FileName (string - optional)
//
// Return:
//   None
// ------------------------------------------------------------------------------
// Jaime Alvarez, 8/9/2017
// ------------------------------------------------------------------------------
C_TEXT:C284($1; $fileName)
C_DATE:C307($refDate)
C_TEXT:C284($folder)


Case of 
	: (Count parameters:C259=0)
		$fileName:=""
		
	: (Count parameters:C259=1)
		$fileName:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Get the config information from the goaml.ini saved in the active 4D Database Folder
//GAML_GetEntityAndContactInfo 

// Generate the XML Header

C_TEXT:C284(generatedFiles)
generatedFiles:="XML File(s) Generated for Transactions: "
$refDate:=initialDate

$folder:=Select folder:C670("Select a folder where the LCTR Report will be saved.")

If (ok=1)
	
	While ($refDate<=finalDate)
		
		Case of 
				
			: (cboReportType=1)
				GAML_Get_LCT_Transactions($refDate)
				
				If (Size of array:C274(arrFTRegisterID)>0)
					$fileName:=GAML_GetFileName($refDate; "_LCT.xml"; $folder)
					GAML_Generate_LCT_Report($fileName; $refDate)
				End if 
				
				
			: (cboReportType=2)
				
				GAML_Get_eWires_Transactions($refDate)
				If (Records in selection:C76([eWires:13])>0)
					$fileName:=GAML_GetFileName($refDate; "_EWIRES.xml"; $folder)
					GAML_Generate_eWires_Report($fileName; $refDate)
				End if 
				
				
			: (cboReportType=3)
				
				GAML_Get_Wires_Transactions($refDate)
				If (Records in selection:C76([Wires:8])>0)
					$fileName:=GAML_GetFileName($refDate; "_WIRES.xml"; $folder)
					GAML_Generate_Wires_Report($fileName; $refDate)
				End if 
				
				
		End case 
		
		$refDate:=Add to date:C393($refDate; 0; 0; 1)
		
	End while 
	
	myAlert(generatedFiles)
	
End if 

