//%attributes = {}
// checkAddError (error; {str1;...str3})
//ads an error replacing X, Y, Z with str1 to str3

// Modified by CVS Dev. Team on 2/20/2017


C_TEXT:C284($1; $error)
C_TEXT:C284($str1; $str2; $str3; $2; $3; $4)
$str1:=""
$str2:=""
$str3:=""

Case of 
	: (Count parameters:C259=0)
		
		$error:="error <X> <Y> <Z>"
		$str1:="ABC"
		$str2:="DEF"
		$str3:="GHI"
		
	: (Count parameters:C259=1)
		$error:=$1
		
	: (Count parameters:C259=2)
		
		$error:=$1
		$str1:=$2
		
	: (Count parameters:C259=3)
		
		$error:=$1
		$str1:=$2
		$str2:=$3
		
	: (Count parameters:C259=4)
		$error:=$1
		$str1:=$2
		$str2:=$3
		$str3:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

replaceXYZTags(->$error; $str1; $str2; $str3)
<>CheckErrors:=<>CheckErrors+Char:C90(Carriage return:K15:38)+$error

