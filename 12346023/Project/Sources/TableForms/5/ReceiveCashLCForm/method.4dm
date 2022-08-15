
C_REAL:C285(vCashReceived; vCashReceivable; vChangePayable)

//vChangePayable:=vCashReceived-vCashReceivable

setVisibleIff((vChangePayable#0); "change@")
setVisibleIff((vChangePayable<0); "rectNegChange")

