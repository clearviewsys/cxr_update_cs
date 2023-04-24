//%attributes = {}
// buildOpeningBalances
// rebuilds the OpeningBalance cache for each account from scratch

// start for one account


var $contextAcc; $contextReg; $status : Object
var $registers; $accounts; $dayRegisters : 4D:C1709.EntitySelection
var $register; $account; $record : 4D:C1709.Entity
var $accountID : Text
var $date : Date
var $registerDates : Collection
var $sum; $balance; $opening : Real
var $success : Object

// #optimization
$contextAcc:=New object:C1471("context"; "contextAcc")
ds:C1482.setRemoteContextInfo("contextAcc"; ds:C1482.Accounts; "AccountID")


$accounts:=ds:C1482.Accounts.all($contextAcc)

$contextReg:=New object:C1471("context"; "contextReg")
ds:C1482.setRemoteContextInfo("contextReg"; ds:C1482.Registers; "RegisterDate, AccountID, Debit, Credit")

$success:=ds:C1482.AccountBalances.all().drop()

If ($success.success)
	For each ($account; $accounts)
		$accountID:=$account.AccountID
		// start from the beginning of the registers
		
		// find all the unique dates 
		$registers:=ds:C1482.Registers.query("AccountID == :1 order by RegisterDate"; $accountID; $contextReg)
		$registerDates:=$registers.toCollection("RegisterDate").distinct("RegisterDate")
		
		$opening:=0  // reset the opening balance for account and start accumulating from the first date
		
		
		For each ($date; $registerDates)
			
			// go through the dates and create the opening balance accumulation
			var $sumDebit; $sumCredit : Real
			$dayRegisters:=$registers.query("RegisterDate == :1"; $date)
			$sumDebit:=$dayRegisters.sum("Debit")
			$sumCredit:=$dayRegisters.sum("Credit")
			$balance:=$sumDebit-$sumCredit
			// store the opening balance in the record here
			//MARK: STORE OPENING BALANCE HERE
			//[OpeningBalances]
			
			$record:=ds:C1482.OpeningBalances.new()
			$record.accountID:=$accountID
			$record.date:=$date
			$record.openingBalance:=$opening
			$record.closingBalance:=$opening+$balance
			$status:=$record.save()
			
			// update the opening balance
			$opening+=$balance  // add the day balance to the opening balance of last day
			
			If ($status.success=False:C215)
				ASSERT:C1129(False:C215)
				break
			End if 
			
		End for each 
		
	End for each 
End if 
