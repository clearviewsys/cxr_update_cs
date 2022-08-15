//%attributes = {}
C_OBJECT:C1216($adyenResponseObj)
C_TEXT:C284($adyenResponseText; $1; $success)
C_BOOLEAN:C305($readOnlyStatus)

Case of 
	: (Count parameters:C259=1)
		$adyenResponseText:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$adyenResponseObj:=JSON Parse:C1218($adyenResponseText)

WEB SEND TEXT:C677("[accepted]")  // Send back Message to Adyen saying we accepted their webhook

C_TEXT:C284($paymentLinkID; $currencyCode; $paymentSuccess; $paymentDate; $merchantReference; $paymentMethod; $pspReference; $eventCode; $actionPerformed; $originalReference)

C_LONGINT:C283($value)
$paymentLinkID:=$adyenResponseObj.notificationItems[0]["NotificationRequestItem"]["additionalData"]["paymentLinkId"]  // STRING
$value:=$adyenResponseObj.notificationItems[0]["amount"]["value"]  // INT
$currencyCode:=$adyenResponseObj.notificationItems[0]["amount"]["currency"]  // STRING
$paymentSuccess:=$adyenResponseObj.notificationItems[0]["success"]  // STRING 'true' OR 'false'
$paymentDate:=$adyenResponseObj.notificationItems[0]["eventDate"]  // STRING DATE/TIME OF PAYMENT - ISO
$merchantReference:=$adyenResponseObj.notificationItems[0]["merchantReference"]  // STRING INVOICEID or WEBEWIREID
$paymentMethod:=$adyenResponseObj.notificationItems[0]["paymentMethod"]  // String PAYMENT METHOD CODE ACCORDING TO ADYEN
$pspReference:=$adyenResponseObj.notificationItems[0]["pspReference"]  // STRING ORIGINAL REFERENCE TO PAYMENT

QUERY:C277([WebEWires:149]; [WebEWires:149]WebEwireID:1=$merchantReference)  //**NEED TO LOAD RECORD???**

$eventCode:=$adyenResponseObj.notificationItems[0]["eventCode"]  // STRING Reasaon for Recieveing webhook
$success:=$adyenResponseObj.notificationItems[0]["success"]  //STRING 'true' OR 'false'

$readOnlyStatus:=Read only state:C362([WebEWires:149])
READ WRITE:C146([WebEWires:149])
Repeat 
	LOAD RECORD:C52([WebEWires:149])
Until (Not:C34(Locked:C147([WebEWires:149])))

OBJ_newPaymentInfo(->[WebEWires:149]paymentInfo:35)

Case of 
	: ($eventCode="AUTHORISATION")
		If ($success="true")
			$paymentLinkID:=$adyenResponseObj.notificationItems[0]["NotificationRequestItem"]["additionalData"]["paymentLinkId"]  // STRING
			$value:=$adyenResponseObj.notificationItems[0]["amount"]["value"]  // INT
			$currencyCode:=$adyenResponseObj.notificationItems[0]["amount"]["currency"]  // STRING
			$paymentSuccess:=$adyenResponseObj.notificationItems[0]["success"]  // STRING 'true' OR 'false'
			$paymentDate:=$adyenResponseObj.notificationItems[0]["eventDate"]  // STRING DATE/TIME OF PAYMENT - ISO
			$merchantReference:=$adyenResponseObj.notificationItems[0]["merchantReference"]  // STRING INVOICEID or WEBEWIREID
			$paymentMethod:=$adyenResponseObj.notificationItems[0]["paymentMethod"]  // String PAYMENT METHOD CODE ACCORDING TO ADYEN
			$pspReference:=$adyenResponseObj.notificationItems[0]["pspReference"]  // STRING ORIGINAL REFERENCE TO PAYMENT
			
			[WebEWires:149]paymentInfo:35.status:="completed"
			[WebEWires:149]paymentInfo:35.TransactionRefNo:=$paymentLinkID
			[WebEWires:149]paymentInfo:35.BankReceiptDateTime:=$paymentDate
			[WebEWires:149]paymentInfo:35.AmountPaid:=$value
			[WebEWires:149]paymentInfo:35.MerchantReference:=$merchantReference
			[WebEWires:149]paymentInfo:35.pspReference:=$pspReference
			[WebEWires:149]status:16:=10
			//[WebEWires]paymentInfo.CompletionTime:=$return.history[0].CompletionTime
			//[WebEWires]paymentInfo.CustomerReference:=$return.history[0].CustomerReference
			//[WebEWires]paymentInfo.BankReceiptNo:=$return.history[0].BankReceiptNo
		Else 
			// WHAT IF IT ERRORS?
		End if 
		
	: ($eventCode="CANCEL_OR_REFUND")
		
		If ($success="true")
			$actionPerformed:=$adyenResponseObj.notificationItems[0]["NotificationRequestItem"]["additionalData"]["modification.action"]  // STRING
			$value:=$adyenResponseObj.notificationItems[0]["amount"]["value"]  // INT
			$currencyCode:=$adyenResponseObj.notificationItems[0]["amount"]["currency"]  // STRING
			$paymentSuccess:=$adyenResponseObj.notificationItems[0]["success"]  // STRING 'true' OR 'false'
			$paymentDate:=$adyenResponseObj.notificationItems[0]["eventDate"]  // STRING DATE/TIME OF PAYMENT - ISO
			$merchantReference:=$adyenResponseObj.notificationItems[0]["merchantReference"]  // STRING INVOICEID or WEBEWIREID
			$paymentMethod:=$adyenResponseObj.notificationItems[0]["paymentMethod"]  // String PAYMENT METHOD CODE ACCORDING TO ADYEN
			$pspReference:=$adyenResponseObj.notificationItems[0]["pspReference"]  // STRING NEW REFERENCE TO PAYMENT
			$originalReference:=$adyenResponseObj.notificationItems[0]["originalReference"]  // STRING THE ORIGINAL REFERENCE TO PAYMENT
			
			[WebEWires:149]paymentInfo:35.status:="canceled/refunded"
			[WebEWires:149]paymentInfo:35.TransactionRefNo:=$paymentLinkID
			[WebEWires:149]paymentInfo:35.BankReceiptDateTime:=$paymentDate
			[WebEWires:149]paymentInfo:35.AmountPaid:=$value
			[WebEWires:149]paymentInfo:35.MerchantReference:=$merchantReference
			[WebEWires:149]paymentInfo:35.pspReference:=$pspReference
			//[WebEWires]status:=10 ????????????????
			//[WebEWires]paymentInfo.CompletionTime:=$return.history[0].CompletionTime
			//[WebEWires]paymentInfo.CustomerReference:=$return.history[0].CustomerReference
			//[WebEWires]paymentInfo.BankReceiptNo:=$return.history[0].BankReceiptNo
		Else 
			// WHAT IF IT ERRORS?
		End if 
		
	Else 
End case 

[WebEWires:149]paymentInfo:35.gateway:="adyenlink"  //make sure it is set

SAVE RECORD:C53([WebEWires:149])

If ($readOnlyStatus)
	UNLOAD RECORD:C212([WebEWires:149])
	READ ONLY:C145([WebEWires:149])
	LOAD RECORD:C52([WebEWires:149])
End if 
