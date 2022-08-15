//%attributes = {}
C_DATE:C307($3; $currentDate; $expiryDate)
C_TIME:C306($2; $currentTime; $expiryTime)
C_TEXT:C284($1; $resetCode)
C_BOOLEAN:C305($0)
C_LONGINT:C283($dateDif)

Case of 
	: (Count parameters:C259=3)
		$resetCode:=$1
		$expiryTime:=$2
		$expiryDate:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$currentDate:=Current date:C33
$currentTime:=Current time:C178

$0:=False:C215

If ($resetCode#"")
	$dateDif:=Int:C8($expiryDate-$currentDate)
	
	If ($dateDif>0)
		$0:=True:C214
	Else 
		If ($dateDif=0)
			If ($expiryTime>$currentTime)
				$0:=True:C214
			End if 
		End if 
	End if 
	
End if 