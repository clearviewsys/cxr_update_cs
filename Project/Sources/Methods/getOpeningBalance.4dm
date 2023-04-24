//%attributes = {}
// getOpeningBalance (AccountID ; Date)
// this method uses the cache table [OpeningBalances] to return the value

#DECLARE($accountID : Text; $date : Date)->$balance : Real

If (Count parameters:C259=0)
	$accountID:="Accounts Receivable"
	$date:=Current date:C33
End if 

var $es : 4D:C1709.Entity
$es:=ds:C1482.OpeningBalances.query("accountID == :1 AND date <= :2 order by date desc"; $accountID; $date).first()

/* if the last transaction on record is the same day as the date request 
then return the opening balance of that day
otherwise 
return the end of the day balance of a previous date

for examle if we want the opening balance on Jan 1/1/2023
and the last transaction of that account was Oct 1/1/2022
then we need to return then closing day balance of Oct 1/1/2022 as the opening
balance
*/
If ($es=Null:C1517)
	$balance:=0
Else 
	
	If ($es.date=$date)
		$balance:=$es.openingBalance
	Else 
		$balance:=$es.closingBalance
	End if 
End if 


