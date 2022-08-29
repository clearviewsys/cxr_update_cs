//%attributes = {}
//Method: checkUserAttempts
//Purpose: On a failed login, incrament the number of user attempts
//          If a user has more than 3 attempts, lock the account for a period of time
//           If a user has more than 6 attempts, alert to contact sysAdmin
C_TEXT:C284($alertMessage)

$alertMessage:="Username or password incorrect"+Char:C90(Carriage return:K15:38)
If ([Users:25]numAttempts:35>=2)
	$alertMessage:=$alertMessage+"Password Reminder:"+[Users:25]Reminder:5+Char:C90(Carriage return:K15:38)
End if 
If ([Users:25]numAttempts:35>=3)
	[Users:25]nextAttemptTime:34:=Current time:C178+Time:C179(2^([Users:25]numAttempts:35-3)*30)
	$alertMessage:=$alertMessage+"Too many unsuccessful attempts, Please try again in "+String:C10(Time:C179(2^([Users:25]numAttempts:35-3)*30))+Char:C90(Carriage return:K15:38)
End if 
If ([Users:25]numAttempts:35>=6)
	$alertMessage:="Username or password incorrect"+Char:C90(Carriage return:K15:38)+\
		"You had "+String:C10([Users:25]numAttempts:35)+" unsuccessful attempts. Please contact your administrator."
End if 
myAlert($alertMessage; "Security Alert")

