//%attributes = {}
// checkAddWarning (errorString)
// checkAddWarning (errorString; str1)
// checkAddWarning (errorString; str1; str2)
// checkAddWarning (errorString; str1; str2; str3)

// Add a warning message replacing XYZ Tags if needed
// i.e: checkAddWarning ([Countries]isSanctioned;getLocalizedErrorMessage (4162)) 
// Modified by CVS Dev. Team on 2/20/2017


C_TEXT:C284($1; $warning)
C_TEXT:C284($str1; $str2; $str3; $2; $3; $4)
$str1:=""
$str2:=""
$str3:=""

Case of 
	: (Count parameters:C259=0)
		$warning:="error <X> <Y> <Z>"
		$str1:="ABC"
		$str2:="DEF"
		$str3:="GHI"
		
	: (Count parameters:C259=1)
		$warning:=$1
	: (Count parameters:C259=2)
		$warning:=$1
		$str1:=$2
	: (Count parameters:C259=3)
		$warning:=$1
		$str1:=$2
		$str2:=$3
	: (Count parameters:C259=4)
		$warning:=$1
		$str1:=$2
		$str2:=$3
		$str3:=$4
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

$warning:=Replace string:C233($warning; "<X>"; $str1)
$warning:=Replace string:C233($warning; "<Y>"; $str2)
$warning:=Replace string:C233($warning; "<Z>"; $str3)

Case of 
	: (<>warningLevel=0)
		
	: (<>warningLevel=1)
		<>CheckWarnings:=<>CheckWarnings+CRLF+$warning
		
	: (<>warningLevel=2)
		checkAddError($warning)
End case 
