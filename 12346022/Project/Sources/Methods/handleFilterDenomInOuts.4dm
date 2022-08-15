//%attributes = {}
//handleFilterDenomInOuts (denom; curr; received or paid or both {1,2,3} ) 
// 

C_LONGINT:C283(CBAPPLYDATERANGE)
C_DATE:C307(vFromDate; vToDate)
C_TEXT:C284($curr; $2)
C_REAL:C285($denom; $1)
C_LONGINT:C283($recPaid; $3)

Case of 
	: (Count parameters:C259=3)
		$denom:=$1
		$curr:=$2
		$recPaid:=$3
	Else 
		$denom:=500
		$curr:="EUR"
		$recPaid:=3
End case 



If (CBAPPLYDATERANGE=1)
	selectDateRangeTable(->[CashTransactions:36]; ->[CashTransactions:36]Date:5; vFromDate; vToDate; True:C214)
	RELATE MANY SELECTION:C340([CashInOuts:32]CashTransactionID:1)
Else 
	ALL RECORDS:C47([CashInOuts:32])
End if 

If ($denom>0)
	QUERY SELECTION:C341([CashInOuts:32]; [CashInOuts:32]Denomination:7=$denom)
End if 
If ($curr#"")
	QUERY SELECTION:C341([CashInOuts:32];  & ; [CashInOuts:32]Currency:6=$curr)
End if 


Case of 
	: ($recPaid=1)  // received
		QUERY SELECTION:C341([CashInOuts:32];  & ; [CashInOuts:32]QtyIN:8>0)
	: ($recPaid=2)  // paid
		QUERY SELECTION:C341([CashInOuts:32];  & ; [CashInOuts:32]QtyOut:9>0)
End case 


orderByCashInOuts