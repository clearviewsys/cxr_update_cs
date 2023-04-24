//%attributes = {}
// getRegisterTaxSums (->tax1Rec;->tax1Paid;->tax1Balance;->tax2Rec;->tax2Paid;->tax2Balance)
// 


C_POINTER:C301($1; $2; $3; $4; $5; $6; $7)
C_POINTER:C301($tax1receivedPtr; $tax1PaidPtr; $tax1BalancePtr; $tax2receivedPtr; $tax2PaidPtr; $tax2BalancePtr)

$tax1receivedPtr:=$1
$tax1PaidPtr:=$2
$tax1BalancePtr:=$3
$tax2receivedPtr:=$4
$tax2PaidPtr:=$5
$tax2BalancePtr:=$6

$tax1receivedPtr->:=Sum:C1([Registers:10]tax1_Received:31)
$tax1PaidPtr->:=Sum:C1([Registers:10]tax1_Paid:33)
$tax1BalancePtr->:=$tax1receivedPtr->-$tax1PaidPtr->

$tax2receivedPtr->:=Sum:C1([Registers:10]tax2_Received:32)
$tax2PaidPtr->:=Sum:C1([Registers:10]tax2_Paid:34)
$tax2BalancePtr->:=$tax2receivedPtr->-$tax2PaidPtr->

