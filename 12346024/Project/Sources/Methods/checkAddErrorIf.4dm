//%attributes = {}
// checkAddErrorif(boolean isError;errorString)


C_BOOLEAN:C305($1; $condition)
C_TEXT:C284($2; $error)
C_TEXT:C284($str1; $str2; $str3; $3; $4; $5)
$str1:=""
$str2:=""
$str3:=""

Case of 
	: (Count parameters:C259=0)
		$condition:=True:C214
		$error:="error <X> <Y> <Z>"
		$str1:="ABC"
		$str2:="DEF"
		$str3:="GHI"
		
	: (Count parameters:C259=2)
		$condition:=$1
		$error:=$2
		
	: (Count parameters:C259=3)
		$condition:=$1
		$error:=$2
		$str1:=$3
		
	: (Count parameters:C259=4)
		$condition:=$1
		$error:=$2
		$str1:=$3
		$str2:=$4
		
	: (Count parameters:C259=5)
		$condition:=$1
		$error:=$2
		$str1:=$3
		$str2:=$4
		$str3:=$5
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

If ($condition)
	replaceXYZTags(->$error; $str1; $str2; $str3)
	checkAddError($error)
End if 