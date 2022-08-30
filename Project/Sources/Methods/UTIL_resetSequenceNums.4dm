//%attributes = {}

C_TEXT:C284($tResult)
C_LONGINT:C283($iSeqNo)

$tResult:=""

C_LONGINT:C283($iProg; $i)
C_POINTER:C301($ptrTable; $ptrField)
C_LONGINT:C283($iMax)
C_REAL:C285($r)
$iProg:=Progress New

For ($i; 1; Get last table number:C254)
	If (Is table number valid:C999($i))
		$ptrTable:=Table:C252($i)
		
		
		Progress SET TITLE($iProg; "Validating: "+Table name:C256($ptrTable))
		$r:=$i/Get last table number:C254
		Progress SET PROGRESS($iProg; $r)
		
		$iSeqNo:=UTIL_resetSequenceNum($ptrTable)
		
		$tResult:=$tResult+Table name:C256($ptrTable)+" set to: "+String:C10($iSeqNo)+Char:C90(Carriage return:K15:38)
		
	End if 
	
	
	
End for 

Progress QUIT($iProg)

myAlert("The following table Seq No's have been reset:"+Char:C90(Carriage return:K15:38)+$tResult)