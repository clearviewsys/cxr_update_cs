//%attributes = {}
// isValidTime -> boolean

// this function returns true if the current time is suitable 

// for intenet live update quotes. This will prevent the server to receive

// the same quotes due to HTTP request cashing


//C_TIME($fromTime;$toTime)

//C_BOOLEAN($0)

//

//$fromTime:=◊fromTime

//$toTime:=◊ToTime


//If ((Current time>=$fromTime) & (Current time<=$toTime))

$0:=True:C214
//Else 

//$0:=False

//End if 