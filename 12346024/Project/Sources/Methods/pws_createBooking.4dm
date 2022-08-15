//%attributes = {"publishedSoap":true,"publishedWsdl":true}

C_POINTER:C301($tablePtr; $errorMessagePtr; $fieldPtr)
C_TEXT:C284($recordID; $0)



//______________________________________________________________________
C_TEXT:C284($1; $customerID)
C_BOOLEAN:C305($2; $isSell)
C_REAL:C285($3; $amount)
C_TEXT:C284($4; $currency)
C_REAL:C285($5; $ourRate)
C_TEXT:C284($6; $paymentMethod)
C_REAL:C285($7; $feeLC)
C_REAL:C285($8; $percentFee)
C_REAL:C285($9; $amountLC)
C_TEXT:C284($10; $instructions)

C_POINTER:C301($11)


SOAP DECLARATION:C782($1; Is text:K8:3; SOAP input:K46:1; "customerID")
SOAP DECLARATION:C782($2; Is boolean:K8:9; SOAP input:K46:1; "isCustomerBuying")

SOAP DECLARATION:C782($3; Is real:K8:4; SOAP input:K46:1; "amountForeign")
SOAP DECLARATION:C782($4; Is text:K8:3; SOAP input:K46:1; "Currency")
SOAP DECLARATION:C782($5; Is real:K8:4; SOAP input:K46:1; "exchangeRate")
SOAP DECLARATION:C782($6; Is text:K8:3; SOAP input:K46:1; "PaymentMethod")
SOAP DECLARATION:C782($7; Is real:K8:4; SOAP input:K46:1; "feeLocal")

SOAP DECLARATION:C782($8; Is real:K8:4; SOAP input:K46:1; "feePct")
SOAP DECLARATION:C782($9; Is real:K8:4; SOAP input:K46:1; "amountLocal")
SOAP DECLARATION:C782($10; Is text:K8:3; SOAP input:K46:1; "Instructions")

SOAP DECLARATION:C782($11; Is text:K8:3; SOAP output:K46:2; "ErrorMessage")
SOAP DECLARATION:C782($0; Is text:K8:3; SOAP output:K46:2; "CustomerID")

$customerID:=$1
$isSell:=$2
$amount:=$3
$currency:=$4
$ourRate:=$5
$paymentMethod:=$6
$feeLC:=$7
$percentFee:=$8
$amountLC:=$9
$instructions:=$10
$errorMessagePtr:=$11  // returns a value if failure

$tablePtr:=->[Bookings:50]

QUERY:C277([Customers:3]; [Customers:3]CustomerID:1=$customerID)

If (Records in selection:C76($tablePtr->)=1)  // booking can only be accepted for valid customers 
	READ WRITE:C146($tablePtr->)
	CREATE RECORD:C68($tablePtr->)
	$recordID:=makeCustomerID
	$errorMessagePtr->:=""
	
	[Bookings:50]BookingID:1:=$recordID
	[Bookings:50]CustomerID:2:=$customerID
	[Bookings:50]isSell:7:=$isSell
	[Bookings:50]Amount:9:=$amount
	[Bookings:50]Currency:10:=$currency
	[Bookings:50]ourRate:11:=$ourRate
	[Bookings:50]PaymentMethod:8:=$paymentMethod
	[Bookings:50]customerRemarks:14:=$instructions
	[Bookings:50]amountLocal:23:=$amountLC
	[Bookings:50]feeLocal:22:=$feeLC
	[Bookings:50]percentFee:21:=$percentFee
	
	[Bookings:50]BookingDate:3:=Current date:C33
	[Bookings:50]BookingTime:4:=Current time:C178
	[Bookings:50]BookedByUser:5:=""
	[Bookings:50]BookingMethod:6:="Web"
	
	[Bookings:50]isHonored:18:=False:C215
	[Bookings:50]isConfirmed:15:=False:C215
	
	SAVE RECORD:C53($tablePtr->)
	$recordID:=$fieldPtr->
	
	UNLOAD RECORD:C212($tablePtr->)
	READ ONLY:C145($tablePtr->)
	
	$0:=$recordID
	
Else 
	$errorMessagePtr->:="Customer does not exist in the database. Please create a profile first"
	$0:=""
End if 