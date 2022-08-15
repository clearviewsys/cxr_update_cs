//%attributes = {}
// -------------------------------------------------------------------
// Method: FT_GetFileName ({$suffix}; {$refDate}; {$refTime}) -> (string) FileName
// Create and returs a file Name using an static date and Hour
//
// -------------------------------------------------------------------
// Created by Jaime Alvarez, 02/11/2016
// -------------------------------------------------------------------

C_TEXT:C284($1)
C_DATE:C307($2)
C_TIME:C306($3)
C_TEXT:C284($0; $refDateStr; $refTime; $suffix)
C_TIME:C306($vdoc)
C_TEXT:C284($refHour; $outputPath; $msg; $folder; $fileName)
Case of 
		
	: (Count parameters:C259=0)
		$suffix:="_LCTR.TXT"
		$refDateStr:=FT_GetStringDate(initialDate)
		$refHour:=FT_GetStringTime
		
	: (Count parameters:C259=1)
		$suffix:=$1+".TXT"
		$refDateStr:=FT_GetStringDate(initialDate)
		$refHour:=FT_GetStringTime
		
	: (Count parameters:C259=2)
		$suffix:=$1+".TXT"
		$refDateStr:=FT_GetStringDate($2)
		$refHour:=FT_GetStringTime
		
	: (Count parameters:C259=3)
		$suffix:=$1+".TXT"
		$refDateStr:=FT_GetStringDate($2)
		$refHour:=FT_GetStringTime($3)
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$outputPath:=getKeyValue("AML.Reporting.CA.default.out.path"; "")
$msg:="Select a folder where the Report will be saved."

If ($outputPath="")
	$folder:=Select folder:C670($msg; Desktop:K41:16)
Else 
	$folder:=Select folder:C670($msg; $outputPath)
End if 

$outputPath:=setKeyValue("AML.Reporting.CA.default.out.path"; $folder)

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

