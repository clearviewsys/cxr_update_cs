//%attributes = {}
// createRegisterFromTable (
// $registerID:=createRegisterFromTable (vBranchID; $tablePtr;externalRef;vInvoiceNumber;"";vInvoiceDate;vUserID;$account;$amount;$curr;False;->vFullComments;0;0;$rate;$spotRate;$customerID;$amountLocal;$isTransfer;$tax1;$tax2;$currencyAlias;$boardBuyRate;$boardSellRate)

C_TEXT:C284($branchID; $1)
C_POINTER:C301($tablePtr; $2)
C_TEXT:C284($externalReference; $3)
C_TEXT:C284($invoiceNumber; $4)
C_TEXT:C284($registerId; $5)
C_DATE:C307($registerDate; $6)
C_TEXT:C284($userID; $7)

C_TEXT:C284($accountID; $8)
C_TEXT:C284($subAccountID; $9)
C_TEXT:C284($referenceNo; $10)


C_REAL:C285($amount; $11)
C_TEXT:C284($currency; $12)

C_BOOLEAN:C305($isReceived; $13)
//C_DATE($issueDate;$12)
//C_DATE($dueDate;$13)

C_POINTER:C301($autoCommentPtr; $14)
C_REAL:C285($percentFee; $15)
C_REAL:C285($feeLocal; $16)
C_REAL:C285($ourRate; $17)
C_REAL:C285($spotRate; $18)
C_TEXT:C284($customerID; $19)
C_REAL:C285($amountLocal; $20)
C_BOOLEAN:C305(isInternalInvoice; $isTransfer; $21)
C_REAL:C285($tax1; $22)

C_REAL:C285($tax2; $23)
C_TEXT:C284($currencyAlias; $24)
C_REAL:C285($boardBuyRate; $25)
C_REAL:C285($boardSellRate; $26)



C_TEXT:C284($0)

$branchID:=$1
$tablePtr:=$2
$externalReference:=$3
$invoiceNumber:=$4
$registerId:=$5
$registerDate:=$6
$userID:=$7

$accountID:=$8
$subAccountID:=$9
$referenceNo:=$10

$amount:=$11
$currency:=$12

$isReceived:=$13
$autoCommentPtr:=$14
$percentFee:=$15
$feeLocal:=roundToBase($16)
$ourRate:=$17
$spotRate:=$18
$CustomerID:=$19
$amountLocal:=roundToBase($20)
$isTransfer:=$21
$tax1:=$22
$tax2:=$23
$currencyAlias:=$24
$boardBuyRate:=$25
$boardSellRate:=$26

C_BOOLEAN:C305($condition)
$condition:=($accountID#"") & ($currency#"") & ($customerID#"")

If ($condition)
	READ WRITE:C146([Registers:10])
	ASSERT:C1129($currency#"")
	ASSERT:C1129($accountID#"")
	
	If ($registerID="")  //create
		CREATE RECORD:C68([Registers:10])
		[Registers:10]RegisterID:1:=makeRegisterID
		[Registers:10]BranchID:39:=$branchID
		
	Else   // load to modify
		QUERY:C277([Registers:10]; [Registers:10]RegisterID:1=$registerID)
		LOAD RECORD:C52([Registers:10])
		[Registers:10]modBranchID:63:=$branchID
	End if 
	
	//[Registers]BranchID:=$branchID `2/22/16 IBB
	[Registers:10]InvoiceNumber:10:=$invoiceNumber
	[Registers:10]RegisterDate:2:=$registerDate
	
	[Registers:10]isTransfer:3:=$isTransfer
	
	If (isInternalInvoice)
		$ourRate:=$spotRate
		$feeLocal:=0
		$percentFee:=0
	End if 
	
	[Registers:10]OurRate:25:=$ourRate  // our rate
	[Registers:10]SpotRate:26:=$spotRate  // market rate
	[Registers:10]percentFee:28:=$percentFee
	[Registers:10]feeLocal:29:=$feeLocal
	[Registers:10]isReceived:13:=$isReceived
	[Registers:10]totalFees:30:=calcRegisterTotalFees(0; $amount; $ourRate; $percentFee; $feeLocal)
	
	//$amount*$ourRate*($percentFee/100)+$feeLocal   ` cheanged in version 3.550
	
	If ($isReceived)  // Received / Buy
		[Registers:10]Debit:8:=$amount
		[Registers:10]Credit:7:=0
		[Registers:10]DebitLocal:23:=$amountLocal
		[Registers:10]CreditLocal:24:=0
		
		[Registers:10]RegisterType:4:="Buy"
		[Registers:10]tax1_Paid:33:=$tax1
		[Registers:10]tax2_Paid:34:=$tax2
		[Registers:10]tax1_Received:31:=0
		[Registers:10]tax2_Received:32:=0
		
	Else   // paid / Sell
		[Registers:10]Debit:8:=0
		[Registers:10]Credit:7:=$amount
		[Registers:10]DebitLocal:23:=0
		[Registers:10]CreditLocal:24:=$amountLocal
		
		[Registers:10]RegisterType:4:="Sell"
		[Registers:10]tax1_Paid:33:=0
		[Registers:10]tax2_Paid:34:=0
		[Registers:10]tax1_Received:31:=$tax1
		[Registers:10]tax2_Received:32:=$tax2
	End if 
	
	[Registers:10]Currency:19:=$currency
	[Registers:10]CustomerID:5:=$customerID
	[Registers:10]CreatedByUserID:16:=$userID
	
	[Registers:10]AccountID:6:=$accountID
	[Registers:10]SubAccountID:58:=$subAccountID
	[Registers:10]ReferenceNo:57:=$referenceNo
	
	[Registers:10]InternalTableNumber:17:=Table:C252($tablePtr)
	[Registers:10]InternalRecordID:18:=$externalReference
	
	[Registers:10]CurrencyAlias:41:=$currencyAlias
	[Registers:10]PresetBuyRate:42:=$boardBuyRate
	[Registers:10]PresetSellRate:43:=$boardSellRate
	
	
	If ($autoCommentPtr->#"")
		[Registers:10]AutoComments:12:=False:C215
		[Registers:10]Comments:9:=$autoCommentPtr->
	Else 
		[Registers:10]AutoComments:12:=True:C214
	End if 
	
	$0:=[Registers:10]RegisterID:1
	
	SAVE RECORD:C53([Registers:10])
	UNLOAD RECORD:C212([Registers:10])
	READ ONLY:C145([Registers:10])
End if 