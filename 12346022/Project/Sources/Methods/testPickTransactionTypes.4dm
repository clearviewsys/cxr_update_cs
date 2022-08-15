//%attributes = {}
C_TEXT:C284($pick)
C_LONGINT:C283($i)
C_POINTER:C301($tablePtr; $PickPtr; $descriptionPtr)
C_TEXT:C284($pickMethodName; $params)
$tablePtr:=->[TransactionTypes:93]
$PickPtr:=->[TransactionTypes:93]TransTypeID:1
$descriptionPtr:=->[TransactionTypes:93]Description:2

$pickMethodName:="Pick"+Table name:C256($tablePtr)

pickTransactionTypes($pickPtr; True:C214)
//Execute Method ($pickMethodName;$PickPtr;true)
myAlert($pick+CRLF+$PickPtr->+CRLF+$descriptionPtr->)
//
//EXECUTE METHOD($pickMethodName;$PickPtr;false)
//myAlert ($pick+CRLF +$PickPtr->+CRLF +$descriptionPtr->)