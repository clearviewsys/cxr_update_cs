//%attributes = {}
// handlePickCustomerIndustryC (form event; objectPtr; isForced)


C_LONGINT:C283($formEvent; $1)
C_POINTER:C301($objectPtr; $2)
C_BOOLEAN:C305($isForced; $3)

$formEvent:=$1
$objectPtr:=$2
$isForced:=$3

If (Form event code:C388=$formEvent)
	pickIndustryCode($objectPtr; $isForced)
	RELATE ONE:C42([Customers:3]IndustryCode:122)  // load the related industry 
End if 