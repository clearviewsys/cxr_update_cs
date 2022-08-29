//%attributes = {"publishedSoap":true,"publishedWsdl":true}
// pws_sendSMS(phone;message)

C_TEXT:C284($1; $2)
C_TEXT:C284($0)

SOAP DECLARATION:C782($1; Is text:K8:3; SOAP input:K46:1; "phone")
SOAP DECLARATION:C782($2; Is text:K8:3; SOAP input:K46:1; "message")
SOAP DECLARATION:C782($0; Is text:K8:3; SOAP output:K46:2; "error")

SMS_sendQuickMessageFromTiran($1; $2)
//$phone:=handlePhoneField (->$1)

$0:="Message Sent to "+$1

