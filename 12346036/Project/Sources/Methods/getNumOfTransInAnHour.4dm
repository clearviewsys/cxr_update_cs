//%attributes = {}
// getNumOfTransInAnHour (hour24; {fromDate {;toDate}})
// this method counts the number of transactions in 1 hour 


C_LONGINT:C283($num; $1; $count)
C_DATE:C307($date; $toDate; $2; $3)

Case of 
	: (Count parameters:C259=1)
		$num:=$1
		$Date:=calcBOMonth(Current date:C33)
		$Todate:=Current date:C33
		
	: (Count parameters:C259=2)
		$num:=$1
		$date:=$2
		$toDate:=Add to date:C393($date; 0; 0; 7)
		
	: (Count parameters:C259=3)
		$num:=$1
		$date:=$2
		$toDate:=$3
		
	Else 
		$date:=makeDate(1; 1; 2014)
		$toDate:=Current date:C33
		
		$num:=13
End case 


C_TIME:C306($fromTime; $toTime)
$fromTime:=($num*3600)
$toTime:=$fromTime+?01:00:00?


SET QUERY DESTINATION:C396(Into variable:K19:4; $count)

QUERY:C277([Registers:10]; [Registers:10]RegisterDate:2>=$date; *)
QUERY:C277([Registers:10];  & ; [Registers:10]RegisterDate:2<=$toDate; *)
QUERY:C277([Registers:10];  & ; [Registers:10]Currency:19#<>BASECURRENCY; *)

QUERY:C277([Registers:10];  & ; [Registers:10]CreationTime:15>=$fromTime; *)
QUERY:C277([Registers:10];  & ; [Registers:10]CreationTime:15<$toTime)

SET QUERY DESTINATION:C396(Into current selection:K19:1)

$0:=$count

