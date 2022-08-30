//%attributes = {"shared":true,"publishedWeb":true}
C_BOOLEAN:C305($0; $isPaid)

C_OBJECT:C1216($we)
C_TEXT:C284($payStatus)

$we:=New object:C1471
$we:=Create entity selection:C1512([WebEWires:149])
//$we:=ds.WebEWires.first()

$isPaid:=False:C215


If (OB Get type:C1230($we.first(); "paymentInfo")=Is null:K8:31)
Else 
	If (OB Is defined:C1231($we.first().paymentInfo))
		
		Case of 
			: ($we.first().paymentInfo.status="Completed")  //this has been paid so ok to create register
				$isPaid:=True:C214
			: ($we.first().paymentInfo.poliStatus="Completed")  //this has been paid so ok to create register
				$isPaid:=True:C214
			: ($we.first().paymentInfo.paymentData.status="Completed")  //this has been paid so ok to create register
				$isPaid:=True:C214
			Else 
				
				$payStatus:=setWebEwirePaymentStatus  //check the current status
				If ($payStatus="Completed")
					$isPaid:=True:C214
				End if 
				
		End case 
		
	End if 
End if 

$0:=$isPaid