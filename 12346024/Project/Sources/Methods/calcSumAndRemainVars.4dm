//%attributes = {}

vTotalReceived:=Sum:C1([Registers:10]Debit:8)
vTotalPaid:=Sum:C1([Registers:10]Credit:7)
vRemainReceive:=vFromAmount-vTotalReceived
vRemainPaid:=vToAmount-vTotalPaid