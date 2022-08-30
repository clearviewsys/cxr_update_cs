//%attributes = {}
// AUS_GenerateAusFinalReport 
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
ARRAY TEXT:C222(arrInvoicesReport; 0)
ARRAY TEXT:C222(arrEwiresReport; 0)
ARRAY TEXT:C222(arrwiresReport; 0)
ARRAY TEXT:C222(arrFilesReport; 0)
C_TEXT:C284(filesErrorsList)
C_LONGINT:C283($i)

Case of 
	: (Count parameters:C259=0)
		$fileName:=""
		
	: (Count parameters:C259=1)
		$fileName:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

// Get the config information from the fiji.ini saved in the active 4D Database Folder
//FJ_GetEntityAndContactInfo 

// Generate the Report Header

C_TEXT:C284(generatedFiles)
generatedFiles:="File(s) Generated for Transactions: "

READ ONLY:C145([CompanyInfo:7])
ALL RECORDS:C47([CompanyInfo:7])

$refDate:=initialDate

$folder:=Select folder:C670("Select a folder where the Report will be saved.")

If (ok=1)
	
	While ($refDate<=finalDate)
		
		Case of 
				
			: (cboReportType=1)
				
				//AUS_Get_TTR_Transactions ($refDate)
				
				//If (Size of array(arrFTRegisterID)>0)
				$fileName:=AUS_GetFileName($refDate; "TTR-MSB"; $folder)
				AUS_Generate_TTR_Report($fileName; $refDate)
				//End if 
				
				
			: (cboReportType=2)
				
				//AUS_Get_IFTI_DRA_Transactions ($refDate)
				//If (Records in selection([eWires])>0)
				$fileName:=AUS_GetFileName($refDate; "IFTI-DRA"; $folder)
				AUS_Generate_IFTI_DRA_Report($fileName; $refDate)
				
				//End if 
				
				
				
				
			: (cboReportType=3)
				
				
				//If (Records in selection([Wires])>0)
				//myAlert ("Option in construction")
				$fileName:=AUS_GetFileName($refDate; "IFTI-DRA"; $folder)
				AUS_Generate_IFTI_DRA_Wires($fileName; $refDate)
				//End if 
				
				
				
				
			: (cboReportType=4)
				
				//AUS_Get_SMR_Transactions ($refDate)
				//If (Records in selection([AML_Reports])>0)
				myAlert("Option in construction")
				//$fileName:=AUS_GetFileName ($refDate;"E";$folder)
				//AUS_Generate_SMR_Report ($fileName;$refDate)
				//End if 
				
				
		End case 
		
		$refDate:=Add to date:C393($refDate; 0; 0; 1)
		
	End while 
	If (generatedFiles#"")
		myAlert(generatedFiles)
	End if 
	
	QUERY WITH ARRAY:C644([Invoices:5]InvoiceID:1; arrInvoicesReport)
	QUERY WITH ARRAY:C644([eWires:13]eWireID:1; arrEwiresReport)
	QUERY WITH ARRAY:C644([Wires:8]CXR_WireID:1; arrWiresReport)
	filesErrorsList:=""
	
	For ($i; 1; Size of array:C274(arrFilesReport))
		$fileName:=arrFilesReport{$i}
		
		If (hasInvalidTags($fileName))
			filesErrorsList:=filesErrorsList+"The File "+$fileName+CRLF+"Has invalid values in some tags. The file cannot be manually submitted to the AUSTRAC Platform. Please review!"+CRLF
		End if 
		
	End for 
	
	If (filesErrorsList#"")
		myAlert(filesErrorsList)
	End if 
	
End if 
