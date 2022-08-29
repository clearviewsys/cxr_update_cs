//%attributes = {}
// filterRegistersInDateRange (from; to ; applyDateRange)
C_DATE:C307($1; $2)
C_BOOLEAN:C305($3)

If ($3)
	QUERY SELECTION:C341([Registers:10]; [Registers:10]RegisterDate:2>=$1; *)
	QUERY SELECTION:C341([Registers:10];  & ; [Registers:10]RegisterDate:2<=$2)
End if 
