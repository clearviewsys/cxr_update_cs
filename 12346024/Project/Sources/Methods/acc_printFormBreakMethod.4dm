//%attributes = {}


C_REAL:C285(vSubtotalBalanceLocal; vSumMarketValues)
C_REAL:C285(vSubTotalDebitsLocal; vSubTotalCreditsLocal; vSubTotalFees; vSubTotalUnrealizedGains)
C_REAL:C285(vTotalDebitsLocal; vTotalCreditsLocal; vTotalFees; vTotalUnrealizedGains; vUnrealizedGains)
C_LONGINT:C283(vRowPerBreak)

vTotalDebitsLocal:=vTotalDebitsLocal+vSubtotalDebitsLocal
vTotalCreditsLocal:=vTotalCreditsLocal+vSubtotalCreditsLocal
vTotalFees:=vTotalFees+vSubtotalFees
vTotalUnrealizedGains:=vTotalUnrealizedGains+vSubTotalUnrealizedGains


vSubtotalBalanceLocal:=0
vSumMarketValues:=0
vSubTotalDebitsLocal:=0
vSubTotalCreditsLocal:=0
vSubTotalFees:=0
vSubTotalUnrealizedGains:=0

vSubtotalDebits:=0
vSubtotalCredits:=0
vSubtotalBalance:=0


vRowPerBreak:=0