//%attributes = {}
// -------------------------------------------------------------------
// Method: AUS_GetFileName ({$suffix}; {$refDate}; {$refTime}) -> (string) FileName
// Create and returs a file Name using an static date and Hour
//
// -------------------------------------------------------------------
// Created by Jaime Alvarez, 02/11/2016
// -------------------------------------------------------------------

C_DATE:C307($1; $dateRef)
C_TEXT:C284($2; $prefix)
C_TEXT:C284($3; $folder)
C_TEXT:C284($0; $refDateStr; $refTime)
C_TIME:C306($vdoc)



Case of 
		
	: (Count parameters:C259=3)
		
		$dateRef:=$1
		$prefix:=$2
		$folder:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$refDateStr:=FT_GetStringDate($dateRef)
C_LONGINT:C283($next)
C_TEXT:C284($format; $fileName)

$next:=FT_NextSequence($prefix; 1; True:C214)
$format:=FT_NumberFormat($next; 0; 2; "0")
$fileName:=$folder+$prefix+$refDateStr+$format+".xml"

While (Test path name:C476($fileName)=Is a document:K24:1)
	$next:=FT_NextSequence($prefix)
	$format:=FT_NumberFormat($next; 0; 2; "0")
	$fileName:=$folder+$prefix+$refDateStr+$format+".xml"
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

