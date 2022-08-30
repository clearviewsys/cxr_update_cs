//%attributes = {}
// -------------------------------------------------------------------
// Method: JAM_GetFileName ({$prefix}; {$refDate}) -> (string) FileName
// Create and returs a file Name using an static prefix and date 
//
// -------------------------------------------------------------------
// Created by Jaime Alvarez, 02/07/2020
// -------------------------------------------------------------------

C_TEXT:C284($1)
C_DATE:C307($2)
C_TIME:C306($3)
C_TEXT:C284($0; $refDateStr; $prefix)
C_TIME:C306($vdoc)
C_LONGINT:C283($next)

Case of 
		
	: (Count parameters:C259=0)
		$prefix:="BKEX"
		$refDateStr:=FT_GetStringDate
		
	: (Count parameters:C259=1)
		$prefix:=$1
		$refDateStr:=FT_GetStringDate
		
	: (Count parameters:C259=2)
		$prefix:=$1
		$refDateStr:=FT_GetStringDate($2)
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 
C_TEXT:C284($outputPath; $msg; $folder; $fileName; $format)

$outputPath:=getFilePathByID("JAM_ReportingOutputPath")

$msg:="Select a folder where the Report will be saved."

If ($outputPath="")
	$folder:=Select folder:C670($msg; Desktop:K41:16)
Else 
	$folder:=Select folder:C670($msg; $outputPath)
End if 

$next:=1
$fileName:=$folder+$prefix+Substring:C12($refDateStr; 5; 4)+FT_NumberFormat($next; 0; 2; "0")+".TXT"

While (Test path name:C476($fileName)=Is a document:K24:1)
	$next:=$next+1
	
	// Only We have 2 digits for the sequence
	If ($next=100)
		$next:=1
	End if 
	
	$format:=FT_NumberFormat($next; 0; 2; "0")
	$fileName:=$folder+$prefix+Substring:C12($refDateStr; 5; 4)+$format+".txt"
End while 

$vdoc:=Create document:C266($fileName)
If (OK=1)
	CLOSE DOCUMENT:C267($vdoc)
End if 

If ($folder#"")
	$0:=$fileName
Else 
	$0:=""
End if 

