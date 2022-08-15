//%attributes = {}
C_OBJECT:C1216($o)
//[Registers]AccountID
//[Accounts]isCashAccount
//[Registers]Currency
$o:=ds:C1482.Registers.query("relatedAccount.isCashAccount = true AND Currency='USD'")  // finds the related accounts that are cash
$o:=$o.query("DebitLocal >= 10000")  // find the registers who have local debit greater than 10K

//[Registers]DebitLocal
//[Registers]UnrealizedGain
