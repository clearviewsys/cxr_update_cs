//%attributes = {}
// getFacebookURL (handle) : URL
C_TEXT:C284($1; $0; $URL; $handle)

Case of 
	: (Count parameters:C259=0)
		$handle:="tiranbehrouz"
	: (Count parameters:C259=1)
		$handle:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$url:="https://www.facebook.com/"+$handle

$0:=$URL