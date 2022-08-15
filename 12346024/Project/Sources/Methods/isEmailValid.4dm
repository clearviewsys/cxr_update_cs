//%attributes = {}
C_OBJECT:C1216($result)
C_TEXT:C284($responseStatus)
C_TEXT:C284($email; $1)
C_LONGINT:C283($valid; $0)  // 0 -> error ; 1 -> valid ; 2 -> invalid

Case of 
	: (Count parameters:C259=1)
		$email:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$result:=validateEmailWithZeroBounce($email)
If ($result.message#"success")
	// What happens is there is an error?
	myAlert($result.message+"\n"+"Please try again later.")
	$valid:=0
Else 
	$responseStatus:=$result.response.status
	If ($responseStatus="invalid")
		$valid:=2
	Else 
		$valid:=1
	End if 
End if 
$0:=$valid