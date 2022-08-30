//%attributes = {}


ARRAY INTEGER:C220(arrHours; 24)
ARRAY LONGINT:C221(arrNumOfTrans; 24)
C_DATE:C307($fromDate; $toDate)

C_LONGINT:C283($i; $n)
$fromDate:=makeDate(1; 1; 2014)
$toDate:=Current date:C33



For ($i; 1; 24)
	arrHours{$i}:=$i
	arrNumOfTrans{$i}:=getNumOfTransInAnHour($i; $fromDate; $toDate)
	
End for 

