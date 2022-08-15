//%attributes = {}
// FT_GetStringDate($date) -> String date in format YYYYMMDD
// Converts a date in format YYYYMMDD

C_DATE:C307($1; $refDate)
C_TEXT:C284($0; $dateSeparator)

Case of 
	: (Count parameters:C259=0)
		$refDate:=Current date:C33(*)
		$dateSeparator:=""
		
	: (Count parameters:C259=1)
		$refDate:=$1
		$dateSeparator:=""
		
	: (Count parameters:C259=2)
		$refDate:=$1
		$dateSeparator:=$2
		
		
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

C_LONGINT:C283($yyyy; $mm; $dd)
$yyyy:=Year of:C25($refDate)
$mm:=Month of:C24($refDate)
$dd:=Day of:C23($refDate)

$0:=FT_NumberFormat($yyyy; 0; 4)+$dateSeparator+FT_NumberFormat($mm; 0; 2)+$dateSeparator+FT_NumberFormat($dd; 0; 2)





