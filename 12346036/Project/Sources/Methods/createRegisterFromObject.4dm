//%attributes = {}
// createRegisterRecord (recordObj): registerID
// #ORDA #Classic
// this method takes one object param and creates a register record by mapping the member functions to the Register record fields

C_OBJECT:C1216($obj; $1)
C_TEXT:C284($registerID; $0)

Case of 
	: (Count parameters:C259=0)  // testing
		$obj:=newRegisterObject
		
	: (Count parameters:C259=1)
		$obj:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 

ASSERT:C1129($obj#Null:C1517; "Obj is not instantiated")
READ WRITE:C146([Registers:10])

If ($obj.registerID="")  //create
	CREATE RECORD:C68([Registers:10])
	$obj.registerID:=makeRegisterID
	[Registers:10]RegisterID:1:=$obj.registerID
Else   // load to modify
	QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=$obj.registerID)
	LOAD RECORD:C52([Registers:10])
End if 


[Registers:10]InvoiceNumber:10:=$obj.invoiceID
[Registers:10]OurRate:25:=Num:C11($obj.rate)

[Registers:10]percentFee:28:=Num:C11($obj.commission)
[Registers:10]feeLocal:29:=Num:C11($obj.feeLC)

[Registers:10]SpotRate:26:=Num:C11($obj.marketRate)
[Registers:10]baseCURR:60:=$obj.baseCurrency
[Registers:10]Currency:19:=$obj.currency
[Registers:10]isTransfer:3:=(Num:C11($obj.isTransfer)=1)
[Registers:10]isTrade:38:=(Num:C11($obj.isTrade)=1)
[Registers:10]Credit:7:=Num:C11($obj.credit)
[Registers:10]Debit:8:=Num:C11($obj.debit)
[Registers:10]CreditLocal:24:=Num:C11($obj.creditLC)
[Registers:10]DebitLocal:23:=Num:C11($obj.debitLC)
[Registers:10]isReceived:13:=(Num:C11($obj.debit)>0)
[Registers:10]RegisterType:4:=$obj.registerType

[Registers:10]CustomerID:5:=$obj.customerID
[Registers:10]RegisterDate:2:=Date:C102(String:C10($obj.date))

[Registers:10]AccountID:6:=$obj.accountID
[Registers:10]InternalTableNumber:17:=Num:C11($obj.tableNo)
[Registers:10]InternalRecordID:18:=$obj.recordID

[Registers:10]Comments:9:=$obj.comments
[Registers:10]BranchID:39:=$obj.branchID
[Registers:10]isCash:40:=(Num:C11($obj.isCash)=1)
[Registers:10]eWireID:61:=$obj.eWireID
[Registers:10]PresetBuyRate:42:=Num:C11($obj.presetBuyRate)
[Registers:10]PresetSellRate:43:=Num:C11($obj.presetSellRate)
[Registers:10]SubAccountID:58:=$obj.subAccountID
[Registers:10]tax1_Paid:33:=Num:C11($obj.tax1Paid)
[Registers:10]tax1_Received:31:=Num:C11($obj.tax1Received)
[Registers:10]tax2_Paid:34:=Num:C11($obj.tax2Paid)
[Registers:10]tax2_Received:32:=Num:C11($obj.tax2Received)

$0:=[Registers:10]RegisterID:1

SAVE RECORD:C53([Registers:10])
UNLOAD RECORD:C212([Registers:10])
READ ONLY:C145([Registers:10])