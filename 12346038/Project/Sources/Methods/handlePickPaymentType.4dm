//%attributes = {}
// handlePickPaymentType (->PaymentTypeCode; ->PaymentType;  forceDialog)
C_POINTER:C301($fieldPtr; $fieldPtr2; $1; $2)
C_BOOLEAN:C305($isForced; $3)

Case of 
	: (Count parameters:C259=2)
		$fieldPtr:=$1
		$fieldPtr2:=$2
		$isForced:=False:C215
	: (Count parameters:C259=3)
		$fieldPtr:=$1
		$fieldPtr2:=$2
		$isForced:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

pickPaymentTypeCode($fieldPtr; $isForced)
If (OK=1)
	$fieldPtr2->:=[PaymentTypes:116]PaymentType:3
End if 