//%attributes = {}
// FJ_FormatDate ({$refDate};{$century})
// Format date for FIJI Reports using the century

C_DATE:C307($1; $refDate)
C_TEXT:C284($0; $dateStr)
C_LONGINT:C283($yy; $mm; $dd)
C_BOOLEAN:C305($century)

Case of 
	: (Count parameters:C259=0)
		
		$refDate:=Current date:C33(*)
		$century:=False:C215
		
	: (Count parameters:C259=1)
		
		$refDate:=$1
		$century:=False:C215
		
	: (Count parameters:C259=2)
		
		$refDate:=$1
		$century:=$2
End case 
$yy:=Year of:C25($refDate)
$mm:=Month of:C24($refDate)
$dd:=Day of:C23($refDate)

$dateStr:=String:C10($yy; "0000")+String:C10($mm; "00")+String:C10($dd; "00")

//If ($century)
//$dateStr:="20"+$dateStr
//End if 

$0:=$dateStr
