//%attributes = {}
C_OBJECT:C1216($paymentInfo)
C_TEXT:C284($endpoint; $1)

C_TEXT:C284($token)
C_OBJECT:C1216($status; $entity; $record)
C_LONGINT:C283($i)

Case of 
	: (Count parameters:C259=1)
		$endpoint:=$1
	Else 
		assertInvalidNumberOfParams(Current method name:C684; Count parameters:C259)
End case 


$status:=New object:C1471
$status.success:=False:C215

ARRAY TEXT:C222($WEB_aNames; 0)
ARRAY TEXT:C222($WEB_aValues; 0)
WEB GET VARIABLES:C683($WEB_aNames; $WEB_aValues)

Case of 
	: ($endpoint="@4DHOOK/ADYEN")
		// Webhook recieved from Adyen, the payment gateway, after there is new info on payment status
		ADYEN_webhook($WEB_aNames{1})
		
		
	: ($endpoint="@4DHOOK/PAYPAL@")
		PAYPAL_listener($endpoint)
		
		
	: ($endpoint="@4DHOOK/POLI/NUDGE@")
		$token:=$WEB_aValues{Find in array:C230($WEB_aNames; "Token")}
		$status:=POLI_getForWebEwire($token)
		
		If ($status.success)
			WEB SEND TEXT:C677("200")
		Else 
			WEB SEND TEXT:C677("500")
		End if 
		
		
		
	: ($endpoint="@4DHOOK/PAYMARK/NUDGE@")
		C_TEXT:C284($reference)
		
		$reference:=$WEB_aValues{Find in array:C230($WEB_aNames; "reference")}
		$entity:=ds:C1482.WebEWires.query("WebEwireID == :1"; $reference)
		
		If ($entity.length=1)
			$record:=$entity.first()
			$record.paymentInfo.status:=""  //$WEB_aValues{Find in array($WEB_aNames;"transaction_status")}
			$record.paymentInfo.transactionId:=$WEB_aValues{Find in array:C230($WEB_aNames; "transaction_id")}
			
			If ($record.paymentInfo.paymentData=Null:C1517)
				$record.paymentInfo.paymentData:=New object:C1471
			End if 
			
			For ($i; 1; Size of array:C274($WEB_aNames))
				OB SET:C1220($record.paymentInfo.paymentData; $WEB_aNames{$i}; $WEB_aValues{$i})
			End for 
			
			$status:=$record.save()
			
			If ($status.success)
				$status:=PMARK_getForWebEwire($reference)
			End if 
			
		End if 
		
		If ($status.success)
			WEB SEND TEXT:C677("200")
		Else 
			WEB SEND TEXT:C677("500")
		End if 
		
End case 


