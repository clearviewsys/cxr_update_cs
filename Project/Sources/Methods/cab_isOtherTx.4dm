//%attributes = {}
#DECLARE()->$isOtherTX : Boolean

$isOtherTX:=(Not:C34(chkLoan)) & (Not:C34(chkDeposit)) & (Not:C34(chkTransfer))

