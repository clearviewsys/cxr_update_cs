//%attributes = {}
// writetoBBox (cashier; posID;invoiceSerial; $debitLocal;$creditLocal;$invoiceID;$responsePtr;$isCopy)-> boolean:success
// 

C_TEXT:C284($cashier; $1)
C_TEXT:C284($posID; $2)
C_LONGINT:C283($invoiceNo; $3)
C_REAL:C285($debitLocal; $4)
C_REAL:C285($creditLocal; $5)
C_TEXT:C284($invoiceID; $6)
C_POINTER:C301($responsePtr; $7)
C_BOOLEAN:C305($isCopy; $8)  // Send true if it's a COPY, otherwise, it's a normal receipt RECEIPT_NORMAL
C_DATE:C307($invoiceDate; $9)
C_TIME:C306($invoiceTime; $10)

C_TEXT:C284($errorString)


C_BOOLEAN:C305(spSuccess; $0)
spSuccess:=False:C215

C_TEXT:C284(<>organizationNo; <>CBcontrolBoxID; <>CBcommandPath; <>CBportName; <>CBbaudRate; <>CBcontrolFlow)

C_TEXT:C284($orgNo; $commandPath; $portName; $baudRate; $controlFlow)

$orgNo:=Quotify(<>organizationNo)
$commandPath:=<>CBcommandPath
$portName:=<>CBportName
$baudRate:=<>CBbaudRate
$controlFlow:=<>CBcontrolFlow

Case of 
		
		
	: (Count parameters:C259=6)
		$cashier:=Quotify($1)
		$posID:=Quotify($2)
		$invoiceNo:=$3
		$debitLocal:=$4
		$creditLocal:=$5
		$invoiceID:=$6
		$responsePtr:=->$errorString
		$isCopy:=False:C215
		
	: (Count parameters:C259=10)
		$cashier:=Quotify($1)
		$posID:=Quotify($2)
		$invoiceNo:=$3
		$debitLocal:=$4
		$creditLocal:=$5
		$invoiceID:=$6
		$responsePtr:=$7
		$isCopy:=$8
		$invoiceDate:=$9
		$invoiceTime:=$10
		
	Else 
		$cashier:=Quotify(<>CBcashier)
		$posID:=Quotify(<>CBposID)
		$invoiceNo:=100
		$debitLocal:=1234.56
		$creditLocal:=0
		$invoiceID:="INV1000"
		$responsePtr:=->$errorString
		$invoiceDate:=Current date:C33
		$invoiceTime:=Current time:C178
		
End case 

C_TEXT:C284($commandPath; $portName; $baudRate; $controlFlow; $connectionString; $orgNo; $posID; $cashier; $dateTime; $invoiceID; $invoiceSerial; $receiptType; $receiptTotal; $negativeTotal; $vat; $spc)
C_TEXT:C284($year; $month; $day; $hour; $min)
C_TEXT:C284($input; spOutputString; spErrorString)
//$connectionString:=Quotify ("COM5:19200,DTR")
$connectionString:=Quotify($portName+":"+$baudRate+","+$controlFlow)


$year:=String:C10(Year of:C25($invoiceDate); "####")
$month:=String:C10(Month of:C24($invoiceDate); "0#")
$day:=String:C10(Day of:C23($invoiceDate); "0#")
$hour:=String:C10($invoiceTime\3600; "00")
$min:=String:C10(($invoicetime\60)%60; "00")
$spc:=" "

$datetime:=Quotify($year+$month+$day+$hour+$min)
$invoiceSerial:=Quotify(String:C10($invoiceNo))

Case of 
	: ($isCopy=True:C214)
		$receiptType:=Quotify("RECEIPT_COPY")
	Else 
		$receiptType:=Quotify("RECEIPT_NORMAL")
End case 

If ($debitLocal>0)  // received local currency (means selling)
	$receiptTotal:=Quotify(swedifyFormat($debitLocal))
	$negativeTotal:=Quotify(swedifyFormat(0))
Else   // paid local currency
	$receiptTotal:=Quotify(swedifyFormat(-$creditLocal))  // this should be a negative number
	$negativeTotal:=Quotify(swedifyFormat($creditLocal))  // this is a positive number
End if 

$vat:=Quotify("0,00;0,00")
$input:=$connectionString+$spc+$orgNo+$spc+$posID+$spc+$cashier+$spc+$datetime+$spc+$invoiceSerial+$spc+$receiptType+$spc+$receiptTotal+$spc+$negativeTotal+$spc
$input:=$input+$vat+$spc+$vat+$spc+$vat+$spc+$vat


LAUNCH EXTERNAL PROCESS:C811($commandPath+" "+$input; $input; spOutputString; spErrorString)
// [ConnectionString] [OrganisationNumber] [PosId] [Cashier] [Datetime] [ReceiptId] [ReceiptType] [ReceiptTotal] [NegativeTotal] [Vat1] [Vat2] [Vat3] [Vat4]


If (Position:C15("ERROR"; spOutputString)>0)  // the result code contains an error
	spSuccess:=False:C215
Else 
	
	If (stringStartsWith(spOutputString; "STATUS_OK"))  // used to be RC_SUCCESS
		spSuccess:=True:C214
	Else 
		spSuccess:=False:C215
	End if 
End if 


If (spErrorString#"")
	spSuccess:=False:C215
End if 

$0:=spSuccess

createControlBoxLogRecord(<>CBcontrolBoxID; $invoiceID; $invoiceNo; $input; spOutputString; spErrorString; spSuccess)

C_LONGINT:C283(spQuitRequested)

spQuitRequested:=200
Repeat   // this process stays alive until the client application quits it
	spQuitRequested:=spQuitRequested-1
Until (spQuitRequested=1)

$responsePtr->:=spOutputString