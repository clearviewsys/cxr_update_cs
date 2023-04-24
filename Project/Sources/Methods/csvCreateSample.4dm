//%attributes = {}
var $definition; $toExport : Object
var $separator : Text

$separator:="|"

$definition:=New object:C1471

$definition.record_id:="139840650"
$definition.transaction_id:="001CHDP211232503"
$definition.transaction_type:="Versement Espèces"
$definition.branch_code:="001"
$definition.creation_date_stamp:="20210503"
$definition.flex_module:="RT"  // RT or ST or DE
$definition.value_date:="20210504"
$definition.transaction_date_stamp:="20210503"
$definition.transaction_code:="352"
$definition.flex_customer_id:="00111509"
// $definition.cxr_customer_id:=""
$definition.foreign_currency_amount:=50000.12
$definition.dr_br_ind:="D"  // D or C
$definition.exchange_rate:=177.721
$definition.local_currency_amount:=8886050.11
$definition.currency:="EUR"
$definition.flex_account_id:="AS1000000-011"
$definition.flex_user_id:="ASHI001"

var $i : Integer
For ($i; 1; 10000)
	
	$toExport:=New object:C1471
	
	$toExport.transaction_type:=csvCreateSampleGetRandom("transaction_type")
	$toExport.branch_code:=csvCreateSampleGetRandom("branch_code")
	$toExport.flex_module:=csvCreateSampleGetRandom("flex_module")
	$toExport.transaction_code:=csvCreateSampleGetRandom("transaction_code")
	$toExport.dr_br_ind:=csvCreateSampleGetRandom("dr_br_ind")
	$toExport.currency:=csvCreateSampleGetRandom("currency")
	
	If ($toExport.currency="USD")
		$toExport.exchange_rate:=217.15
	Else 
		$toExport.exchange_rate:=177.721
	End if 
	
	
End for 

