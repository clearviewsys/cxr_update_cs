//%attributes = {}
// FJ_GenerateFijiFinalReport 
// Method: FJ_GenerateFijiFinalReport ({$fileName})
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
C_TEXT:C284($oldFileName; $msg)
C_BLOB:C604($blobReport)
ARRAY TEXT:C222(arrFileNames; 0)
ARRAY TEXT:C222(arrFileNamesErr; 0)
C_BOOLEAN:C305(missingErr)
missingErr:=False:C215

Case of 
	: (Count parameters:C259=0)
		$fileName:=""
		
	: (Count parameters:C259=1)
		$fileName:=$1
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

CREATE EMPTY SET:C140([Invoices:5]; "$allInvoices")
CREATE EMPTY SET:C140([eWires:13]; "$allEWires")
CREATE EMPTY SET:C140([Wires:8]; "$allWires")


// Get the config information from the fiji.ini saved in the active 4D Database Folder
//FJ_GetEntityAndContactInfo 

// Generate the Report Header

C_TEXT:C284(generatedFiles)
generatedFiles:="FIJI FIU File(s) Generated for Transactions: "
$refDate:=initialDate

$folder:=Select folder:C670("Select a folder where the CTR Report will be saved.")

If (ok=1)
	
	While ($refDate<=finalDate)
		
		Case of 
				
			: (cboReportType=1)
				
				FJ_Get_CTR_Transactions($refDate)
				
				//If (Records in selection([Invoices])>0)
				$fileName:=FJ_GetFileName($refDate; "S"; $folder)
				FJ_Generate_CTR_Report($fileName; $refDate)
				vcount:=Records in selection:C76([Invoices:5])
				
				//End if 
				
				
				
			: (cboReportType=2)
				
				FJ_Get_eWires_Transactions($refDate)
				If (Records in selection:C76([eWires:13])>0)
					$fileName:=FJ_GetFileName($refDate; "E"; $folder)
					//GAML_Generate_EWires_Report ($fileName;$refDate)
					FJ_Generate_EFTR_Report_Ewires($fileName; $refDate)
					CREATE SET:C116([eWires:13]; "$ewiresDaySet")
					UNION:C120("$ewiresDaySet"; "$allEwires"; "$allEwires")
				End if 
				vcount:=Records in selection:C76([eWires:13])
				
			: (cboReportType=3)
				
				FJ_Get_Wires_Transactions($refDate)
				If (Records in selection:C76([Wires:8])>0)
					$fileName:=FJ_GetFileName($refDate; "E"; $folder)
					FJ_Generate_EFTR_Report_Wires($fileName; $refDate)
					CREATE SET:C116([Wires:8]; "$wiresDaySet")
					UNION:C120("$wiresDaySet"; "$allWires"; "$allWires")
				End if 
				vcount:=Records in selection:C76([Wires:8])
				
		End case 
		
		$refDate:=Add to date:C393($refDate; 0; 0; 1)
		CREATE SET:C116([Invoices:5]; "$daySet")  // All reports get invoices
		UNION:C120("$daySet"; "$allInvoices"; "$allInvoices")
		
	End while 
	
	USE SET:C118("$allInvoices")
	ORDER BY:C49([Invoices:5]; [Invoices:5]invoiceDate:44)
	
	USE SET:C118("$allEWires")
	USE SET:C118("$allWires")
	
	CLEAR SET:C117("$allInvoices")
	CLEAR SET:C117("$daySet")
	CLEAR SET:C117("$allEWires")
	CLEAR SET:C117("$allWires")
	
	If (Size of array:C274(arrFileNames)>0)
		myAlert(generatedFiles)
	Else 
		$msg:="There are not transactions that can be reported in the date range requested"
		myAlert($msg)
		
	End if 
	
	C_LONGINT:C283($i)
	C_TEXT:C284($tmp)
	$tmp:="These files cannot be manually submitted to the FIJI FIU Platform:"+CRLF
	
	If (Size of array:C274(arrFileNamesErr)>0)
		For ($i; 1; Size of array:C274(arrFileNamesErr))
			$tmp:=$tmp+arrFileNamesErr{$i}+CRLF
		End for 
		
		myAlert($tmp)
	End if 
	
	
	
End if 
