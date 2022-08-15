//%attributes = {}
// -------------------------------------------------------------------
// Method: FJ_GetFileName ({$suffix}; {$refDate}; {$refTime}) -> (string) FileName
// Create and returs a file Name using an static date and Hour
//
// -------------------------------------------------------------------
// Created by Jaime Alvarez, 02/11/2016
// -------------------------------------------------------------------

C_DATE:C307($1; $dateRef)
C_TEXT:C284($2; $suffix)
C_TEXT:C284($3; $folder)
C_TEXT:C284($0; $refDateStr; $refTime; $refHour; $fileName)
C_TIME:C306($vdoc)



Case of 
		
	: (Count parameters:C259=3)
		
		$dateRef:=$1
		$suffix:=$2
		$folder:=$3
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$refDateStr:=Substring:C12(FT_GetStringDate($dateRef); 3)

$refHour:=FT_GetStringTime

$fileName:=$suffix+$refDateStr+"001"

C_LONGINT:C283($i)
$i:=0

While (Test path name:C476($folder+$fileName)=Is a document:K24:1)
	$i:=$i+1
	$fileName:=$suffix+$refDateStr+String:C10($i; "000")
End while 

$fileName:=$folder+$fileName+".txt"
$vdoc:=Create document:C266($fileName)
If (OK=1)
	CLOSE DOCUMENT:C267($vdoc)
End if 

If ($folder#"")
	$0:=$fileName
Else 
	$0:=""
End if 

