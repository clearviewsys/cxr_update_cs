//%attributes = {}


C_TEXT:C284($1; $code)
C_TEXT:C284($0; $mgDelivery)

$code:=$1
$mgDelivery:=""

Case of 
	: ($code="D")
		$mgDelivery:="WILL_CALL"
	: ($code="N-M")  // mobile wallet
		$mgDelivery:="DIRECT_TO_ACCT"
	: ($code="N")
		$mgDelivery:="BANK_DEPOSIT"
	: ($code="D-HDUSD")  // home delivery
		$mgDelivery:="HDS_USD"
	: ($code="D-HDLOC")  // home delivery
		$mgDelivery:="HDS_LOCAL"
	Else 
		$mgDelivery:="WILL_CALL"
End case 
// other options: LTD_WILLCALL ( and HDS_USD(home delivery)

$0:=$mgDelivery