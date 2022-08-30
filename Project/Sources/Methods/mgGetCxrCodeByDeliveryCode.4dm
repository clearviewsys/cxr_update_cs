//%attributes = {}


C_TEXT:C284($1; $mgDelivery)
C_TEXT:C284($0; $code)


$mgDelivery:=$1
$code:=""

Case of 
	: ($mgDelivery="WILL_CALL")
		$code:="D"
	: ($mgDelivery="DIRECT_TO_ACCT")  // mobile wallet
		$code:="N-M"
	: ($mgDelivery="BANK_DEPOSIT")
		$code:="N"
	: ($mgDelivery="HDS_USD")  // home delivery
		$code:="D-HDUSD"
	: ($mgDelivery="HDS_LOCAL")  // home delivery
		$code:="D-HDLOC"
	Else 
		$code:="D"
End case 
// other options: LTD_WILLCALL ( and HDS_USD(home delivery)

$0:=$code