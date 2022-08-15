C_REAL:C285(vAmountReceived; vAmountPaid)

handleListForm
RELATE ONE:C42([AccountInOuts:37]CustomerID:2)
handlePaidReceivedDisplayDetail([AccountInOuts:37]Amount:7; [AccountInOuts:37]isPaid:9; ->vAmountReceived; ->vAmountPaid)
colourizeAlternateRows