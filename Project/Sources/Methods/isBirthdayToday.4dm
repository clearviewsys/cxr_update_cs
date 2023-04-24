//%attributes = {}
// isBirthdayToday (dob) : boolean
// isBirthdayToday (dob: date; days: int) : boolean

// returns true if dob has a birthday today or 
// returns true if dob has a birthday in today + n days
// needs a unit-test
// Unit test is written @Tiran


C_DATE:C307($dob; $1)
C_DATE:C307($date)

C_BOOLEAN:C305($0)
$0:=False:C215

Case of 
	: (Count parameters:C259=1)
		$dob:=$1
		$date:=Current date:C33
	: (Count parameters:C259=2)
		$dob:=$1
		$date:=Add to date:C393(Current date:C33; 0; 0; $2)
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($dob#!00-00-00!)
	If ((Month of:C24($dob)=Month of:C24($date)) & (Day of:C23($dob)=Day of:C23($date)))
		$0:=True:C214
	End if 
End if 