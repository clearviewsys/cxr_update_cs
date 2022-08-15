//%attributes = {}
// -------------------------------------------------------------------
// Method: GAML_GetFileName ({$suffix}; {$refDate}; {$refTime}) -> (string) FileName
// Create and returs a file Name using an static date and Hour
//
// -------------------------------------------------------------------
// Created by Jaime Alvarez, 02/11/2016
// -------------------------------------------------------------------

C_DATE:C307($1; $dateRef)
C_TEXT:C284($2; $suffix)
C_TEXT:C284($3; $folder)
C_TEXT:C284($0; $refDateStr; $refTime)
C_TIME:C306($vdoc)



Case of 
		
	: (Count parameters:C259=3)
		
		$dateRef:=$1
		$suffix:=$2
		$folder:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


C_TEXT:C284($refHour; $fileName)
$refDateStr:=FT_GetStringDate($dateRef)
$refHour:=FT_GetStringTime

$fileName:=$folder+$refDateStr+"_"+$refHour
$fileName:=$fileName+$suffix

$vdoc:=Create document:C266($fileName)
If (OK=1)
	CLOSE DOCUMENT:C267($vdoc)
End if 

If ($folder#"")
	$0:=$fileName
Else 
	$0:=""
End if 

