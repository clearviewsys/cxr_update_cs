//%attributes = {}
// setDateTimeUSer(->dateField;->timeField;->{userField})
// use this method inside triggers to assign administrative info about date, time and user
// the reason we check if date is null is we don't want to import old data and have the dates changed

C_POINTER:C301($1; $2; $3)

If ($1->=!00-00-00!)
	$1->:=Current date:C33
	$2->:=Current time:C178
End if 

Case of 
	: (Count parameters:C259=3)
		If ($3->="")
			$3->:=getApplicationUser
		End if 
End case 

