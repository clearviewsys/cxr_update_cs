//%attributes = {}

// ----------------------------------------------------
// User name (OS): EURO EXCHANGE SPAIN SERVER
// Date and time: 07/16/20, 05:57:40
// ----------------------------------------------------
// Method: fixQR_ExportToHTMLBug
// Description
// 
// Method for workaround for QR Reports generated badly in HTML
// with lots of <br> tags, it will remove <br> tags from files chosen
//
// Parameters
// ----------------------------------------------------

C_TEXT:C284($doc; $htmlDoc)
C_LONGINT:C283($i; $progress; $numOfFiles)

ARRAY TEXT:C222($selectedFiles; 0)

$doc:=Select document:C905(""; "*"; "Choose QR HTML reports to clean"; Multiple files:K24:7; $selectedFiles)

If (OK=1)
	
	$numOfFiles:=Size of array:C274($selectedFiles)
	
	If ($numOfFiles>0)
		
		$progress:=Progress New
		
		For ($i; 1; $numOfFiles)
			
			Progress SET TITLE($progress; "Cleaning file "+$selectedFiles{$i})
			Progress SET MESSAGE($progress; "File "+String:C10($i)+" of "+String:C10($numOfFiles))
			Progress SET PROGRESS($progress; $i/$numOfFiles)
			
			If (Test path name:C476($selectedFiles{$i})=Is a document:K24:1)
				$htmlDoc:=Document to text:C1236($selectedFiles{$i}; "UTF-8")
				$htmlDoc:=Replace string:C233($htmlDoc; "<br>"; "")
				TEXT TO DOCUMENT:C1237($selectedFiles{$i}; $htmlDoc; "UTF-8")
			End if 
			
			
		End for 
		
		Progress QUIT($progress)
		
	End if 
	
End if 
