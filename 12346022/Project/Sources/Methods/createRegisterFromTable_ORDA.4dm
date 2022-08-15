//%attributes = {}
// createRegisterFromTable (->table; branchID; obj)-> success:boolean

C_POINTER:C301($tablePtr; $1)
C_TEXT:C284($branchID; $2)
C_OBJECT:C1216($obj; $entity; $status; $3)
C_BOOLEAN:C305($0)

Case of 
	: (Count parameters:C259=0)
		$obj:=New object:C1471
		$tablePtr:=->[CashTransactions:36]
		$branchID:=getBranchID
		$obj.RegisterID:=""
		$obj.CustomerID:=ds:C1482.Customers.query("FullName='a@'")[Random:C100%10].CustomerID
		$obj.RegisterDate:=Current date:C33
		$obj.AccountID:=ds:C1482.Accounts.all()[Random:C100%20].AccountID
		$obj.Currency:=$obj.relatedAccount.ISO4217
		$obj.OurRate:=ds:C1482.Currencies.query("ISO4217 = :1"; $obj.Currency)[0].OurBuyRateLocal
		$obj.Debit:=Random:C100%3000
		$obj.DebitLocal:=$obj.Debit*$obj.OurRate
		$obj.feeLocal:=10
		
		
	: (Count parameters:C259=3)
		$tablePtr:=$1
		$branchID:=$2
		$obj:=$3
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


If ($obj.RegisterID="")  //create
	$entity:=ds:C1482.Registers.new()
	$obj.RegisterID:=makeRegisterID
	
Else   // load to modify
	$entity:=ds:C1482.Registers.query("RegisterID = :1"; $obj.RegisterID)[0]
	$obj.modBranchID:=$branchID
End if 

$entity.fromObject($obj)  // map all the fields
$status:=$entity.save()
If ($status.success)
	$0:=True:C214
Else 
	$0:=False:C215
End if 
