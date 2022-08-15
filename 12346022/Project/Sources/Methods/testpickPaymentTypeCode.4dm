//%attributes = {}
C_TEXT:C284($code)
C_LONGINT:C283($i)
$code:=""
// [countries];"pick"
For ($i; 1; 2)
	pickPaymentTypeCode(->$code)
	myAlert($code+CRLF+[PaymentTypes:116]PaymentType:3)
	$code:=""
End for 