//%attributes = {}

// Unit test is written
C_LONGINT:C283($1; $error)
C_TEXT:C284($0; $return)

$error:=$1
$return:=""

Case of 
	: ($error=1001)
		$return:="Invalid token"
		
	: ($error=1003)
		$return:="Invalid merchant code"
		
	: ($error=1004)
		$return:="Inactive merchant"
		
	: ($error=1005)
		$return:="Merchant not authenticated"
		
	: ($error=1011) | ($error=14053)
		$return:="Merchant per transaction limit exceeded"
		
	: ($error=1012) | ($error=14054)
		$return:="Merchant daily transaction limit exceeded"
		
	: ($error=1025) | ($error=14058)
		$return:="Invalid Specified Amount"
		
	: ($error=1014)
		$return:="Invalid URL format in Initiate Transaction"
		
	: ($error=1022)
		$return:="Mandatory field is missing"
		
	: ($error=1024)
		$return:="Invalid currency format"
		
	: ($error=3007)
		$return:="Invalid transaction status. A back-end exception has caused the transaction to fail."
		
	: ($error=4032)
		$return:="Unhandled exception. Data expected by POLi has not been returned by the financial institution."
		
	: ($error=4033)
		$return:="Unhandled HttpRequestException: Invalid or missing response from the financial institution"
		
	: ($error=4034)
		$return:="JavaScript execution failedData expected by POLi has not been returned by the financial institution."
		
	: ($error=11002)
		$return:="Problem delivering nudge to merchant."
		
	: ($error=14104)
		$return:="POLi Link has expired."
		
	: ($error=14151)
		$return:="POLi Link has been fully paid."
		
	Else 
		$return:="Unknown error: "+String:C10($error)
End case 


$0:=$return