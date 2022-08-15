//%attributes = {}
// checkIfPasswordMatches(password;{request message; {number of attempts allowed}})

C_TEXT:C284($password; $message; $1; $2)
C_TEXT:C284($passwordEntered)
C_LONGINT:C283($n; $i)

Case of 
	: (Count parameters:C259=1)
		$password:=$1
		$message:="Please enter the over-ride password"
		$n:=3
	: (Count parameters:C259=2)
		$password:=$1
		$message:=$2
		$n:=3
	: (Count parameters:C259=3)
		$password:=$1
		$message:=$2
		$n:=$3
	Else 
		$message:="Please enter override password:"
		$password:=<>overridePassword
		$n:=3
End case 

$i:=0

If (Not:C34(isUserAdministrator) & Not:C34(isUserManager))  // administrators and managers don't need override
	Repeat 
		$passwordEntered:=requestPassword($message)
		$i:=$i+1
	Until (($i=$n) | ($password=$passwordEntered) | (OK=0))
	checkAddErrorIf(($password#$passwordEntered); "Authentication failed - incorrect password entered!")
End if 