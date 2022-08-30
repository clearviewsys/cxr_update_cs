//%attributes = {}
// generateHashMD5 (text); returns a 32 chars text

C_TEXT:C284($1; $obj)
C_TEXT:C284($hash)

Case of 
	: (Count parameters:C259=0)
		$obj:="hello world"
	: (Count parameters:C259=1)
		$obj:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$hash:=Generate digest:C1147($obj; MD5 digest:K66:1)
ASSERT:C1129(Length:C16($hash)=32; "Hash MD5 length should be 32 chars")
$0:=$hash
