//%attributes = {}
// #methodname (objectAsEntity: object) : boolean
// returns true if success

// #ORDA
// Create a register from scratch

C_OBJECT:C1216($obj; $1; $entity; $status)
C_BOOLEAN:C305($0)

Case of 
	: (Count parameters:C259=0)
		$obj:=New object:C1471
		$obj.RegisterID:=makeRegisterID
		$obj.CustomerID:=ds:C1482.Customers.query("FullName='a@'")[Random:C100%10].CustomerID
		$obj.RegisterDate:=Current date:C33
		$obj.AccountID:=ds:C1482.Accounts.all()[Random:C100%20].AccountID
		$obj.Currency:=$obj.relatedAccount.ISO4217
		$obj.OurRate:=ds:C1482.Currencies.query("ISO4217 = :1"; $obj.Currency)[0].OurBuyRateLocal
		$obj.Debit:=Random:C100%3000
		$obj.DebitLocal:=$obj.Debit*$obj.OurRate
		//[Currencies]
		//[Registers]debit
	: (Count parameters:C259=1)
		$obj:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$entity:=ds:C1482.Registers.new()
$entity.fromObject($obj)  // map all the fields
$entity.UUID:=Generate UUID:C1066

$status:=$entity.save()
If ($status.success)
	$0:=True:C214
Else 
	$0:=False:C215
End if 