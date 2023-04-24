//%attributes = {}
// date2Serial ( Date ) -> int

// returns the ellapsed number of month from a certain date origin


C_LONGINT:C283($0; $month)
C_DATE:C307($1; $date)

$date:=$1
//If (◊dateOrder=1)  ` mm/dd/yy

// $month:=Num(Substring(String($date);1;2))

//Else   ` dd/mm/yy

// $month:=Num(Substring(String($date);4;2))

//End if 


$month:=Month of:C24($date)

$0:=(Year of:C25($date)-1800)*12+($month)

