//%attributes = {}
// selectCitiStateByZipCode (zipCode)
C_TEXT:C284($zip; $1)
C_LONGINT:C283($0; $n)

$zip:=$1

QUERY:C277([ZipCodes:63]; [ZipCodes:63]ZipCode:2=$zip)
$n:=Records in selection:C76([ZipCodes:63])
If ($n>0)
	RELATE ONE:C42([ZipCodes:63]LastLineKey:1)  // select the city
	RELATE ONE:C42([Cities:60]; [Cities:60]StateCode:2)  // select the state
	RELATE ONE:C42([Cities:60]; [Cities:60]CountryCode:4)  // select the country
End if 

$0:=$n