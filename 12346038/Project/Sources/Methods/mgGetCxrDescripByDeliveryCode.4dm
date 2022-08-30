//%attributes = {}


C_TEXT:C284($1; $mgDelivery)
C_TEXT:C284($0; $code)


$mgDelivery:=$1
$code:=""

Case of 
	: ($mgDelivery="WILL_CALL")
		$code:="Cash"
	: ($mgDelivery="DIRECT_TO_ACCT")  // mobile wallet
		$code:="Mobile Wallet"
	: ($mgDelivery="BANK_DEPOSIT")
		$code:="Bank Transfer"
	: ($mgDelivery="HDS_USD")  // home delivery
		$code:="Home Delivery - USD"
	: ($mgDelivery="HDS_LOCAL")  // home delivery
		$code:="Home Delivey Local CCY"
	Else 
		$code:="Cash"
End case 
// other options: LTD_WILLCALL ( and HDS_USD(home delivery)

$0:=$code